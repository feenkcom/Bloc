"
I am a special type of {{gtClass:BlShortcutHandler}} designed to forward keyboard events to other elements. If any of those elements handles a given shortcut, the event handlings stops there. If none of those elements handles the given shortcut, the shortcut is handled by the shortcut handler of the original element.BlShortcutForwardingHandler
BlShortcutForwardingHandler

Users can test it in the following scenario with the following keys:
- `c` key to increase index,
- `s` key to show a blue element to which shortcut events are forwarded,
- `h` key to hide the blue element,
- `d` key to disable shortcut event forwarding from the red element to the blue element,
- `e` key to enable shortcut event forwarding from the red element to the blue element,
- `x` key represents a usecase of event filters and appends red or blue text to the footer.

If shorcuts do not work, try to click on the red element to request focus.
{{gtExample:BlShortcutForwardingHandlerExamples>>#sceneOne | noCode }}



"
Class {
	#name : #BlShortcutForwardingHandler,
	#superclass : #BlShortcutHandler,
	#traits : 'TBlElementQuery',
	#classTraits : 'TBlElementQuery classTrait',
	#instVars : [
		'targetQuery',
		'shortcutHandler',
		'targetObject'
	],
	#category : #'BlocPac-ElementQuery-Events-Handler'
}

{ #category : #'api - adding / removing' }
BlShortcutForwardingHandler >> addShortcut: aBlShortcut [
	"Return a shortcut handler with an added given shortcut.
	Note: The returned instance may or may not be the same as the receiver"

	<return: #BlShortcutHandler>
	shortcutHandler := shortcutHandler addShortcut: aBlShortcut.
	^ self
]

{ #category : #'private - accessing' }
BlShortcutForwardingHandler >> eventClass [
	^ BlShortcutEvent
]

{ #category : #'api - accessing' }
BlShortcutForwardingHandler >> eventsToHandle [
	"I return a collection of element types I may be interested in"

	<return: #Collection of: #'BlEvent class'>
	^ {BlShortcutEvent}
]

{ #category : #'api - event managing' }
BlShortcutForwardingHandler >> filterEvent: aShortcutEvent [
	self
		forwardEvent: aShortcutEvent
		do: [ :aHandler | aHandler filterEvent: aShortcutEvent ]
		ifConsumed: [ ^ self ]
		ifNotConsumed: [ shortcutHandler filterEvent: aShortcutEvent ]
]

{ #category : #'private - event handling' }
BlShortcutForwardingHandler >> forwardEvent: aShortcutEvent do: aHandlerBlock ifConsumed: aConsumedBlock ifNotConsumed: aNotConsumedBlock [
	| anElement |
	anElement := targetObject ifNil: [ aShortcutEvent currentTarget ].
	anElement
		ifNotNil: [ | someElements |
			someElements := (targetQuery asBlocResolvedElementsFrom: anElement)
					asCollection.
			someElements
				ifNotEmpty: [ | aTarget aCurrentTarget |
					aTarget := aShortcutEvent target.
					aCurrentTarget := aShortcutEvent currentTarget.
					someElements
						do: [ :eachElement | 
							eachElement eventDispatcher shortcutHandler
								ifNotNil: [ :aHandler | 
									(aHandler wantsEvent: aShortcutEvent)
										ifTrue: [ aShortcutEvent forwardingTarget: eachElement.
											aHandlerBlock value: aHandler ].
									aShortcutEvent isConsumed
										ifTrue: [ ^ aConsumedBlock value ] ] ].
					aShortcutEvent
						target: aTarget;
						currentTarget: aCurrentTarget ] ].

	^ aNotConsumedBlock value
]

{ #category : #'api - adding / removing' }
BlShortcutForwardingHandler >> forwardShortcuts [
	^ self
]

{ #category : #'api - event managing' }
BlShortcutForwardingHandler >> handleEvent: aShortcutEvent [
	self
		forwardEvent: aShortcutEvent
		do: [ :aHandler | aHandler handleEvent: aShortcutEvent ]
		ifConsumed: [ ^ self ]
		ifNotConsumed: [ shortcutHandler handleEvent: aShortcutEvent ].
]

{ #category : #initialization }
BlShortcutForwardingHandler >> initialize [
	super initialize.

	"original shortcut handler"
	shortcutHandler := BlShortcutHandlerWithoutShortcuts uniqueInstance.
	
	"empty selector, which means we apply it on the widget itself"
	targetQuery := BlElementLazyQuery new
]

{ #category : #'api - adding / removing' }
BlShortcutForwardingHandler >> noForwardShortcuts [
	<return: #BlShortcutHandler>
	^ shortcutHandler
]

{ #category : #accessing }
BlShortcutForwardingHandler >> queryStep: aBlElementStep [
	targetQuery queryStep: aBlElementStep
]

{ #category : #'api - adding / removing' }
BlShortcutForwardingHandler >> removeAllWithCombination: aBlKeyCombination [
	"Return a shortcut handler without all shortcuts with a given key combination.
	Note: The returned instance may or may not be the same as the receiver"
	<return: #BlShortcutHandler>

	shortcutHandler := shortcutHandler removeAllWithCombination: aBlKeyCombination.
	^ self
]

{ #category : #'api - adding / removing' }
BlShortcutForwardingHandler >> removeShortcut: aBlShortcut [
	"Return a shortcut handler without a given shortcut.
	Note: The returned instance may or may not be the same as the receiver"
	<return: #BlShortcutHandler>

	shortcutHandler := shortcutHandler removeShortcut: aBlShortcut. 
	^ self
]

{ #category : #accessing }
BlShortcutForwardingHandler >> shortcutHandler [
	^ shortcutHandler
]

{ #category : #accessing }
BlShortcutForwardingHandler >> shortcutHandler: anObject [
	shortcutHandler := anObject
]

{ #category : #accessing }
BlShortcutForwardingHandler >> shortcuts [
	<return: #Collection of: #BlBasicShortcut>

	^ shortcutHandler shortcuts
]

{ #category : #accessing }
BlShortcutForwardingHandler >> targetObject: anElement [
	"Set an element in which to search the forwarding elements."

	targetObject := anElement
]

{ #category : #'api - event managing' }
BlShortcutForwardingHandler >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]

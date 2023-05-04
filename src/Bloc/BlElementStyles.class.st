"
#Element styles
Is a special type of {{gtClass:BlAbstractStyles}} which is assigned to an {{gtClass:BlElement}}. There should be just one instance of {{gtClass:BlElementStyles}} per element. Whenever styles are added or removed, {{gtClass:BlElementStyles}} notifies its {{gtClass:BlElement}} that styles have been changed, which triggers the recomputation of the styles and properties of the graphical scene. See {{gtMethod:BlElement>>#requestStyle}}.
##Accessing element styles
{{gtMethod:BlElement>>#styles}} returns existing element styles.
##Adding styles
A {{gtClass:BlElementStyle}} can be added to the styles with the help of {{gtMethod:BlElementStyles>>#addStyle:}}. As previously shortly mentioned, there can be just one {{gtClass:BlElementStyle}} per {{gtClass:BlElementState}}.
An important extra step in adding styles is an addition of an optional {{gtClass:BlBasicEventHandler}} to the element. A {{gtClass:BlElementState}} can implement {{gtMethod:BlElementState>>#optionalEventHandlerDo:}} whose goal is to provide {{gtClass:BlElementStyles}} with an event handler that should be added to the element when a new style for that state is added to the element. That optional event handler is an essential part of the behavior for some styles. Consider a style for a {{gtClass:BlElementPressedState}}. By default, an element does not have any behavior to add or remove {{gtClass:BlElementPressedState}} when it is being pressed, which makes sense. It only becomes necessary, when there is a style which is interested in a specific state to be added or removed. In the case of {{gtClass:BlElementPressedState}}, a custom {{gtClass:BlElementPressedStateEventHandler}} is added to the element, which encapsulates the logic of managing pressed state based on mouse events.

## Removing styles
A {{gtClass:BlElementStyle}} can be removed from the styles with the help of {{gtMethod:BlElementStyles>>#removeStyle:}}. Similarly to the logic of adding new styles, removing existing styles is not based on the identity of the intended style to remove, but instead based on its state and properties. In fact, removing a style is practically the same as removing a set of properties of that style. The difference in behavior when removing styles from the {{gtClass:BlElementStyles}} is only related to the optional event handlers that are removed when a style for a state is removed from the element. The explanation of why an optional event handler is needed can be found in the section ""Adding styles"".

"
Class {
	#name : #BlElementStyles,
	#superclass : #BlAbstractStyles,
	#instVars : [
		'styles',
		'statelessStyles',
		'previousAppliedStyles',
		'isDirty',
		'element'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #'adding / removing' }
BlElementStyles >> addStatelessStyles: aBlStatelessStyles [
	statelessStyles add: aBlStatelessStyles.
	self element requestStyle
]

{ #category : #'adding / removing' }
BlElementStyles >> addStyle: aStyle [
	(self stylesCollectionForStyle: aStyle)
		add: aStyle.
	self onStyleAdded: aStyle
]

{ #category : #'adding / removing' }
BlElementStyles >> addStyles: aCollectionOfStyles [
	aCollectionOfStyles do: [ :eachStyle | self addStyle: eachStyle ]
]

{ #category : #private }
BlElementStyles >> applyStylesForStates: aCollectionOfStates [
	"Apply all styles that match given states on an element"
	| theNewAppliedStyles |

	theNewAppliedStyles := self matchingStyles: aCollectionOfStates.

	(previousAppliedStyles difference: theNewAppliedStyles)
		ifNotEmpty: [ :theStylesToRemove | theStylesToRemove do: [ :eachStyle |
			eachStyle cleanUpOnElement: self element ] ].

	theNewAppliedStyles do: [ :eachStyle | eachStyle applyOnElement: self element ].
	previousAppliedStyles := theNewAppliedStyles asSet.

	isDirty := false
]

{ #category : #accessing }
BlElementStyles >> element [
	^ element
]

{ #category : #accessing }
BlElementStyles >> element: anObject [
	element := anObject
]

{ #category : #initialization }
BlElementStyles >> initialize [
	super initialize.
	
	styles := SortedCollection sortUsing: [ :a :b | a key priority < b key priority ].
	statelessStyles := Set new.
	isDirty := true.
	previousAppliedStyles := Set new
]

{ #category : #accessing }
BlElementStyles >> markDirty [
	isDirty := true
]

{ #category : #private }
BlElementStyles >> matchingProperties [
	"An utility debug method to get all currently matching properties"

	^ (self matchingStyles: self element states allStates) asArray flatCollect: [ :eachStyle | eachStyle properties ]
]

{ #category : #private }
BlElementStyles >> matchingStyles [
	"An utility debug method to get all currently matching styles"

	^ self matchingStyles: self element states allStates
]

{ #category : #private }
BlElementStyles >> matchingStyles: theStates [
	^ Array streamContents: [ :aStream | self matchingStyles: theStates do: [ :eachStyle | aStream nextPut: eachStyle ] ]
]

{ #category : #private }
BlElementStyles >> matchingStyles: theStates do: aBlock [
	styles do: [ :eachAssociation |
		(eachAssociation key matches: theStates)
			ifTrue: [ eachAssociation value do: aBlock ] ].
		
	statelessStyles do: [ :eachStatelessStyles |
		eachStatelessStyles stylesDo: [ :eachStyle |
			(eachStyle state matches: theStates)
				ifTrue: [ aBlock value: eachStyle ] ] ]
]

{ #category : #testing }
BlElementStyles >> needsStyle [
	^ isDirty
]

{ #category : #'private - adding' }
BlElementStyles >> onStyleAdded: aStyle [
	aStyle state optionalEventHandlerDo: [ :anEventHandler |
		(self element hasEventHandler: anEventHandler)
			ifFalse: [ self element addEventHandler: anEventHandler ] ].

	self element requestStyle
]

{ #category : #'private - adding' }
BlElementStyles >> onStyleRemoved: aStyle [
	"should we also removed properties when removing style? we need more examples"
	self flag: #TODO.
	"self element properties removeProperties: aStyle properties."
	
	aStyle state optionalEventHandlerDo: [ :anEventHandler |
		(self element hasEventHandler: [ :eachHandler | eachHandler = anEventHandler ])
			ifFalse: [ self element removeEventHandler: anEventHandler ] ].

	self element requestStyle
]

{ #category : #'adding / removing' }
BlElementStyles >> removeStatelessStyles: aBlStatelessStyles [
	statelessStyles
		remove: aBlStatelessStyles
		ifAbsent: [ ^ self ].
	
	self element requestStyle
]

{ #category : #'adding / removing' }
BlElementStyles >> removeStyle: aStyle [			
	(self stylesCollectionForStyle: aStyle)
		remove: aStyle
		ifAbsent: [ ^ self ].
	self onStyleRemoved: aStyle
]

{ #category : #'adding / removing' }
BlElementStyles >> removeStyles: aCollectionOfStyles [
	aCollectionOfStyles do: [ :eachStyle | self removeStyle: eachStyle ]
]

{ #category : #'private - adding' }
BlElementStyles >> stylesCollectionForState: aState [
	<return: #OrderedCollection>

	^ self
		stylesCollectionForState: aState
		ifFound: [ :aCollection | aCollection ]
		ifNone: [
			| aNewCollection |
			aNewCollection := OrderedCollection new.
			styles add: aState -> aNewCollection.
			aNewCollection ]
]

{ #category : #'private - adding' }
BlElementStyles >> stylesCollectionForState: aState ifFound: aFoundBlock ifNone: aNoneBlock [
	^ styles
		detect: [ :eachAssociation | eachAssociation key = aState ]
		ifFound: [ :anAssociation | aFoundBlock cull: anAssociation value ]
		ifNone: aNoneBlock
]

{ #category : #'private - adding' }
BlElementStyles >> stylesCollectionForStyle: aStyle [
	<return: #OrderedCollection>

	^ self stylesCollectionForState: aStyle state
]

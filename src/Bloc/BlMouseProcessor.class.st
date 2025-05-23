"
I am an event processor.
I convert basic events to more complex events.
For example, i generate events like click, dbl click, drag&drop, ... from mouse down, mouse up, and mouse move events.

Mouse actions are blocked during drag

"
Class {
	#name : #BlMouseProcessor,
	#superclass : #BlBaseEventProcessor,
	#instVars : [
		'lastEnteredTargets',
		'lastOverTarget',
		'lastClickEvent',
		'currentDragTarget',
		'lastMouseTarget',
		'dndInProgress',
		'dragStartMask',
		'pressedButtons',
		'dragState',
		'previousMouseDownEvent',
		'doubleClickEnabled'
	],
	#classInstVars : [
		'StartDragThreshold',
		'DoubleClickDelay'
	],
	#category : #'Bloc-Space - Events'
}

{ #category : #'event testing' }
BlMouseProcessor >> canBeClickEvent: aMouseUpEvent [
	^ dndInProgress not
		and: [ previousMouseDownEvent isNotNil
				and: [ previousMouseDownEvent primaryButtonPressed
						and: [ "aMouseUpEvent target = previousMouseDownEvent target"
							((aMouseUpEvent position - previousMouseDownEvent position) r <= self startDragThreshold) ] ] ]
]

{ #category : #'event testing' }
BlMouseProcessor >> canBeDoubleClickEvent: aMouseUpEvent [

	self flag: 'aMouseUpEvent target = lastClickEvent target is in fact needed, however, it breaks the Phlow list'.
	self flag: 'https://github.com/feenkcom/gtoolkit/issues/708'.

	self isDoubleClickEnabled
		ifFalse: [ ^ false ].
	
	^ (self canBeClickEvent: aMouseUpEvent) 
		and: [ lastClickEvent isNotNil
			and: [ "(aMouseUpEvent target = lastClickEvent target)"
					((aMouseUpEvent position - lastClickEvent position) r <= self startDragThreshold)
				and: [ aMouseUpEvent timestamp - lastClickEvent timestamp < self doubleClickDelay ] ] ]
]

{ #category : #'event testing' }
BlMouseProcessor >> canBeDoublePressEvent: aMouseDownEvent [

	self flag: 'aMouseUpEvent target = lastClickEvent target is in fact needed, however, it breaks the Phlow list'.
	self flag: 'https://github.com/feenkcom/gtoolkit/issues/708'.

	self isDoubleClickEnabled
		ifFalse: [ ^ false ].
	
	^ previousMouseDownEvent isNotNil
		and: [ "(aMouseDownEvent target = previousMouseDownEvent target)"
			((aMouseDownEvent position - previousMouseDownEvent position) r <= self startDragThreshold)
			and: [ aMouseDownEvent timestamp - previousMouseDownEvent timestamp < self doubleClickDelay ] ]
]

{ #category : #'event testing' }
BlMouseProcessor >> canStartDrag: aMouseMoveEvent [
	<return: #Boolean>

	^ (pressedButtons includes: BlMouseButton primary)
		and: [ previousMouseDownEvent isNotNil
			and: [ previousMouseDownEvent primaryButtonPressed
				and: [ (aMouseMoveEvent position - previousMouseDownEvent position) r > self startDragThreshold ] ] ]
]

{ #category : #'as yet unclassified' }
BlMouseProcessor >> disableDoubleClick [
	doubleClickEnabled := false
]

{ #category : #accessing }
BlMouseProcessor >> doubleClickDelay [
	^ Bloc doubleClickDelay
]

{ #category : #'as yet unclassified' }
BlMouseProcessor >> enableDoubleClick [
	doubleClickEnabled := true
]

{ #category : #accessing }
BlMouseProcessor >> enteredTargets [
	<return: #Collection of: #BlElement>

	^ lastEnteredTargets
]

{ #category : #'event processing' }
BlMouseProcessor >> fillTargetHierarchy: aTarget [
	^ Array streamContents: [ :aStream |
		aStream nextPut: aTarget.
		aTarget allParentsDo: [ :aParentElement | aStream nextPut: aParentElement  ] ]
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsDragEndEvent: anEvent [
	| aDragEvent |
	
	aDragEvent := BlDragEndEvent new
		copyFrom: anEvent;
		yourself.
	
	self fireEvent:
			(aDragEvent
				startButtons: dragStartMask;
				target: currentDragTarget;
				gestureSource: currentDragTarget;
				dragboard: self space dragboard;
				yourself).
	
	aDragEvent isConsumed
		ifFalse: [ self space dispatchEvent: (BlSpaceDragCancelEvent new position: aDragEvent position) ]
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsDragEnterEvent: anEvent targets: aCollection [
	aCollection
		do: [ :t | 
			self dispatchEvent:
					(anEvent asDragEnterEvent
						startButtons: dragStartMask;
						target: t;
						gestureSource: currentDragTarget;
						canBePropagated: false;
						yourself)
				target: t ]
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsDragEvent: anEvent [
	self	fireEvent:
			(anEvent asDragEvent
				startButtons: dragStartMask;
				target: currentDragTarget;
				gestureSource: currentDragTarget;
				dragboard: self space dragboard;
				yourself)
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsDragLeaveEvent: anEvent targets: aCollection [
	aCollection
		do:	[ :t | 
			self dispatchEvent:
					(anEvent asDragLeaveEvent
						startButtons: dragStartMask;
						target: t;
						gestureSource: currentDragTarget;
						canBePropagated: false;
						yourself)
					target: t ]
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsDragStartEvent: anEvent [
	^ self fireEvent:
			(anEvent asDragStartEvent
				startButtons: dragStartMask;
				target: anEvent target;
				gestureSource: anEvent target;
				yourself)
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsDropEvent: anEvent [
	| aDropEvent |

	aDropEvent := BlDropEvent new
		copyFrom: anEvent;
		yourself.
		
	self fireEvent: (aDropEvent
		gestureSource: currentDragTarget;
		gestureTarget: anEvent target;
		startButtons: dragStartMask;
		dragboard: self space dragboard;
		target: anEvent target;
		yourself)
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsEnterEvent: anEvent targets: aCollection [
	aCollection
		do:	[ :t | 
			self dispatchEvent:
					(anEvent asMouseEnterEvent
						target: t;
						canBePropagated: false;
						yourself)
					target: t ]
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsMouseLeaveEvent: anEvent targets: aCollection [
	aCollection
		do:	[ :t | 
			self dispatchEvent:
					(anEvent asMouseLeaveEvent
						target: t;
						canBePropagated: false;
						yourself)
					target:t ]
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsMouseOutEvent: aMouseEvent [
	self fireEvent: (aMouseEvent asMouseOutEvent target: lastOverTarget)
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsMouseOutEvent: aMouseEvent targets: aCollection [
	aCollection do: [ :eachElement |
		self fireEvent: (aMouseEvent asMouseOutEvent target: eachElement) ]
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsMouseOverEvent: aMouseEvent [
	self fireEvent: aMouseEvent asMouseOverEvent 
]

{ #category : #'event processing' }
BlMouseProcessor >> generateEvents [
	((lastEnteredTargets, { lastOverTarget }) reject: [ :eachElement | eachElement isNil or: [ eachElement space == self space ] ]) asSet
		ifNotEmpty: [ :removedEnteredTargets |
			| aMouseEvent |
			
			aMouseEvent := BlMouseEvent new
				button: (pressedButtons ifEmpty: [ nil ] ifNotEmpty: [ pressedButtons anyOne ]);
				position: 0@0;
				screenPosition: 0@0.
			
			self fireAsMouseLeaveEvent: aMouseEvent targets: removedEnteredTargets.
			self fireAsMouseOutEvent: aMouseEvent targets: removedEnteredTargets ].
	
	lastEnteredTargets := lastEnteredTargets select: [ :eachElement | eachElement isAttachedToSceneGraph ].
	(lastOverTarget notNil and: [ lastOverTarget space ~~ self space ])
		ifTrue: [ lastOverTarget := nil ].
	
	(self isMouseEventValid: previousMouseDownEvent)
		ifFalse: [ previousMouseDownEvent ifNotNil: [ :anEvent | anEvent resetTargets ] ].

	(self isMouseEventValid: lastClickEvent)
		ifFalse: [ lastClickEvent ifNotNil: [ :anEvent | anEvent resetTargets ] ]
]

{ #category : #'mouse down' }
BlMouseProcessor >> handleMouseDown: aMouseDownEvent [
	| aTargetElement |

	"First we need to register a pressed button"
	self pressedButtons add: aMouseDownEvent button.

	aTargetElement := self processPicking: aMouseDownEvent.
	aMouseDownEvent target: aTargetElement.

	self fireEvent: aMouseDownEvent.
	
	(self canBeDoublePressEvent: aMouseDownEvent)
		ifTrue: [ self fireEvent: aMouseDownEvent asDoublePressEvent ].

	"now we can update the cursor from the target"
	self updateCursorFrom: aTargetElement.

	"store last mouse down event"
	previousMouseDownEvent := aMouseDownEvent
]

{ #category : #'mouse entered / left' }
BlMouseProcessor >> handleMouseEntered: aSpaceMouseEnterEvent [
]

{ #category : #'mouse entered / left' }
BlMouseProcessor >> handleMouseLeft: aSpaceMouseLeaveEvent [
	lastEnteredTargets do: [ :eachEnteredTarget |
		| anEvent |
		
		anEvent := self isDragging
			ifTrue: [ BlDragLeaveEvent new
				startButtons: dragStartMask;
				gestureSource: currentDragTarget ]
			ifFalse: [ BlMouseLeaveEvent new ].

		anEvent
			position: 0@0;
			target: eachEnteredTarget;
			canBePropagated: false;
			timestamp: self space time now.
		
		self dispatchEvent: anEvent target: eachEnteredTarget ].
	
	lastEnteredTargets := #().
	lastOverTarget := nil
]

{ #category : #'mouse move' }
BlMouseProcessor >> handleMouseMove: aMouseMoveEvent [
	| aTargetElement shouldTryDragStart |
	"picking and mouse move"
	
	aTargetElement := self processPicking: aMouseMoveEvent.

	self
		assert: [ aTargetElement isAttachedToSceneGraph ]
		description: [ 'Target element must be attached to the scene graph' ].
	
	aMouseMoveEvent target: aTargetElement.
	aMouseMoveEvent button: (pressedButtons ifEmpty: [ nil ] ifNotEmpty: [ pressedButtons anyOne ]).

	shouldTryDragStart := self isDragging
		ifFalse: [ (self canStartDrag: aMouseMoveEvent) ]
		ifTrue: [ false ].

	self isDragging
		"we are dragging, handle it as drag move"
		ifTrue: [ self processDragMove: aMouseMoveEvent ]
		ifFalse: [ shouldTryDragStart
			ifTrue: [ (self tryDragStart: previousMouseDownEvent)
				"we sent drag start, have to send first drag move"
				ifTrue: [ self processDragMove: aMouseMoveEvent ]
				"drag start was not handled, process as basic mouse move"
				ifFalse: [ self processMouseMove: aMouseMoveEvent ] ]
			"no need to even try to start a drag"
			ifFalse: [ self processMouseMove: aMouseMoveEvent ] ]
]

{ #category : #'mouse up' }
BlMouseProcessor >> handleMouseUp: aMouseUpEvent [
	"DragEnd, Simple click and Dbl click"
	| aTargetElement |
	
	"if mouse button was not registered as pressed we can ignore this particular event"
	(self pressedButtons includes: aMouseUpEvent button)
		ifFalse: [ ^ self ].

	"we need to unregister a button"
	self pressedButtons remove: aMouseUpEvent button.

	aTargetElement := self processPicking: aMouseUpEvent.
	aMouseUpEvent target: aTargetElement.

	"depending on whether drag and drop is in process handle mouse up either
	as mouse up itself or as drag end event"
	self isDragging
		ifTrue: [ self processDragEnd: aMouseUpEvent ]
		ifFalse: [ self processMouseUp: aMouseUpEvent ]
]

{ #category : #'initialize-release' }
BlMouseProcessor >> initialize [
	super initialize.
	lastEnteredTargets := #().
	dragStartMask := 0.
	dndInProgress := false.
	doubleClickEnabled := true.

	"a set of currently pressed mouse buttons button"
	pressedButtons := Set new.
	dragState := BlMouseDragState new
]

{ #category : #'as yet unclassified' }
BlMouseProcessor >> isDoubleClickEnabled [
	^ doubleClickEnabled ifNil: [ true ]
]

{ #category : #testing }
BlMouseProcessor >> isDragging [
	"Return true if drag and drop is in process, false otherwise"
	<return: #Boolean>
	
	^ dndInProgress
]

{ #category : #private }
BlMouseProcessor >> isMouseEventValid: anEvent [
	anEvent
		ifNil: [ ^ false ].
	
	(({ anEvent target . anEvent currentTarget . anEvent source } reject: [ :eachElement | eachElement isNil ])
		anySatisfy: [ :eachTargetElement |
			| eachTargetSpace |
			eachTargetSpace := (eachTargetElement isKindOf: BlSpace)
				ifTrue: [ eachTargetElement ]
				ifFalse: [ eachTargetElement space ].
			(eachTargetSpace ~~ self space) ])
				ifTrue: [ ^ false ].
	
	^ true
]

{ #category : #'event testing' }
BlMouseProcessor >> isValidDragTarget: aEvent [
	^ (aEvent target = self space root) not
]

{ #category : #accessing }
BlMouseProcessor >> lastClickEvent [
	<return: #BlClickEvent or: nil>

	^ lastClickEvent
]

{ #category : #accessing }
BlMouseProcessor >> lastOverTarget [
	<return: #BlElement>

	^ lastOverTarget
]

{ #category : #'initialize-release' }
BlMouseProcessor >> onSpaceClosed [
	lastEnteredTargets := #().
	lastOverTarget := nil.
	lastClickEvent := nil.
	currentDragTarget := nil.
	lastMouseTarget := nil.
	dndInProgress := false.
	dragStartMask := 0.
	pressedButtons := Set new.
	previousMouseDownEvent := nil
]

{ #category : #'event processing' }
BlMouseProcessor >> postProcess: aMouseEvent [
	
]

{ #category : #'event processing' }
BlMouseProcessor >> preProcess: aMouseEvent [
	| aTarget |
	
	aTarget := self processPicking: aMouseEvent.

	aMouseEvent target: aTarget.

	"mouse move is only fired when no dnd is in progress (else it is a drag event)"
	dndInProgress ifFalse: [ self fireEvent: aMouseEvent ].
	"now we can update the cursor from the target"
	self updateCursorFrom: aTarget
]

{ #category : #accessing }
BlMouseProcessor >> pressedButtons [
	"Return a collection of currently pressed mouse buttons"
	<return: #Collection of: #BlMouseButton>

	^ pressedButtons
]

{ #category : #accessing }
BlMouseProcessor >> previousMouseDownEvent [
	<return: #BlElement or: nil>

	^ previousMouseDownEvent
]

{ #category : #'mouse drag' }
BlMouseProcessor >> processDragEnd: aMouseUpEvent [

	self
		assert: [ self isDragging ]
		description: [ 'Can not process mouse up event as drag end if I am not in dragging state' ].
		
	self
		assert: [ currentDragTarget isNotNil ]
		description: [ 'When we drag something it can not be nil' ].

	aMouseUpEvent primaryButtonPressed
		ifTrue: [
			self fireAsDropEvent: aMouseUpEvent.
			self fireAsDragEndEvent: aMouseUpEvent.

			currentDragTarget := nil.
			dndInProgress := false.
			lastOverTarget := nil.
			dragStartMask := 0 ]
]

{ #category : #'mouse drag' }
BlMouseProcessor >> processDragMove: aMouseMoveEvent [

	"check drag"
	self fireAsDragEvent: aMouseMoveEvent.

	"dragstart/drag events management"
	currentDragTarget ifNotNil: [ self subprocessDragEnterExitEvent: aMouseMoveEvent ].

	"update last overed target"
	lastOverTarget := aMouseMoveEvent target
]

{ #category : #'mouse move' }
BlMouseProcessor >> processMouseEnterLeaveEvent: aMouseEvent [
	| newLeavedTargets newEnteredTargets currentEnteredTargets |

	"mouse is moved over the same element, no need to process enter/leave events"
	lastOverTarget = aMouseEvent target
		ifTrue: [ ^ self ].

	currentEnteredTargets := self fillTargetHierarchy: aMouseEvent target.
	
	"fire mouseout to the previous overed target"
	lastOverTarget isNotNil
		ifTrue: [ self fireAsMouseOutEvent: aMouseEvent ].
	
	"fire mouse leave events"
	newLeavedTargets := lastEnteredTargets reject: [ :anElement | (currentEnteredTargets includes: anElement) ].
	newLeavedTargets := newLeavedTargets select: #isAttachedToSceneGraph.

	self fireAsMouseLeaveEvent: aMouseEvent targets: newLeavedTargets.
	
	"fire mouse event to the current target"
	self fireAsMouseOverEvent: aMouseEvent.
	
	"fire enter events"
	newEnteredTargets := currentEnteredTargets reject: [ :anElement | lastEnteredTargets includes: anElement ].
	self fireAsEnterEvent: aMouseEvent targets: newEnteredTargets.

	lastOverTarget := aMouseEvent target.
	lastEnteredTargets := currentEnteredTargets
]

{ #category : #'mouse move' }
BlMouseProcessor >> processMouseMove: aMouseMoveEvent [
	self processMouseEnterLeaveEvent: aMouseMoveEvent.

	self fireEvent: aMouseMoveEvent.

	"now we can update the cursor from the target"
	self updateCursorFrom: aMouseMoveEvent target.
	
]

{ #category : #'event handling entrypoint' }
BlMouseProcessor >> processMouseScroll: aMouseScrollEvent [
	"picking and mouse move"
	self preProcess: aMouseScrollEvent.
	"does nothing for the moment"
	self postProcess: aMouseScrollEvent
]

{ #category : #'mouse up' }
BlMouseProcessor >> processMouseUp: aMouseUpEvent [
	| canBeClick canBeDoubleClick |
	self fireEvent: aMouseUpEvent.
	
	self updateCursorFrom: aMouseUpEvent target.

	canBeClick := self canBeClickEvent: aMouseUpEvent.
	canBeDoubleClick := self canBeDoubleClickEvent: aMouseUpEvent.

	canBeClick
		ifTrue: [
			| aClickEvent |
			aClickEvent := aMouseUpEvent asClickEvent.
			self fireEvent: aClickEvent.
			
			lastClickEvent := aClickEvent copy ].

	canBeDoubleClick
		ifTrue: [
			| doubleClickEvent doubleClickTargetElement |
			
			lastClickEvent := nil.
			
			doubleClickEvent := aMouseUpEvent asDoubleClickEvent.
			doubleClickTargetElement := self processPicking: doubleClickEvent.
			doubleClickEvent target: doubleClickTargetElement.
			self fireEvent: doubleClickEvent ]
]

{ #category : #'event processing' }
BlMouseProcessor >> processPicking: aMouseEvent [
	<return: #BlElement>

	^ self processPickingAt: aMouseEvent position
]

{ #category : #'event processing' }
BlMouseProcessor >> processPickingAt: aPoint [
	<return: #BlElement>
	| aTargetElement |

	(lastOverTarget isNotNil and: [ lastOverTarget isAttachedToSceneGraph not ])
		ifTrue: [ lastOverTarget := nil ].

	"if the last over target contains the point we can start picking from it"
	(false"aMouseEvent isMouseMove and: [ lastOverTarget isNotNil and: [ lastOverTarget containsGlobalPoint: aMouseEvent position ] ]")
		ifTrue: [ aTargetElement := lastOverTarget findMouseEventTargetAt: aPoint ]
		ifFalse: [ aTargetElement := self space root findMouseEventTargetAt: aPoint ].
	"we have to ensure that aTarget is not nil"
	aTargetElement ifNil: [ aTargetElement := self space root ].
	^ aTargetElement
]

{ #category : #accessing }
BlMouseProcessor >> startDragThreshold [
	^ Bloc startDragThreshold
]

{ #category : #'mouse drag' }
BlMouseProcessor >> subprocessDragEnterExitEvent: aMouseEvent [
	| newEnteredTargets newExitedTargets currentEnteredTargets |

	self 
		assert: [ currentDragTarget isNotNil ]
		description: [ 'Can not process drag mouse event as enter / exit when there is no dragged element' ].
	
	currentEnteredTargets := self fillTargetHierarchy: aMouseEvent target.
	
	lastOverTarget = aMouseEvent target ifFalse:[
		newExitedTargets := lastEnteredTargets reject: [ :anElement | currentEnteredTargets includes: anElement ].
		newEnteredTargets := currentEnteredTargets reject: [ :anElement | lastEnteredTargets includes: anElement ].
		self fireAsDragLeaveEvent: aMouseEvent targets: newExitedTargets.
		self fireAsDragEnterEvent: aMouseEvent targets: newEnteredTargets ].
	
	"store last entered targets"
	lastEnteredTargets := currentEnteredTargets
]

{ #category : #'mouse drag' }
BlMouseProcessor >> tryDragStart: aMouseEvent [
	"Try to start a drag and return true if drag actually started, otherwise false"
	<return: #Boolean>
	| aDragTarget aDragStartEvent |
	
	aDragTarget := aMouseEvent target.
	
	aDragStartEvent := (aMouseEvent asDragStartEvent
		startButtons: dragStartMask;
		target: aDragTarget;
		gestureSource: aDragTarget;
		yourself).

	aDragStartEvent := self fireEvent: aDragStartEvent.
	
	currentDragTarget := aDragStartEvent isConsumed
		ifTrue: [ aDragStartEvent currentTarget ]
		ifFalse: [ nil ].

	^ dndInProgress := aDragStartEvent isConsumed
]

{ #category : #'event processing' }
BlMouseProcessor >> updateCursorFrom: aTarget [
	| t |
	t := aTarget.
	[ t mouseCursor isNil and: [ t parent isNotNil ] ] whileTrue: [ t := t parent ].
	self space currentCursor = t mouseCursor
		ifTrue: [ ^ self ].
	self space currentCursor: t mouseCursor
]

{ #category : #'event processing' }
BlMouseProcessor >> updateDragView [

]

{ #category : #'event processing' }
BlMouseProcessor >> updateFocusOwner: aNode [
	
]

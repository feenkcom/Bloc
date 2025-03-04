"
I help developers to script UI scenes and simplify exemplification process.
"
Class {
	#name : #BlScripter,
	#superclass : #Object,
	#traits : 'TBlDevScripterActionStep + TBlDevScripterCheckStepCreation',
	#classTraits : 'TBlDevScripterActionStep classTrait + TBlDevScripterCheckStepCreation classTrait',
	#instVars : [
		'element',
		'space',
		'events',
		'rootStep',
		'eventHandler',
		'maxPulseElapsedTime'
	],
	#category : #'Bloc-Scripter-Scripter'
}

{ #category : #accessing }
BlScripter class >> scripterDirectory [
	^ SystemResolver defaultLocalDirectory / 'scripter'
]

{ #category : #adding }
BlScripter >> addStep: aScripterStep [
	<return: #BlDevScripterStep>
	^ rootStep addStep: aScripterStep
]

{ #category : #'accessing - element' }
BlScripter >> assertElement: anElement [
	self
		assert: [ anElement isNotNil ] 
		description: [ 'Element must be non-nil' ].
	self
		assert: [ anElement isKindOf: BlElement ] 
		description: [ 'Element must be a kind of ', BlElement name, ', it is: ', anElement printString ].
	self
		assert: [ self element isNil ] 
		description: [ 'Element can be initialized only once, there is already ', self element printString,
			' and another element was about to be set: ', anElement printString ].
]

{ #category : #'private - asserting' }
BlScripter >> assertSpace: aSpace [
	self 
		assert: [ aSpace isNotNil ] 
		description: [ 'Space must be non-nil' ].
	self 
		assert: [ aSpace host isKindOf: BlMockedHost ] 
		description: [ 'Scripter space must have a ', BlMockedHost name, 
			' kind of space, instead of ', aSpace host class ].
	self 
		assert: [ self element isNil ]
		description: [ 'Space must be initialized before the element ', self element printString ]
]

{ #category : #execution }
BlScripter >> continue [
	BlDevScripterStepContinueExecutor new
		scripter: self;
		async;
		"withScreenshots;"
		play
]

{ #category : #initialization }
BlScripter >> defaultSpace [
	^ BlSpace new
		title: 'Scripter';
		extent: 800 @ 600;
		host: BlMockedHost new.
]

{ #category : #'accessing - element' }
BlScripter >> element [
	^ element
]

{ #category : #'accessing - element' }
BlScripter >> element: anElement [
	self setElement: anElement.

	rootStep privatePulseUntilReady
]

{ #category : #'accessing - element' }
BlScripter >> elementWithoutParent [
	"Return element removed from a testing ${class:BlSpace}$.
	Useful when someone wants to display the resulting element.
	It cannot be used during the script execution."
	<return: #BlElement>
	^ self element removeFromParent
]

{ #category : #'private - accessing' }
BlScripter >> eventHandler [
	<return: #BlDevScripterEventCollectorHandler>
	^ eventHandler
]

{ #category : #'accessing - data' }
BlScripter >> events [
	<return: #BlDevScripterEvents>

	^ events
]

{ #category : #'accessing - space' }
BlScripter >> extent [
	<return: #Point>
	^ self space extent
]

{ #category : #'accessing - space' }
BlScripter >> extent: aPoint [
	self space extent: aPoint
]

{ #category : #accessing }
BlScripter >> gtScreenshotFor: aView [
	<gtView>
	^ aView explicit
		title: 'Screenshot';
		priority: 10;
		stencil: [ self root gtPreviewElement asScalableElement ]
]

{ #category : #initialization }
BlScripter >> initialize [
	super initialize.
	events := BlDevScripterEvents new.
	maxPulseElapsedTime := 10 minutes.

	rootStep := BlDevScripterRootStep new.
	rootStep scripter: self.
	rootStep referenceHere.

	eventHandler := BlDevScripterEventCollectorHandler new scripter: self.

	space := self defaultSpace.
	self space addEventFilter: self eventHandler.
	self space root addEventFilter: self eventHandler
]

{ #category : #testing }
BlScripter >> isStepWithTarget [
	^ false
]

{ #category : #accessing }
BlScripter >> maxPulseElapsedTime [
	"Return a maximum duration during which space pulsation can repeate.
	After this elapsed time, the pulsation should stop, signaling an error."

	<return: #Duration>
	^ maxPulseElapsedTime
]

{ #category : #accessing }
BlScripter >> maxPulseElapsedTime: aDuration [
	"Set a maximum duration during which space pulsation can repeate.
	After this elapsed time, the pulsation should stop, signaling an error."
	
	self
		assert: [ aDuration isNotNil ]
		description: [ 'Maximum elapsed time must be non-nil' ].

	maxPulseElapsedTime := aDuration
]

{ #category : #'accessing - data' }
BlScripter >> model [
	^ self userData model
]

{ #category : #'accessing - data' }
BlScripter >> model: anObject [
	self userData model: anObject
]

{ #category : #execution }
BlScripter >> play [
	rootStep play
]

{ #category : #execution }
BlScripter >> pulse [
	self space pulse
]

{ #category : #execution }
BlScripter >> pulseUntilReady [
	rootStep privatePulseUntilReady
]

{ #category : #'accessing - space' }
BlScripter >> root [
	^ self space root
]

{ #category : #'accessing - element' }
BlScripter >> rootWithoutParent [
	"Return a space root element removed from a testing ${class:BlSpace}$.
	Useful when someone wants to display the resulting space root.
	It cannot be used during the script execution."
	<return: #BlElement>
	| aSpaceRoot |
	
	aSpaceRoot := space root.
	space root: space defaultRoot.
	aSpaceRoot size: space extent.
	
	^ aSpaceRoot
]

{ #category : #accessing }
BlScripter >> scripter [
	^ self
]

{ #category : #'accessing - element' }
BlScripter >> setElement: anElement [
	self assertElement: anElement.

	element := anElement.
	element addEventFilter: self eventHandler.
	element removeFromParent.
	self space addChild: element.
]

{ #category : #actions }
BlScripter >> showSpace [
	"I can be only used after Scripter execution."
	self space
		close;
		host: BlHost pickHost;
		show
]

{ #category : #'accessing - space' }
BlScripter >> space [
	<return: #BlSpace>
	^ space
]

{ #category : #'accessing - data' }
BlScripter >> spaceTaskEvents [
	<return: #Collection of: #BlSpaceTaskEvent>
	^ self events select: [ :eachEvent | eachEvent isKindOf: BlSpaceTaskEvent ]
]

{ #category : #'accessing - space' }
BlScripter >> spaceWithElement [
	"Return ${class:BlSpace}$ and ensure that the ==element== is its child
	Useful when someone wants to display the resulting space (window) with the element.
	It cannot be used during the script execution."
	<return: #BlSpace>
	self element space = self space ifFalse: [ 
		self space addChild: self elementWithoutParent ].
	^ self space
]

{ #category : #execution }
BlScripter >> startWithExecutor: anExecutor [
	rootStep startWithExecutor: anExecutor
]

{ #category : #'steps - substeps' }
BlScripter >> substep: aLabel do: anOneArgBlock [
	^ (self substeps: aLabel do: anOneArgBlock) referenceSender
]

{ #category : #execution }
BlScripter >> syncPlay [
	BlDevScripterStepPlayOnceExecutor new
		scripter: self;
		sync;
		"withScreenshots;"
		play
]

{ #category : #'accessing - space' }
BlScripter >> time [
	<return: #BlTime>
	^ self space time
]

{ #category : #'accessing - data' }
BlScripter >> userData [
	<return: #BlDevScripterUserData>
	^ self space root devScripterData
]

Class {
	#name : #BlDevScripterStep,
	#superclass : #Object,
	#instVars : [
		'scripter',
		'state',
		'label',
		'properties',
		'maxPulseElapsedTime'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #'accessing - properties' }
BlDevScripterStep >> addScreenshotForm: aForm [
	self properties addScreenshotForm: aForm
]

{ #category : #accessing }
BlDevScripterStep >> defaultLabel [
	^ 'Step'
]

{ #category : #'private - accessing' }
BlDevScripterStep >> getMousePositionIn: aScripter [
	^ (aScripter userData includesKey: #mousePosition)
		ifTrue: [ aScripter userData at: #mousePosition ]
		ifFalse: [ 0.0@0.0 ]
]

{ #category : #printing }
BlDevScripterStep >> gtDisplayOn: aStream [
	aStream nextPutAll: self label
]

{ #category : #'accessing - state' }
BlDevScripterStep >> haltHere [
	self state: BlDevScripterStepState haltHere
]

{ #category : #testing }
BlDevScripterStep >> hasCustomLabel [
	<return: #Boolean>
	^ label isNotNil
]

{ #category : #'private - accessing' }
BlDevScripterStep >> hasMousePositionIn: aScripter [
	^ aScripter userData includesKey: #mousePosition
]

{ #category : #initialization }
BlDevScripterStep >> initialize [
	super initialize.
	state := BlDevScripterStepState ready.
	properties := BlDevScripterStepProperties new.
]

{ #category : #'accessing - state' }
BlDevScripterStep >> isHaltState [
	<return: #Boolean>
	^ self state isHalt
]

{ #category : #testing }
BlDevScripterStep >> isRootStep [
	^ false
]

{ #category : #testing }
BlDevScripterStep >> isStepWithTarget [
	^ true
]

{ #category : #accessing }
BlDevScripterStep >> label [
	^ label ifNil: [ self defaultLabel ]
]

{ #category : #accessing }
BlDevScripterStep >> label: anObject [
	label := anObject
]

{ #category : #enumerating }
BlDevScripterStep >> leavesStepExecutionPlayDuration [
	<return: #Duration>
	self steps
		ifEmpty: [ ^ self properties stepExecution
				ifNil: [ 0 seconds ]
				ifNotNil: [ :aProperty | aProperty playDuration ifNil: [ 0 seconds ] ] ].

	^ self steps
		inject: 0 seconds
		into: [ :sum :step | sum + step leavesStepExecutionPlayDuration ]
]

{ #category : #enumerating }
BlDevScripterStep >> leavesStepExecutionPulseDuration [
	<return: #Duration>
	self steps
		ifEmpty: [ ^ self properties stepExecution
				ifNil: [ 0 seconds ]
				ifNotNil: [ :aProperty | aProperty pulseDuration ifNil: [ 0 seconds ] ] ].

	^ self steps
		inject: 0 seconds
		into: [ :sum :step | sum + step leavesStepExecutionPulseDuration ]
]

{ #category : #enumerating }
BlDevScripterStep >> leavesStepExecutionTotalDuration [
	<return: #Duration>
	self steps
		ifEmpty: [ ^ self properties stepExecution
				ifNil: [ 0 seconds ]
				ifNotNil: [ :aProperty | aProperty totalDuration ifNil: [ 0 seconds ] ] ].

	^ self steps
		inject: 0 seconds
		into: [ :sum :step | sum + step leavesStepExecutionTotalDuration ]
]

{ #category : #accessing }
BlDevScripterStep >> maxPulseElapsedTime [
	"Return a maximum duration during which space pulsation can repeate.
	After this elapsed time, the pulsation should stop, signaling an error."

	<return: #Duration>
	^ maxPulseElapsedTime ifNil: [ self scripter maxPulseElapsedTime ]
]

{ #category : #accessing }
BlDevScripterStep >> maxPulseElapsedTime: aDuration [
	"Set a maximum duration during which space pulsation can repeate.
	After this elapsed time, the pulsation should stop, signaling an error."

	maxPulseElapsedTime := aDuration
]

{ #category : #actions }
BlDevScripterStep >> play [
	self
		assert: [ self scripter notNil ]
		description: [ 'Can not play without scripter' ].

	self playNoPulse.
	self privatePulseUntilReady
]

{ #category : #actions }
BlDevScripterStep >> playNoPulse [
	self
		assert: [ self scripter notNil ]
		description: [ 'Can not play without scripter' ].

	BlDevScripterStepPlayOnceExecutor new
		scripter: self scripter;
		async;
		executeStep: self
]

{ #category : #actions }
BlDevScripterStep >> playOn: aScripter [
	
]

{ #category : #actions }
BlDevScripterStep >> playOnExecutor: anExecutor [ 
	self playOn: anExecutor scripter
]

{ #category : #'private - accessing' }
BlDevScripterStep >> privatePulseUntilReady [
	self shouldPulse ifFalse: [ ^ self ].

	BlDevScripterPulseUntilReady new
		maxElapsedTime: self maxPulseElapsedTime;
		scripter: self scripter;
		step: self;
		start
]

{ #category : #'accessing - properties' }
BlDevScripterStep >> properties [
	<return: #BlDevScripterStepProperties>
	^ properties
]

{ #category : #accessing }
BlDevScripterStep >> realTarget [
	<return: #BlDevScripterTarget>
	^ self target
]

{ #category : #'accessing - reference' }
BlDevScripterStep >> reference [
	<return: #BlDevScripterReference>
	^ self properties reference
]

{ #category : #'accessing - reference' }
BlDevScripterStep >> reference: aBlDevScripterReference [
	self properties reference: aBlDevScripterReference
]

{ #category : #'accessing - reference' }
BlDevScripterStep >> referenceHere [
	| anInterestingContext |
	anInterestingContext := thisContext stack second.
	self
		reference: (BlDevScripterReferenceBuilder new
				context: anInterestingContext;
				build)
]

{ #category : #'accessing - reference' }
BlDevScripterStep >> referenceNothing [
	self reference: BlDevScripterReference null
]

{ #category : #'accessing - reference' }
BlDevScripterStep >> referenceSender [
	| anInterestingContext |
	anInterestingContext := thisContext stack third.
	self
		reference: (BlDevScripterReferenceBuilder new
				context: anInterestingContext;
				build)
]

{ #category : #accessing }
BlDevScripterStep >> scripter [
	^ scripter
]

{ #category : #accessing }
BlDevScripterStep >> scripter: aScripter [
	scripter := aScripter.
	self steps do: [ :eachStep | eachStep scripter: aScripter ]
]

{ #category : #'accessing - state' }
BlDevScripterStep >> setFailedExecution [
	self state: BlDevScripterStepState failure.
]

{ #category : #'private - accessing' }
BlDevScripterStep >> setMousePosition: aPoint in: aScripter [
	aScripter userData at: #mousePosition put: aPoint
]

{ #category : #'accessing - state' }
BlDevScripterStep >> setSuccessExecution [
	self state: BlDevScripterStepState success.
]

{ #category : #'accessing - state' }
BlDevScripterStep >> setUnderExecution [
	self state: BlDevScripterStepState executing.
]

{ #category : #actions }
BlDevScripterStep >> shouldPulse [
	^ true
]

{ #category : #actions }
BlDevScripterStep >> startWithExecutor: anExecutor [
	anExecutor executeStep: self
]

{ #category : #accessing }
BlDevScripterStep >> state [
	<return: #BlDevScripterStepState>
	^ state
]

{ #category : #accessing }
BlDevScripterStep >> state: aState [

	state := aState
]

{ #category : #'accessing - state' }
BlDevScripterStep >> stateColor [
	^ self state color
]

{ #category : #'accessing - state' }
BlDevScripterStep >> stateIcon [
	^ self state icon
]

{ #category : #'accessing - state' }
BlDevScripterStep >> stateName [
	^ self state name
]

{ #category : #'accessing - state' }
BlDevScripterStep >> stepIcon [
	<return: #BlElement or: nil>
	^ nil
]

{ #category : #accessing }
BlDevScripterStep >> steps [
	^ #()
]

{ #category : #accessing }
BlDevScripterStep >> target [
	^ BlDevScripterSelfEventTarget new
]

{ #category : #accessing }
BlDevScripterStep >> userData [
	^ self scripter userData
]

{ #category : #testing }
BlDevScripterStep >> wasExecuted [
	<return: #Boolean>
	^ self state wasExecuted
]

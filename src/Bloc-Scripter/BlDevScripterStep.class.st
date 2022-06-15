Class {
	#name : #BlDevScripterStep,
	#superclass : #Object,
	#instVars : [
		'scripter',
		'state',
		'label',
		'properties'
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

{ #category : #'gt-extension' }
BlDevScripterStep >> gtReferenceFor: aView [
	<gtView>
	self reference ifNil: [ ^ aView empty ].
	^ (self reference gtReferenceFor: aView)
		priority: 5
]

{ #category : #accessing }
BlDevScripterStep >> gtScreenshotFor: aView [
	<gtView>
	self properties ifNil: [ ^ aView empty ].
	^ self properties gtScreenshotFor: aView
]

{ #category : #'accessing - state' }
BlDevScripterStep >> haltHere [
	state := BlDevScripterStepState haltHere
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
	^ state isHalt
]

{ #category : #testing }
BlDevScripterStep >> isRootStep [
	^ false
]

{ #category : #accessing }
BlDevScripterStep >> label [
	^ label ifNil: [ self defaultLabel ]
]

{ #category : #accessing }
BlDevScripterStep >> label: anObject [
	label := anObject
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
	| aDelay aStartTime |

	self shouldPulse
		ifFalse: [ ^ self ].
	
	aDelay := 5 milliSeconds.
	aStartTime := DateAndTime now.
	
	[ self scripter space taskQueue isNotEmpty or: [ self scripter space pulseRequested ] ]
		whileTrue: [
			| aDuration |
			self scripter space pulse.
			aDelay wait.
			
			aDuration := DateAndTime now - aStartTime.
			aDuration > 1 minute
				ifTrue: [
					NonInteractiveTranscript stdout
						nextPutAll: 'Scripter is probably locked up, it is already pulsing for ', aDuration humanReadablePrintString;
						nextPut: $.;
						cr;
						nextPutAll: '    ';
						nextPutAll: 'pulse requested: ';
						nextPutAll: self scripter space pulseRequested asString;
						cr;
						nextPutAll: '    ';
						nextPutAll: 'tasks: ';
						nextPutAll: self scripter space taskQueue tasks printString;
						cr ].
			aDelay := aDelay * 1.2 ]
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
	| aDefinition |
	aDefinition := thisContext stack second blocMethodDefinition.
	self reference: (BlDevScripterReference method: aDefinition).
]

{ #category : #'accessing - reference' }
BlDevScripterStep >> referenceNothing [
	self reference: BlDevScripterReference null
]

{ #category : #'accessing - reference' }
BlDevScripterStep >> referenceSender [
	| aDefinition |
	aDefinition := thisContext stack third blocMethodDefinition.
	self reference: (BlDevScripterReference method: aDefinition).
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
	state := BlDevScripterStepState failure.
]

{ #category : #'private - accessing' }
BlDevScripterStep >> setMousePosition: aPoint in: aScripter [
	aScripter userData at: #mousePosition put: aPoint
]

{ #category : #'accessing - state' }
BlDevScripterStep >> setSuccessExecution [
	state := BlDevScripterStepState success.
]

{ #category : #'accessing - state' }
BlDevScripterStep >> setUnderExecution [
	state := BlDevScripterStepState executing.
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

{ #category : #'accessing - state' }
BlDevScripterStep >> stateColor [
	^ state color
]

{ #category : #'accessing - state' }
BlDevScripterStep >> stateName [
	^ state name
]

{ #category : #accessing }
BlDevScripterStep >> steps [
	^ #()
]

{ #category : #accessing }
BlDevScripterStep >> target [
	^ BlDevScripterSelfEventTarget new
]

{ #category : #testing }
BlDevScripterStep >> wasExecuted [
	<return: #Boolean>
	^ state wasExecuted
]

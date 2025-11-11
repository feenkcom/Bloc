Class {
	#name : #BlDevScripterPulseUntilReady,
	#superclass : #Object,
	#instVars : [
		'scripter',
		'step',
		'startDelay',
		'currentDelay',
		'maxDelay',
		'startTime',
		'endTime',
		'warningElapsedTime',
		'maxElapsedTime',
		'numberOfPulses',
		'usedDelays',
		'lastLogTime',
		'isStopRequested',
		'pulserProcess',
		'state'
	],
	#category : #'Bloc-Scripter-Scripter-Executors'
}

{ #category : #'private - accessing' }
BlDevScripterPulseUntilReady >> currentDelay [
	"Return a waiting time between two pulse cycles."

	<return: #Duration>
	^ currentDelay ifNil: [ currentDelay := self startDelay ]
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> elapsedTime [
	^ (endTime ifNil: [ DateAndTime now ]) - self startTime
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> endTime [

	^ endTime
]

{ #category : #'private - testing' }
BlDevScripterPulseUntilReady >> hasFinished [
	"Return true if pulsation was in progress and is finished"

	<return: #Boolean>
	^ self startTime isNotNil and: [ self endTime isNotNil ]
]

{ #category : #'private - testing' }
BlDevScripterPulseUntilReady >> hasStarted [
	"Return true if pulsation is or was in progress"

	<return: #Boolean>
	^ self startTime isNotNil or: [ self endTime isNotNil ]
]

{ #category : #initiailize }
BlDevScripterPulseUntilReady >> initialize [
	super initialize.
	
	startDelay := 5 milliseconds.
	maxDelay := 100 milliseconds.
	warningElapsedTime := 1 minute.
	maxElapsedTime := 10 minutes.
	numberOfPulses := 0.
	usedDelays := OrderedCollection new.
	isStopRequested := false.
	state := #initialized.
]

{ #category : #'private - testing' }
BlDevScripterPulseUntilReady >> isLikelyLockedUp [
	<return: #Boolean>
	^ self elapsedTime > self warningElapsedTime
]

{ #category : #'private - testing' }
BlDevScripterPulseUntilReady >> isProcessTerminatedOrTerminating [
	^ pulserProcess
		ifNil: [ true ]
		ifNotNil: [ :aProcess | aProcess isTerminating or: [ aProcess isTerminated ] ]
]

{ #category : #'private - testing' }
BlDevScripterPulseUntilReady >> isScripterSpacePulseRequested [
	^ self scripterSpace pulseRequested
]

{ #category : #'private - testing' }
BlDevScripterPulseUntilReady >> isScripterSpaceTaskQueueWithTasks [
	^ self scripterSpaceTaskQueue hasDefiniteTermTasks
]

{ #category : #'private - testing' }
BlDevScripterPulseUntilReady >> isStopRequested [
	"True means whether a user requested to stop pulsing. False means that it can continue pulsing if necessary."

	<return: #Boolean>
	^ isStopRequested
]

{ #category : #'private - pulsing' }
BlDevScripterPulseUntilReady >> logScripterLikelyLockedUp [
	lastLogTime ifNotNil: [ 
		lastLogTime + 30 seconds < DateAndTime now ifFalse: [ 
			"Ensure that the stdout is not flooded by the same log."
			^ self ] ].
	state := #lockedUp.
	lastLogTime := DateAndTime now.

	NonInteractiveTranscript stdout
		nextPutAll: 'Scripter is probably locked up, it is already pulsing for '
				, self elapsedTime humanReadablePrintString;
		nextPut: $.;
		cr;
		nextPutAll: '    ';
		nextPutAll: 'is pulse requested: ';
		nextPutAll: self isScripterSpacePulseRequested printString;
		cr;
		nextPutAll: '    ';
		nextPutAll: 'has tasks: ';
		nextPutAll: self isScripterSpaceTaskQueueWithTasks printString;
		cr;
		nextPutAll: '    ';
		nextPutAll: 'step: ';
		nextPutAll: self stepLabel printString;
		cr;
		nextPutAll: '    ';
		nextPutAll: 'defining method: ';
		nextPutAll: self stepDefiningMethod printString;
		cr;
		nextPutAll: '    ';
		nextPutAll: 'space active tasks: ';
		cr;
		in: [ :aStream | 
			self scripterSpaceTaskQueue tasks do: [ :eachTask |
				aStream
					nextPutAll: '        ';
					print: eachTask identityHash;
					nextPutAll: ': ';
					nextPutAll: eachTask gtDisplayString;
					cr ] ];
		nextPutAll: '    ';
		nextPutAll: 'space pending tasks: ';
		cr;
		in: [ :aStream | 
			self scripterSpaceTaskQueue pendingTasks do: [ :eachTask |
				aStream
					nextPutAll: '        ';
					print: eachTask identityHash;
					nextPutAll: ': ';
					nextPutAll: eachTask gtDisplayString;
					cr ] ];
		nextPutAll: '    ';
		nextPutAll: 'last frame space task events: ';
		cr;
		in: [ :aStream | 
			(self scripter spaceTaskEvents detectMax: #frameId)
				ifNotNil: [ :anEvent | 
					| aFrameId lastTasks |
					aFrameId := anEvent frameId.
					lastTasks := self scripter spaceTaskEvents
							select: [ :each | each frameId = aFrameId ].

					lastTasks
						do: [ :eachSpaceTaskEvent | 
							| aTask |
							aTask := eachSpaceTaskEvent task.
							aStream
								nextPutAll: '        ';
								nextPutAll: 'frame ID: ';
								print: eachSpaceTaskEvent frameId;
								nextPutAll: ', event class: ';
								print: eachSpaceTaskEvent class;
								nextPutAll: ', task ID: ';
								print: aTask id;
								nextPutAll: ', is new task: ';
								print: aTask isNew;
								nextPutAll: ', is complete task: ';
								print: aTask isComplete;
								nextPutAll: ', task: ';
								print: aTask;
								cr ] ] ]
]

{ #category : #'private - pulsing' }
BlDevScripterPulseUntilReady >> markEndTime [
	endTime ifNotNil: [ ^ self ].
	endTime := DateAndTime now
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> maxDelay [
	"Return maximum waiting time between two pulse cycles."

	<return: #Duration>
	^ maxDelay
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> maxDelay: aDuration [
	self
		assert: [ aDuration isNotNil ]
		description: [ 'Max delay must be non-nil duration value' ].
	maxDelay := aDuration
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> maxElapsedTime [
	"Return a maximum duration during which pulsation can repeate.
	After this elapsed time, the pulsation should stop, signaling an error."

	<return: #Duration>
	^ maxElapsedTime
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> maxElapsedTime: aDuration [
	"Set a maximum duration during which space pulsation can repeate.
	After this elapsed time, the pulsation should stop, signaling an error."

	self
		assert: [ aDuration isNotNil ]
		description: [ 'Maximum elapsed time must be non-nil' ].

	maxElapsedTime := aDuration
]

{ #category : #'private - pulsing' }
BlDevScripterPulseUntilReady >> pulse [
	| nextDelay |
	numberOfPulses := numberOfPulses + 1.

	self scripterSpace pulse.
	
	"Do not wait if there is no need to pulse anymore"
	self shouldPulse
		ifFalse: [ ^ self ].

	nextDelay := self currentDelay.
	usedDelays add: nextDelay.
	nextDelay wait.

	self isLikelyLockedUp ifTrue: [ self logScripterLikelyLockedUp ].

	self reachedMaxElapsedTime ifTrue: [ self signalPulseTimeout ].

	self updateCurrentDelay
]

{ #category : #'api - pulsing' }
BlDevScripterPulseUntilReady >> pulseWhileNeeded [
	[ self shouldPulse ] whileTrue: [ self pulse ]
]

{ #category : #'private - testing' }
BlDevScripterPulseUntilReady >> reachedMaxElapsedTime [
	<return: #Boolean>
	^ self elapsedTime > self maxElapsedTime
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> scripter [
	<return: #BlScripter>
	^ scripter
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> scripter: aScripter [
	self
		assert: [ aScripter isNotNil ]
		description: [ 'Scripter must be non-nil value' ].
	self
		assert: [ scripter isNil ]
		description: [ 'Scripter must be initilized only once' ].

	scripter := aScripter
]

{ #category : #'private - accessing' }
BlDevScripterPulseUntilReady >> scripterSpace [
	<return: #BlSpace>
	^ self scripter space
]

{ #category : #'private - accessing' }
BlDevScripterPulseUntilReady >> scripterSpaceTaskQueue [
	^ self scripterSpace taskQueue
]

{ #category : #'private - pulsing' }
BlDevScripterPulseUntilReady >> setStepExecutionProperty: isFinishedOnTime [
	self step properties stepExecution
			isPulseRequested: self isScripterSpacePulseRequested;
			isSpaceTaskQueueWithTasks: self isScripterSpaceTaskQueueWithTasks;
			isFinishedOnTime: isFinishedOnTime;
			pulseDuration: self elapsedTime;
			numberOfPulses: numberOfPulses;
			usedDelays: usedDelays asArray.
]

{ #category : #'private - testing' }
BlDevScripterPulseUntilReady >> shouldPulse [
	"Return true if another pulse cycle is required."

	<return: #Boolean>
	self isStopRequested ifTrue: [ ^ false ].

	^ self isScripterSpaceTaskQueueWithTasks
		or: [ self isScripterSpacePulseRequested ]
]

{ #category : #'private - pulsing' }
BlDevScripterPulseUntilReady >> signalPulseTimeout [
	self markEndTime.
	self setStepExecutionProperty: false.
	state := #timeouted.

	BlDevScripterStepPulsationTimeoutedSignal new
			scripter: self scripter;
			step: self step;
			pulseDuration: self elapsedTime;
			numberOfPulses: numberOfPulses;
			usedDelays: usedDelays asArray;
			emit.
	
	BlDevScripterPulseTimeoutError new
		scripter: self scripter;
		step: self step;
		duration: self elapsedTime;
		isPulseRequested: self isScripterSpacePulseRequested;
		isSpaceTaskQueueWithTasks: self isScripterSpaceTaskQueueWithTasks;
		signal
]

{ #category : #'api - pulsing' }
BlDevScripterPulseUntilReady >> start [
	self
		assert: [ self scripter isNotNil ]
		description: [ 'Scripter must be initialized first' ].
	self
		assert: [ self hasStarted not or: [ self hasFinished ] ]
		description: [ 'I can pulse only once at a same time' ].

	pulserProcess := Processor activeProcess.
	isStopRequested := false.
	endTime := nil.
	startTime := DateAndTime now.
	numberOfPulses := 0.
	state := #pulsing.

	[ self pulseWhileNeeded ]
		ensure: [ 
			state := #interrupted.
			self markEndTime ].

	state := #finished.
	self setStepExecutionProperty: true.

	BlDevScripterStepPulsationFinishedSignal new
		scripter: self scripter;
		step: self step;
		pulseDuration: self elapsedTime;
		numberOfPulses: numberOfPulses;
		usedDelays: usedDelays asArray;
		emit.

	pulserProcess := nil
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> startDelay [
	"Return an initial delay between two pulse cycles.
	This value is used as an initial value for `currentDelay`."

	<return: #Duration>
	^ startDelay
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> startDelay: aDuration [
	self
		assert: [ aDuration isNotNil ]
		description: [ 'Start delay must be non-nil duration value' ].
	startDelay := aDuration
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> startTime [

	^ startTime
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> state [
	^ state
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> step [

	^ step
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> step: aScripterStep [
	self
		assert: [ aScripterStep isNotNil ]
		description: [ 'Scripter step must be non-nil value' ].
	self
		assert: [ step isNil ]
		description: [ 'Scripter step must be initilized only once' ].

	step := aScripterStep
]

{ #category : #'private - accessing' }
BlDevScripterPulseUntilReady >> stepDefiningMethod [
	self step ifNil: [ ^ '<undefined method>' ].
	^ self step reference isReference
		ifTrue: [ self step reference definition ]
		ifFalse: [ '<undefined>' ]
]

{ #category : #'private - accessing' }
BlDevScripterPulseUntilReady >> stepLabel [
	^ self step ifNotNil: #label ifNil: [ '<undefined step>' ]
]

{ #category : #'api - pulsing' }
BlDevScripterPulseUntilReady >> stop [
	isStopRequested := true
]

{ #category : #'private - pulsing' }
BlDevScripterPulseUntilReady >> updateCurrentDelay [
	currentDelay := self currentDelay * 1.2 min: self maxDelay
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> warningElapsedTime [
	"Return a duration time, after which a warning message will be written to a log."

	<return: #Duration>
	^ warningElapsedTime
]

{ #category : #accessing }
BlDevScripterPulseUntilReady >> warningElapsedTime: anObject [

	warningElapsedTime := anObject
]

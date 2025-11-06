Class {
	#name : #BlDevScripterWaitStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'waitingBlock',
		'cycles',
		'timeIsOk'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #initialization }
BlDevScripterWaitStep >> defaultLabel [
	^ 'Wait'
]

{ #category : #initialization }
BlDevScripterWaitStep >> forElementCondition: aConditionBlock timeout: aDuration [
	self
		label: ('Wait until a condition is satisfied with {1} timeout'
				format: {aDuration humanReadablePrintString}).
	self
		waitingBlock: [ :anElement | 
			| aStartTime aSpace |
			self assert: (anElement isKindOf: BlElement) description: [  ].
			aSpace := anElement space.
			self assert: aSpace isNotNil description: [  ].
			aStartTime := aSpace time now.
			aSpace time
				every: 100 milliSeconds
				while: [ (timeIsOk := aSpace time now < (aStartTime + aDuration))
						and: [ (aConditionBlock cull: anElement) not ] ]
				do: [ aSpace pulse.
					self increaseCycle ] ]
]

{ #category : #initialization }
BlDevScripterWaitStep >> forEmptySpaceTaskQueue [
	self label: 'Wait for empty task queue'.
	self onSpace.
	self waitingBlock: [ :aSpace |
		aSpace pulse.
		self increaseCycle.
		aSpace time 
			every: 20 milliSeconds 
			while: [ aSpace taskQueue hasDefiniteTermTasks or: [ aSpace pulseRequested ] ] 
			do: [ aSpace pulse. self increaseCycle ] ]
]

{ #category : #initialization }
BlDevScripterWaitStep >> forEmptySpaceTaskQueueTimeout: aDuration [
	self
		label: ('Wait for empty task queue with {1} timeout'
				format: {aDuration humanReadablePrintString}).
	self onSpace.
	self
		waitingBlock: [ :aSpace | 
			| aStartTime |
			aStartTime := aSpace time now.
			aSpace time
				every: 100 milliSeconds
				while: [ (timeIsOk := aSpace time now < (aStartTime + aDuration))
						and: [ aSpace taskQueue hasDefiniteTermTasks or: [ aSpace pulseRequested ] ] ]
				do: [ aSpace pulse.
					self increaseCycle ] ]
]

{ #category : #initialization }
BlDevScripterWaitStep >> forEnqueuedSpaceTask [
	self label: 'Wait for enqueued space task'.
	self onSpace.
	self waitingBlock: [ :aSpace |
		aSpace pulse.
		self increaseCycle.
		aSpace time 
			every: 20 milliSeconds 
			while: [ aSpace taskQueue isEmpty or: [ aSpace pulseRequested ] ] 
			do: [ aSpace pulse. self increaseCycle ] ]
]

{ #category : #initialization }
BlDevScripterWaitStep >> forEnqueuedSpaceTaskTimeout: aDuration [
	self
		label: ('Wait for enqueued space task with {1} timeout'
				format: {aDuration humanReadablePrintString}).
	self onSpace.
	self
		waitingBlock: [ :aSpace | 
			| aStartTime |
			aStartTime := aSpace time now.
			aSpace time
				every: 100 milliSeconds
				while: [ (timeIsOk := aSpace time now < (aStartTime + aDuration))
						and: [ aSpace taskQueue isEmpty or: [ aSpace pulseRequested ] ] ]
				do: [ aSpace pulse.
					self increaseCycle ] ]
]

{ #category : #initialization }
BlDevScripterWaitStep >> forSemaphore: aSemaphore [

	self label: 'Wait for semaphore '.
	self waitingBlock: [ :anObject | aSemaphore wait ]
]

{ #category : #initialization }
BlDevScripterWaitStep >> forSemaphore: aSemaphore timeoutSeconds: anInteger [
	self label: ('Wait for semaphore with {1} seconds timeout' format: { anInteger }).
	self waitingBlock: [ :anObject | 
		| aTimeout |
		aTimeout := aSemaphore waitTimeoutSeconds: anInteger.
		
		self 
			assert: aTimeout not 
			description: [ self label asString , 
				': semaphore timeouted after ', anInteger asString, ' seconds' ] ]
]

{ #category : #printing }
BlDevScripterWaitStep >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	timeIsOk ifNil: [ ^ self ].
	timeIsOk ifTrue: [ ^ self ].

	aStream
		nextPutAll: ': ';
		nextPutAll: (timeIsOk ifFalse: [ 'timeouted' ] ifTrue: [ 'finished on time' ])
]

{ #category : #'private - adding' }
BlDevScripterWaitStep >> increaseCycle [
	cycles := cycles + 1.
]

{ #category : #initialization }
BlDevScripterWaitStep >> initialize [
	super initialize.
	cycles := 0.
]

{ #category : #actions }
BlDevScripterWaitStep >> playOn: aScripter [
	self waitingBlock value: (self target findTargetStartingInScripter: aScripter)
]

{ #category : #accessing }
BlDevScripterWaitStep >> waitingBlock [
	^ waitingBlock
]

{ #category : #accessing }
BlDevScripterWaitStep >> waitingBlock: anObject [
	waitingBlock := anObject
]

Class {
	#name : #BlDevScripterWaitStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'waitingBlock',
		'cycles'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #initialization }
BlDevScripterWaitStep >> defaultLabel [
	^ 'Wait'
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
			while: [ aSpace taskQueue tasks isNotEmpty or: [ aSpace pulseRequested ] ] 
			do: [ aSpace pulse. self increaseCycle ] ]
]

{ #category : #initialization }
BlDevScripterWaitStep >> forEmptySpaceTaskQueueTimeout: aDuration [
	self label: ('Wait for empty task queue with {1} timeout' format: { aDuration humanReadablePrintString }).
	self onSpace.
	self waitingBlock: [ :aSpace |
		| aStartTime |
		aStartTime := aSpace time now.		
		aSpace time 
			every: 100 milliSeconds 
			while: [ (aSpace time now < (aStartTime + aDuration)) and: [ aSpace taskQueue tasks isNotEmpty or: [ aSpace pulseRequested ] ] ] 
			do: [ aSpace pulse. self increaseCycle ] ]
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
			while: [ aSpace taskQueue tasks isEmpty or: [ aSpace pulseRequested ] ] 
			do: [ aSpace pulse. self increaseCycle ] ]
]

{ #category : #initialization }
BlDevScripterWaitStep >> forEnqueuedSpaceTaskTimeout: aDuration [
	self label: ('Wait for enqueued space task with {1} timeout' format: { aDuration humanReadablePrintString }).
	self onSpace.
	self waitingBlock: [ :aSpace |
		| aStartTime |
		aStartTime := aSpace time now.	
		aSpace time 
			every: 100 milliSeconds 
			while: [ (aSpace time now < (aStartTime + aDuration)) 
				and: [ aSpace taskQueue tasks isEmpty or: [ aSpace pulseRequested ] ] ]
			do: [ aSpace pulse. self increaseCycle ] ]
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

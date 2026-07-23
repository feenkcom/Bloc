"
I pause scripter execution until a condition is met.

Use me after actions that trigger asynchronous work — animations, deferred layout, background tasks — to ensure the UI has settled before asserting results.

I support several waiting strategies:
- {{gtMethod:BlDevScripterWaitStep>>#forEmptySpaceTaskQueueTimeout:}} — wait until the space task queue is empty
- {{gtMethod:BlDevScripterWaitStep>>#forEnqueuedSpaceTaskTimeout:}} — wait for a specific enqueued task
- {{gtMethod:BlDevScripterWaitStep>>#forSemaphore:timeoutSeconds:}} — wait for a semaphore signal
- {{gtMethod:BlDevScripterWaitStep>>#forCondition:pulseDuring:}} — wait for a custom condition block
- {{gtMethod:BlDevScripterWaitStep>>#forElementCondition:timeout:}} — wait for element to satisfy a condition

## Usage Examples

- {{gtClass:BlScripterWaitStepUsageExamples}} — canonical usage patterns
- {{gtClass:BrSimpleListByScripterExamples}} — waiting after scroll events
- {{gtClass:BlScripterScrollStepUsageExamples}} — waiting for scroll to settle

## Example

{{gtExample:BlScripterWaitStepUsageExamples>>#waitForEmptyTaskQueue|previewExpanded=true|previewHeight=300}}
"
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
BlDevScripterWaitStep >> for: aConditionBlock timeout: aDuration [
	self
		label: ('Wait for {1} with {2} timeout'
				format: {aConditionBlock. aDuration humanReadablePrintString}).
	self onSpace.
	self
		waitingBlock: [ :aSpace :aScripter | 
			| aStartTime |
			aStartTime := aSpace time now.
			aSpace time
				every: 100 milliSeconds
				while: [ (timeIsOk := aSpace time now < (aStartTime + aDuration))
						and: [ (aConditionBlock cull: aSpace cull: aScripter) not ] ]
				do: [ aSpace pulse.
					self increaseCycle ] ]
]

{ #category : #initialization }
BlDevScripterWaitStep >> forCondition: aBlock pulseDuring: aDuration [
	self
		label: ('Wait for satisfied condition while pulsing with {1} timeout'
				format: {aDuration humanReadablePrintString}).
	self onSpace.
	self
		waitingBlock: [ :aSpace | 
			| aStartTime aLastResult |
			aLastResult := false.
			aStartTime := aSpace time now.
			aSpace time
				every: 100 milliSeconds
				while: [ (timeIsOk := aSpace time now < (aStartTime + aDuration))
						and: [ aLastResult := aBlock cull: aSpace cull: scripter ] ]
				do: [ aSpace pulse.
					self increaseCycle ].
			self
				assert: aLastResult
				description: [ 'Condition was not satisfied within {1}: {2}'
						format: {aDuration humanReadablePrintString.
								aBlock} ] ]
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
BlDevScripterWaitStep >> forSemaphore: aSemaphore pulseDuring: aDuration [
	self
		label: ('Wait for semaphore to be signaled while pulsing with {1} timeout'
				format: {aDuration humanReadablePrintString}).
	self onSpace.
	self
		waitingBlock: [ :aSpace | 
			| aStartTime |
			aStartTime := aSpace time now.
			aSpace time
				every: 100 milliSeconds
				while: [ (timeIsOk := aSpace time now < (aStartTime + aDuration))
						and: [ aSemaphore isSignaled ] ]
				do: [ aSpace pulse.
					self increaseCycle ] ]
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
	self waitingBlock
		cull: (self target findTargetStartingInScripter: aScripter)
		cull: aScripter
]

{ #category : #accessing }
BlDevScripterWaitStep >> waitingBlock [
	^ waitingBlock
]

{ #category : #accessing }
BlDevScripterWaitStep >> waitingBlock: anObject [
	waitingBlock := anObject
]

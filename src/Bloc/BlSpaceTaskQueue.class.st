Class {
	#name : #BlSpaceTaskQueue,
	#superclass : #BlTaskQueue,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #'instance creation' }
BlSpaceTaskQueue class >> space: aBlSpace [

	^ self new initializeWith: aBlSpace
]

{ #category : #initialization }
BlSpaceTaskQueue >> initializeWith: aBlSpace [

	space := aBlSpace
]

{ #category : #private }
BlSpaceTaskQueue >> onTaskDequeued: aBlTask [
	space dispatchEvent: (BlSpaceTaskDequeuedEvent new task: aBlTask)
]

{ #category : #private }
BlSpaceTaskQueue >> onTaskEnqueued: aBlTask [
	space dispatchEvent: (BlSpaceTaskEnqueuedEvent new task: aBlTask)
]

{ #category : #private }
BlSpaceTaskQueue >> onTaskExecuted: aBlTask [
	space dispatchEvent: (BlSpaceTaskExecutedEvent new task: aBlTask)
]

{ #category : #private }
BlSpaceTaskQueue >> requeue: aBlTask [

	super requeue: aBlTask.
	aBlTask onEnqueued: space.
	space requestNextPulse.
]

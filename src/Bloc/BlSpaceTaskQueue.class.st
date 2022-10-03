Class {
	#name : #BlSpaceTaskQueue,
	#superclass : #BlTaskQueue,
	#instVars : [
		'space',
		'taskAtQueue'
	],
	#category : #'Bloc-Space - Task Queue'
}

{ #category : #'instance creation' }
BlSpaceTaskQueue class >> space: aBlSpace [

	^ self new initializeWith: aBlSpace
]

{ #category : #'api - enqueue' }
BlSpaceTaskQueue >> enqueueFrom: aBlTaskQueue [
	self
		assert: [ aBlTaskQueue isNotNil ]
		description: [ 'Queue to transfer must not be nil' ].

	self enqueueAll: aBlTaskQueue flush
]

{ #category : #initialization }
BlSpaceTaskQueue >> initializeWith: aBlSpace [

	space := aBlSpace.
	taskAtQueue := TaskAtQueue default
]

{ #category : #'instance creation' }
BlSpaceTaskQueue >> newTasks [
	"Answer a new collection for storing tasks"

	^ BlSpaceTasksCollection new
]

{ #category : #'private - hooks' }
BlSpaceTaskQueue >> onTaskDequeued: aBlTask [
	space dispatchEvent: (BlSpaceTaskDequeuedEvent new task: aBlTask)
]

{ #category : #'private - hooks' }
BlSpaceTaskQueue >> onTaskEnqueued: aBlTask [
	space dispatchEvent: (BlSpaceTaskEnqueuedEvent new task: aBlTask)
]

{ #category : #'private - hooks' }
BlSpaceTaskQueue >> onTaskExecuted: aBlTask [
	space dispatchEvent: (BlSpaceTaskExecutedEvent new task: aBlTask)
]

{ #category : #'private - hooks' }
BlSpaceTaskQueue >> onTaskRequeued: aBlTask [
	space dispatchEvent: (BlSpaceTaskRequeuedEvent new task: aBlTask)
]

{ #category : #private }
BlSpaceTaskQueue >> privateAddPending: aBlTask [
	self
		assert: [ aBlTask isKindOf: BlTask ]
		description: [ 'Must be a {1}, but was {2}' format: { BlTask name. aBlTask class name } ].

	tasks
		lock: [ :theTasks | theTasks addPendingTask: aBlTask ]
		ifNilPut: [ self newTasks ]
]

{ #category : #private }
BlSpaceTaskQueue >> privateRequeue: aBlTask [
	"This is only used internally as part of the task execution, thus the task's state should be executing"
	
	(self basicAddTask: aBlTask)
		ifTrue: [ self onTaskRequeued: aBlTask. ]
		ifFalse: [ self error: 'Failed to requeue a task: ', aBlTask printString ].

	aBlTask onEnqueued: space.
	space requestNextPulse
]

{ #category : #private }
BlSpaceTaskQueue >> privateRequeuePending: aBlTask [
	"Requeue a task if it's in a pending queue. If a task is not currently in a pending queue - do nothing.
	A task may be removed from a pending queue if it is canceled or dequeued.
	Only tasks that are #executing can be requeued."
	| wasRemovedFromPending |
	
	wasRemovedFromPending := tasks lock: [ :theTasks |
		theTasks
			ifNil: [ false ]
			ifNotNil: [ theTasks removePendingTask: aBlTask ] ].

	wasRemovedFromPending
		ifFalse: [ ^ self ].

	self
		assert: [ aBlTask isExecuting ]
		description: [ 'Tasks cannot be requeued outside execution' ].

	self privateRequeue: aBlTask
]

{ #category : #private }
BlSpaceTaskQueue >> privateRequeueRepeating: aBlTask [
	"This is only used internally as part of the task execution, thus the task's state should be executing"
	self
		assert: [ aBlTask isExecuting ]
		description: [ 'Tasks cannot be requeued outside execution' ].

	aBlTask setNew.
	self privateRequeue: aBlTask
]

{ #category : #'api - running' }
BlSpaceTaskQueue >> runOn: aSpace [
	| theTasks aWaker |
	
	aWaker := BlSpaceTaskWaker new taskQueue: self.
	
	"We store reference to tasks Array because it is possible
		that a random task is removed while enumerating a collection.
		This switch can be made atomic without the lock, but is here since the tasks shouldn't be updated while another process has the lock."
	theTasks := tasks
		lock: [ :theSpaceTasks | theSpaceTasks takeActiveTasksAsArray ]
		ifNilPut: [ self newTasks ].

	theTasks do: [ :eachTask | eachTask setPendingExecution ].

	"since we have an immutable reference to original array, there is no need to execute task within a lock"
	theTasks do: [ :aTask |
		aTask setExecuting.
	
		BlFrameTelemetry
			timeSync: [ 'Run task {1} ({2})' format: { aTask class name . aTask } ]
			during: [ BlTaskExecutionSignal for: aTask block: [ aTask run: aWaker ] ].
		self onTaskExecuted: aTask.

		aTask requeueTaskAfterExecution
			ifTrue: [ self privateRequeueRepeating: aTask ]
			ifFalse: [
				tasks
					lock: [ :theSpaceTasks |
						(theSpaceTasks hasPendingTask: aTask)
							ifFalse: [ aTask setComplete ] ]
					ifNilPut: [ self newTasks ] ] ]
]

{ #category : #private }
BlSpaceTaskQueue >> taskAtQueue [
	^ taskAtQueue
]

{ #category : #initialization }
BlSpaceTaskQueue >> taskAtQueue: anObject [
	taskAtQueue := anObject
]

{ #category : #'api - accessing' }
BlSpaceTaskQueue >> taskAtQueueSize [
	^ self taskAtQueue ifNotNil: #size ifNil: [ 0 ]
]

Class {
	#name : #BlSpaceTaskQueue,
	#superclass : #BlTaskQueue,
	#instVars : [
		'space',
		'pendingTasks',
		'taskAtQueue'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #'instance creation' }
BlSpaceTaskQueue class >> space: aBlSpace [

	^ self new initializeWith: aBlSpace
]

{ #category : #private }
BlSpaceTaskQueue >> basicRemoveTask: aBlTask [
	| isRemoved |
	isRemoved := false.
		
	lock critical: [
		tasks ifNotNil: [ :theTasks |
			isRemoved := (theTasks remove: aBlTask ifAbsent: [ nil ]) notNil ].
		
		isRemoved := isRemoved | (pendingTasks remove: aBlTask ifAbsent: [ nil ]) notNil ].

	^ isRemoved
]

{ #category : #initialization }
BlSpaceTaskQueue >> initializeWith: aBlSpace [

	space := aBlSpace.
	pendingTasks := Set new.
	taskAtQueue := TaskAtQueue default
]

{ #category : #testing }
BlSpaceTaskQueue >> isEmpty [
	<return: #Boolean>

	^ lock critical: [ (tasks isNil or: [ tasks isEmpty ]) and: [ pendingTasks isEmpty ] ]
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
BlSpaceTaskQueue >> onTaskRequeued: aBlTask [
	space dispatchEvent: (BlSpaceTaskRequeuedEvent new task: aBlTask)
]

{ #category : #private }
BlSpaceTaskQueue >> privateAddPending: aTask [
	self
		assert: [ aTask isKindOf: BlTask ]
		description: [ 'Must be a {1}, but was {2}' format: { BlTask name. aTask class name } ].

	lock critical: [ pendingTasks add: aTask ]
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
	| aPendingTask |
	
	aPendingTask := lock critical: [ pendingTasks remove: aBlTask ifAbsent: [ nil ] ].
	aPendingTask
		ifNil: [ ^ self ].

	self
		assert: [ aBlTask isExecuting ]
		description: [ 'Tasks cannot be requeued outside execution' ].

	self privateRequeue: aPendingTask
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
	
	lock critical: [
		"We store reference to tasks Array because it is possible
		that a random task is removed while enumerating a collection.
		This switch can be made atomic without the lock, but is here since the tasks shouldn't be updated while another process has the lock."
		theTasks := tasks.
		tasks := nil.
		"Mark all tasks as pending"
		theTasks ifNotNil:
			[ theTasks do: [ :task | task setPendingExecution ] ] ].

	"since we have an immutable reference to original array, there is no need to execute task within a lock"
	theTasks ifNotNil:
		[ theTasks do: [ :aTask |
			aTask setExecuting.
		
			BlFrameTelemetry
				timeSync: [ 'Run task {1} ({2})' format: { aTask class name . aTask } ]
				during: [ BlTaskExecutionSignal for: aTask block: [ aTask run: aWaker ] ].
			self onTaskExecuted: aTask.

			aTask requeueTaskAfterExecution
				ifTrue: [ self privateRequeueRepeating: aTask ]
				ifFalse: [
					(lock critical: [ pendingTasks includes: aTask ])
						ifFalse: [ aTask setComplete ] ] ] ]
]

{ #category : #private }
BlSpaceTaskQueue >> taskAtQueue [
	^ taskAtQueue
]

{ #category : #initialization }
BlSpaceTaskQueue >> taskAtQueue: anObject [
	taskAtQueue := anObject
]

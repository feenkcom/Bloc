Class {
	#name : #BlTaskQueue,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'tasks'
	],
	#category : #'Bloc-Space - Task Queue'
}

{ #category : #'api - accessing' }
BlTaskQueue >> allTasks [
	"Return a new collection instance holding all my tasks"

	<return: #Array of: #BlTask>

	^ tasks lock: [ :theTasks |
		theTasks
			ifNil: [ #() ]
			ifNotNil: [ theTasks allTasks ] ]
]

{ #category : #private }
BlTaskQueue >> basicAddTask: aBlTask [
	"Return true if task was succesfully added, false otherwise.
	A task might not be added if it already existed."
	<return: #Boolean>
	
	^ tasks
		lock: [ :theTasks |
			| taskWasAdded |
			taskWasAdded := theTasks addTask: aBlTask.
			taskWasAdded ifTrue: [ aBlTask setQueued ].
			taskWasAdded ]
		ifNilPut: [ self newTasks ]
]

{ #category : #private }
BlTaskQueue >> basicRemoveTask: aBlTask [
	"Try to remove a given task and return true if it was removed, false otherwise."
	<return: #Boolean>

	^ tasks lock: [ :theTasks |
		theTasks
			ifNil: [ false ]
			ifNotNil: [ theTasks removeTask: aBlTask ] ]
]

{ #category : #private }
BlTaskQueue >> critical: aBlock [
	^ tasks lock: aBlock
]

{ #category : #'api - enqueue' }
BlTaskQueue >> dequeue: aBlTask [	
	"Remove the task from the queue.
	If complete, mark the task as new so it may be reused."

	self
		assert: [ aBlTask isNotNil ]
		description: [ 'Task must not be nil' ].

	(self basicRemoveTask: aBlTask)
		ifTrue: [
			aBlTask setNew.
			self onTaskDequeued: aBlTask ]
]

{ #category : #'api - enqueue' }
BlTaskQueue >> enqueue: aBlTask [
	self
		assert: [ aBlTask isNotNil ]
		description: [ 'Task must not be nil' ].

	"Tasks must be new.
	Tasks that are already complete could also be allowed, but requiring new tasks means that any state in the task should have also been reset"
	self
		assert: [ aBlTask isNew ]
		description: [ 'Tasks cannot be submitted twice' ].

	(self basicAddTask: aBlTask)
		ifTrue: [ self onTaskEnqueued: aBlTask. ]
		ifFalse: [ self error: 'Failed to enqueue a task: ', aBlTask printString ]
]

{ #category : #'api - enqueue' }
BlTaskQueue >> enqueueAll: aCollectionOfBlTask [
	| tasksAded |

	self
		assert: [ aCollectionOfBlTask isNotNil ]
		description: [ 'Tasks must not be nil' ].

	tasks
		lock: [ :theTasks |
			(tasksAded := theTasks addAllTasks: aCollectionOfBlTask)
				ifTrue: [
					aCollectionOfBlTask do: [ :task | task setQueued ].
					aCollectionOfBlTask do: [ :eachTask | self onTaskEnqueued: eachTask ] ] ]
		ifNilPut: [ self newTasks ].

	self
		assert: [ tasksAded ]
		description: [ 'Tasks must not exist' ]
]

{ #category : #'api - enqueue' }
BlTaskQueue >> flush [
	<return: #Array of: #BlTask>
	| theTasks |
	
	"While assignments without message sends are atomic, so the sequence can't be interrupted, it's possible that a process switch would clear the tasks while another process is within the lock, so take the lock out here."
	tasks lock: [ :existingTasks |
		theTasks := existingTasks.
		tasks value: nil ].

	^ theTasks
		ifNil: [ #() ]
		ifNotNil: [ theTasks removeAllTasks ]
]

{ #category : #'api - accessing' }
BlTaskQueue >> hasTasks [
	<return: #Boolean>

	^ tasks lock: [ :theTasks |
		theTasks
			ifNil: [ false ]
			ifNotNil: [ theTasks hasTasks ] ]
]

{ #category : #initialization }
BlTaskQueue >> initialize [
	super initialize.
	
	"Tasks are initialized lazily"
	tasks := AsyncMutex new
]

{ #category : #'api - accessing' }
BlTaskQueue >> isEmpty [
	<return: #Boolean>

	^ self hasTasks not
]

{ #category : #'api - accessing' }
BlTaskQueue >> isNotEmpty [
	<return: #Boolean>

	^ self hasTasks
]

{ #category : #private }
BlTaskQueue >> newTasks [
	"Answer a new collection for storing tasks"

	^ BlTasksCollection new
]

{ #category : #'private - hooks' }
BlTaskQueue >> onTaskDequeued: aBlTask [
	"Is sent when a given task is dequeued from the task queue.
	The method is executed within the queue's lock"
]

{ #category : #'private - hooks' }
BlTaskQueue >> onTaskEnqueued: aBlTask [
	"Is sent when a given task is enqueued in the task queue.
	The method is executed within the queue's lock"
]

{ #category : #'private - hooks' }
BlTaskQueue >> onTaskExecuted: aBlTask [
	"Is sent when a given task is executed.
	The method is NOT executed within the queue's lock"
]

{ #category : #printing }
BlTaskQueue >> printOn: aStream [

	super printOn: aStream.
	tasks ifNotNil: 
		[ aStream
			nextPut: $(;
			print: self tasksSize;
			nextPut: $) ]
]

{ #category : #'api - accessing' }
BlTaskQueue >> tasks [
	"Return a new collection instance holding all my tasks"

	"tasks are an OrderedCollection (or nil), thus converting to anArray is guaranteed to answer a copy"
	^ tasks lock: [ :theTasks |
		theTasks
			ifNil: [ #() ]
			ifNotNil: [ theTasks asArray ] ]
]

{ #category : #'api - accessing' }
BlTaskQueue >> tasksSize [
	^ tasks lock: [ :theTasks | theTasks ifNil: [ 0 ] ifNotNil: #allTasksSize ]
]

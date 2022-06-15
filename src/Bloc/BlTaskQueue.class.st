Class {
	#name : #BlTaskQueue,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'tasks',
		'lock'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #private }
BlTaskQueue >> basicAddTask: aBlTask [
	| taskExists |

	lock critical: [
		tasks ifNil: [ tasks := self newTasks ].
		taskExists := tasks includes: aBlTask.
		taskExists ifFalse: [
			tasks add: aBlTask.
			aBlTask setQueued ] ].

	^ taskExists not
]

{ #category : #private }
BlTaskQueue >> basicRemoveTask: aBlTask [
	| isRemoved |
	isRemoved := false.
		
	lock critical: [
		tasks ifNotNil: [ :theTasks |
			isRemoved := (theTasks remove: aBlTask ifAbsent: [ nil ]) notNil ] ].

	^ isRemoved
]

{ #category : #private }
BlTaskQueue >> critical: aBlock [
	^ lock critical: aBlock
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
	| taskExists |

	self
		assert: [ aCollectionOfBlTask isNotNil ]
		description: [ 'Tasks must not be nil' ].

	lock critical: [
		tasks ifNil: [ tasks := self newTasks ].
		taskExists := tasks includesAny: aCollectionOfBlTask.
		taskExists ifFalse:
			[ aCollectionOfBlTask do: [ :task | task setQueued ].
			tasks addAll: aCollectionOfBlTask.
			aCollectionOfBlTask do: [ :eachTask | self onTaskEnqueued: eachTask ] ] ].

	self
		assert: [ taskExists not ]
		description: [ 'Tasks must not exist' ].

]

{ #category : #'api - enqueue' }
BlTaskQueue >> enqueueFrom: aBlTaskQueue [
	self
		assert: [ aBlTaskQueue isNotNil ]
		description: [ 'Queue to transfer must not be nil' ].

	aBlTaskQueue critical: [
		self enqueueAll: aBlTaskQueue tasks.
		aBlTaskQueue flush ]
]

{ #category : #'api - enqueue' }
BlTaskQueue >> flush [
	| theTasks |

	"While assignments without message sends are atomic, so the sequence can't be interrupted, it's possible that a process switch would clear the tasks while another process is within the lock, so take the lock out here."
	lock critical: [
		theTasks := tasks.
		tasks := nil ].

	^ theTasks
]

{ #category : #initialization }
BlTaskQueue >> initialize [
	super initialize.
	
	lock := Monitor new
]

{ #category : #'api - accessing' }
BlTaskQueue >> isEmpty [
	<return: #Boolean>

	^ lock critical: [ tasks isNil or: [ tasks isEmpty ] ]
]

{ #category : #private }
BlTaskQueue >> newTasks [
	"Answer a new collection for storing tasks"

	^ OrderedCollection new.
]

{ #category : #private }
BlTaskQueue >> onTaskDequeued: aBlTask [
	"Is sent when a given task is dequeued from the task queue.
	The method is executed within the queue's lock"
]

{ #category : #private }
BlTaskQueue >> onTaskEnqueued: aBlTask [
	"Is sent when a given task is enqueued in the task queue.
	The method is executed within the queue's lock"
]

{ #category : #private }
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
			print: tasks size;
			nextPut: $) ]
]

{ #category : #'api - accessing' }
BlTaskQueue >> tasks [
	"Return a new collection instance holding all my tasks"

	tasks ifNil: [ ^ #() ].
	"tasks are an OrderedCollection (or nil), thus converting to anArray is guaranteed to answer a copy"
	^ lock critical: 
		[ tasks 
			ifNil: [ #() ]
			ifNotNil: [ tasks asArray ] ].

]

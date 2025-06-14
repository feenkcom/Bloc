Class {
	#name : #BlSpaceTasksCollection,
	#superclass : #Object,
	#traits : 'TBlTasksCollection',
	#classTraits : 'TBlTasksCollection classTrait',
	#instVars : [
		'activeTasks',
		'pendingTasks'
	],
	#category : #'Bloc-Space - Task Queue'
}

{ #category : #'api - adding / removing' }
BlSpaceTasksCollection >> addAllTasks: aCollectionOfBlTask [
	"Try to add all given tassk and return true if the tasks didn't exist yet and all of them were added, false otherwise"
	<return: #Boolean>
	
	^ activeTasks addAllTasks: aCollectionOfBlTask
]

{ #category : #'api - adding / removing' }
BlSpaceTasksCollection >> addPendingTask: aBlTask [
	<return: #Boolean>
	
	^ pendingTasks addTask: aBlTask
]

{ #category : #'api - adding / removing' }
BlSpaceTasksCollection >> addTask: aBlTask [
	"Try to add a given task and return true if the tasks didn't exist yet and was added, false otherwise"
	<return: #Boolean>
	
	^ activeTasks addTask: aBlTask
]

{ #category : #accessing }
BlSpaceTasksCollection >> allTasksSize [
	^ activeTasks allTasksSize + pendingTasks allTasksSize
]

{ #category : #converting }
BlSpaceTasksCollection >> asArray [
	"Return registered tasks as an array (a copy of the tasks collection)"
	<return: #Array of: #BlTask>
	
	^ activeTasks asArray
]

{ #category : #converting }
BlSpaceTasksCollection >> asPendingTasksArray [
	"Return registered tasks as an array (a copy of the tasks collection).
	Note: do not use in production code. It can be used for testing purposes, e.g., in BlScripter."
	<return: #Array of: #BlTask>
	
	^ pendingTasks asArray
]

{ #category : #'api - testing' }
BlSpaceTasksCollection >> hasDefiniteTermTasks [
	"Identifies whether there are tasks with definite terms.
	See `BlTask>>#isIndefiniteTermTask` for more details.
	BlScripter uses it to ignore such tasks while pulsing."
	<return: #Boolean>
	
	^ activeTasks hasDefiniteTermTasks or: [ pendingTasks hasDefiniteTermTasks ]
]

{ #category : #'api - testing' }
BlSpaceTasksCollection >> hasPendingTask: aBlTask [
	"Return true if a given task is one of the pending tasks, false otherwise."
	<return: #Boolean>

	^ pendingTasks hasTask: aBlTask
]

{ #category : #'api - testing' }
BlSpaceTasksCollection >> hasTask: aBlTask [
	"Return true if a given task is present in the collection, false otherwise"
	<return: #Boolean>
	
	^ (activeTasks hasTask: aBlTask) or: [ pendingTasks hasTask: aBlTask ]
]

{ #category : #'api - testing' }
BlSpaceTasksCollection >> hasTasks [
	"Return true if there is at least one task, false otherwise."
	<return: #Boolean>
	
	^ activeTasks hasTasks or: [ pendingTasks hasTasks ]
]

{ #category : #initialization }
BlSpaceTasksCollection >> initialize [
	super initialize.
	
	activeTasks := self newActiveTasks.
	pendingTasks := BlTasksCollection new
]

{ #category : #'private - instance creation' }
BlSpaceTasksCollection >> newActiveTasks [
	^ BlTasksCollection new
]

{ #category : #debugging }
BlSpaceTasksCollection >> pendingItemArray [
	"Get all pending tasks.
	For debugging purposes only, e.g., BlScripter. Do not use it in a production code."

	<return: #Array of: #BlTask>
	^ pendingTasks asArray
]

{ #category : #'api - adding / removing' }
BlSpaceTasksCollection >> removeAllTasks [
	"Remove all tasks an return them in an array"
	<return: #Array of: #BlTask>
	
	^ activeTasks removeAllTasks
]

{ #category : #'api - adding / removing' }
BlSpaceTasksCollection >> removePendingTask: aBlTask [
	<return: #Boolean>
	
	^ pendingTasks removeTask: aBlTask
]

{ #category : #'api - adding / removing' }
BlSpaceTasksCollection >> removeTask: aBlTask [
	"Try to remove a task and return true if the task existed and was removed, false otherwise"
	<return: #Boolean>
	
	^ (activeTasks removeTask: aBlTask) | (pendingTasks removeTask: aBlTask)
]

{ #category : #'api - accessing' }
BlSpaceTasksCollection >> takeActiveTasksAsArray [
	<return: #Array of: #BlTask>
	
	^ activeTasks hasTasks
		ifTrue: [
			| theTasks |
			theTasks := activeTasks.
			activeTasks := self newActiveTasks.
			theTasks asArray ]
		ifFalse: [ #() ]
]

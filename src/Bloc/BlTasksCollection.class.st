Class {
	#name : #BlTasksCollection,
	#superclass : #Object,
	#traits : 'TBlTasksCollection',
	#classTraits : 'TBlTasksCollection classTrait',
	#instVars : [
		'tasks'
	],
	#category : #'Bloc-Space - Task Queue'
}

{ #category : #'api - adding / removing' }
BlTasksCollection >> addAllTasks: aCollectionOfBlTask [
	"Try to add all given tassk and return true if the tasks didn't exist yet and all of them were added, false otherwise"
	<return: #Boolean>
	
	(tasks includesAny: aCollectionOfBlTask)
		ifTrue: [ ^ false ].
		
	tasks addAll: aCollectionOfBlTask.
	^ true
]

{ #category : #'api - adding / removing' }
BlTasksCollection >> addTask: aBlTask [
	"Try to add a given task and return true if the tasks didn't exist yet and was added, false otherwise"
	<return: #Boolean>
	
	(self hasTask: aBlTask)
		ifTrue: [ ^ false ].

	tasks add: aBlTask.
	^ true
]

{ #category : #accessing }
BlTasksCollection >> allTasksSize [
	^ self size
]

{ #category : #'api - converting' }
BlTasksCollection >> asArray [
	"Return registered tasks as an array (a copy of the tasks collection)"
	<return: #Array of: #BlTask>
	
	^ tasks asArray
]

{ #category : #'api - testing' }
BlTasksCollection >> hasTask: aBlTask [
	"Return true if a given task is present in the collection, false otherwise"
	<return: #Boolean>
	
	^ tasks includes: aBlTask
]

{ #category : #'api - testing' }
BlTasksCollection >> hasTasks [
	"Return true if there is at least one task, false otherwise."
	<return: #Boolean>
	
	^ tasks isNotEmpty
]

{ #category : #initialization }
BlTasksCollection >> initialize [
	super initialize.
	
	tasks := OrderedCollection new
]

{ #category : #printing }
BlTasksCollection >> printOn: aStream [
	super printOn: aStream.

	tasks ifNil: [ ^ self ].

	aStream
		nextPut: $[;
		print: self size;
		nextPutAll: (' item' asPluralBasedOn: self size);
		nextPut: $]
]

{ #category : #'api - adding / removing' }
BlTasksCollection >> removeAllTasks [
	"Remove all tasks an return them in an array"
	<return: #Array of: #BlTask>
	| theTasks |
	
	theTasks := tasks asArray.
	tasks removeAll.
	
	^ theTasks
]

{ #category : #'api - adding / removing' }
BlTasksCollection >> removeTask: aBlTask [
	"Try to remove a task and return true if the task existed and was removed, false otherwise"
	<return: #Boolean>
	
	^ (tasks remove: aBlTask ifAbsent: [ nil ]) notNil
]

{ #category : #accessing }
BlTasksCollection >> size [
	^ tasks size
]

Trait {
	#name : #TBlTasksCollection,
	#category : #'Bloc-Space - Task Queue'
}

{ #category : #'api - adding / removing' }
TBlTasksCollection >> addAllTasks: aCollectionOfBlTask [
	"Try to add all given tassk and return true if the tasks didn't exist yet and all of them were added, false otherwise"
	<return: #Boolean>
	
	^ self explicitRequirement
]

{ #category : #'api - adding / removing' }
TBlTasksCollection >> addTask: aBlTask [
	"Try to add a given task and return true if the task didn't exist yet and was added, false otherwise"
	<return: #Boolean>
	
	^ self explicitRequirement
]

{ #category : #'api - testing' }
TBlTasksCollection >> hasTask: aBlTask [
	"Return true if a given task is present in the collection, false otherwise"
	<return: #Boolean>
	
	^ self explicitRequirement
]

{ #category : #'api - testing' }
TBlTasksCollection >> hasTasks [
	"Return true if there is at least one task, false otherwise."
	<return: #Boolean>
	
	^ self explicitRequirement
]

{ #category : #'api - adding / removing' }
TBlTasksCollection >> removeAllTasks [
	"Remove all tasks an return them in an array"
	<return: #Array of: #BlTask>
	
	^ self explicitRequirement
]

{ #category : #'api - adding / removing' }
TBlTasksCollection >> removeTask: aBlTask [
	"Try to remove a task and return true if the task existed and was removed, false otherwise"
	<return: #Boolean>
	
	^ self explicitRequirement
]

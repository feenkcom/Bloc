Class {
	#name : #BlSpaceTaskWaker,
	#superclass : #Object,
	#instVars : [
		'taskQueue'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #'api - lifecycle' }
BlSpaceTaskWaker >> bePending: aTask [
	taskQueue privateAddPending: aTask
]

{ #category : #accessing }
BlSpaceTaskWaker >> taskQueue [
	<return: #BlSpaceTaskQueue>

	^ taskQueue
]

{ #category : #accessing }
BlSpaceTaskWaker >> taskQueue: aBlSpaceTaskQueue [
	taskQueue := aBlSpaceTaskQueue
]

{ #category : #'api - lifecycle' }
BlSpaceTaskWaker >> wakeUp: aTask [
	taskQueue privateRequeuePending: aTask
]

{ #category : #'api - lifecycle' }
BlSpaceTaskWaker >> wakeUp: aTask at: aTime [
	self bePending: aTask.
	taskQueue taskAtQueue
		schedule: [ self wakeUp: aTask ]
		at: aTime
]

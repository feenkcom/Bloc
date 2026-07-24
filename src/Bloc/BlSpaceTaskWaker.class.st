Class {
	#name : #BlSpaceTaskWaker,
	#superclass : #Object,
	#instVars : [
		'taskQueue'
	],
	#category : #'Bloc-Space - Task Queue'
}

{ #category : #'api - lifecycle' }
BlSpaceTaskWaker >> bePending: aTask [
	self taskQueueDo: [ :aTaskQueue |
		aTaskQueue privateAddPending: aTask ]
]

{ #category : #accessing }
BlSpaceTaskWaker >> taskQueue [
	<return: #BlSpaceTaskQueue or: nil>

	self taskQueueDo: [ :aTaskQueue |
		^ aTaskQueue ].
	^ nil
]

{ #category : #accessing }
BlSpaceTaskWaker >> taskQueue: aBlSpaceTaskQueue [
	taskQueue := aBlSpaceTaskQueue asWeakReference
]

{ #category : #private }
BlSpaceTaskWaker >> taskQueueDo: aBlock [
	"Temporary solution. We can simplify the method in couple of days.
	See https://github.com/feenkcom/gtoolkit/issues/3923"

	(taskQueue isKindOf: WeakArray)
		ifTrue: [ (taskQueue at: 1) 
			ifNotNil: [ :aTaskQueue | 
				aBlock cull: aTaskQueue ].
			^ self ].
			
	aBlock cull: taskQueue.
]

{ #category : #'api - lifecycle' }
BlSpaceTaskWaker >> wakeUp: aTask [
	self taskQueueDo: [ :aTaskQueue |
		aTaskQueue privateRequeuePending: aTask ]
]

{ #category : #'api - lifecycle' }
BlSpaceTaskWaker >> wakeUp: aTask at: aTime [
	self bePending: aTask.
	self taskQueueDo: [ :aTaskQueue |
		aTaskQueue taskAtQueue
			schedule: [ self wakeUp: aTask ]
			at: aTime ]
]

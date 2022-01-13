Class {
	#name : #BlSpaceTaskEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'tasks',
		'frameId',
		'task'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceTaskEvent >> frameId [

	^ frameId
]

{ #category : #testing }
BlSpaceTaskEvent >> isDequeuedEvent [
	^ false
]

{ #category : #testing }
BlSpaceTaskEvent >> isTaskDequeuedEvent [
	^ false
]

{ #category : #testing }
BlSpaceTaskEvent >> isTaskEnqueuedEvent [
	^ false
]

{ #category : #testing }
BlSpaceTaskEvent >> isTaskExecutedEvent [
	^ false
]

{ #category : #initialization }
BlSpaceTaskEvent >> prepareForDelivery [
	super prepareForDelivery.

	tasks ifNil: [ tasks := self currentTarget taskQueue tasks ].
	frameId ifNil: [ frameId := self currentTarget frame id ]
]

{ #category : #accessing }
BlSpaceTaskEvent >> task [
	<return: #BlTask>

	^ task
]

{ #category : #accessing }
BlSpaceTaskEvent >> task: aBlTask [
	task := aBlTask
]

{ #category : #accessing }
BlSpaceTaskEvent >> tasks [

	^ tasks
]

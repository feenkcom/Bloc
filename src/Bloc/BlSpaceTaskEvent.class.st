Class {
	#name : #BlSpaceTaskEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'tasks',
		'frameId',
		'task',
		'processId'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceTaskEvent >> frameId [

	^ frameId
]

{ #category : #initialization }
BlSpaceTaskEvent >> initialize [
	super initialize.
	
	processId := Processor activeProcess name.
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

{ #category : #testing }
BlSpaceTaskEvent >> isTaskRequeuedEvent [
	^ false
]

{ #category : #initialization }
BlSpaceTaskEvent >> prepareForDelivery [
	super prepareForDelivery.

	tasks ifNil: [ tasks := self currentTarget taskQueue tasks ].
	frameId ifNil: [ frameId := self currentTarget frame id ]
]

{ #category : #accessing }
BlSpaceTaskEvent >> processId [
	^ processId
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

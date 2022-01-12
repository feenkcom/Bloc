"
Is a task that stays in the TaskQueue until the promise is fulfilled 
"
Class {
	#name : #BlPromiseTask,
	#superclass : #BlTask,
	#instVars : [
		'promise',
		'isRunning'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #initialization }
BlPromiseTask >> initialize [
	super initialize.
	
	isRunning := false
]

{ #category : #printing }
BlPromiseTask >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."
	aStream
		nextPutAll: 'Promise task: ';
		print: promise
]

{ #category : #accessing }
BlPromiseTask >> promise: anAsyncPromise [
	promise := anAsyncPromise
]

{ #category : #'private - testing' }
BlPromiseTask >> requeueTaskAfterExecution [
	"Answer a boolean indicating whether the receiver should be requeued after execution."

	^ isRunning
]

{ #category : #'api - running' }
BlPromiseTask >> run [
	isRunning
		ifTrue: [ ^ self ].
	
	isRunning := true.
	promise
		then: [ :aValue | isRunning := false ]
		otherwise: [ :anError | isRunning := false ]
]

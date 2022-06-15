"
Is a task that stays in the TaskQueue until the promise is fulfilled 
"
Class {
	#name : #BlPromiseTask,
	#superclass : #BlTask,
	#instVars : [
		'promise',
		'isComputed'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #printing }
BlPromiseTask >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."
	aStream
		nextPutAll: 'Promise task: ';
		print: promise
]

{ #category : #accessing }
BlPromiseTask >> promise: anAsyncPromise [
	promise := anAsyncPromise.
	isComputed := false
]

{ #category : #'api - running' }
BlPromiseTask >> run: aWaker [
	| wasSynchronous |

	isComputed
		ifTrue: [ ^ self ].

	wasSynchronous := false.
	promise
		then: [ :aValue :isSynchronous |
			isComputed := true.
			wasSynchronous := isSynchronous.
			isSynchronous ifFalse: [ aWaker wakeUp: self ] ]
		otherwise: [ :anError :isSynchronous |
			isComputed := true.
			wasSynchronous := isSynchronous.
			isSynchronous ifFalse: [ aWaker wakeUp: self ] ].

	wasSynchronous ifFalse: [ aWaker bePending: self ]
]

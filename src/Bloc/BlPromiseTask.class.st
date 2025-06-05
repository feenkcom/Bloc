"
Is a task that stays in the TaskQueue until the promise is fulfilled 
"
Class {
	#name : #BlPromiseTask,
	#superclass : #BlTask,
	#instVars : [
		'isComputed',
		'isRegistered',
		'weakPromise',
		'hardPromise'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #finalization }
BlPromiseTask >> finalize: aWaker [
	"I am called when my promise is finalized.
	It may happen, that my promise is still in my weak reference.
	For that reason I first remove it and then wake up my waker.
	See Object>>#finalize for more details."

	weakPromise ifNotNil: [ :aWeak | aWeak at: 1 put: nil ].
	aWaker wakeUp: self
]

{ #category : #printing }
BlPromiseTask >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."
	aStream
		nextPutAll: 'Promise task: ';
		print: self promise
]

{ #category : #accessing }
BlPromiseTask >> promise [
	<return: #TAsyncPromise or: nil>
	^ weakPromise at: 1
]

{ #category : #accessing }
BlPromiseTask >> promise: anAsyncPromise [
	self
		assert: [ anAsyncPromise isAsyncPromise ]
		description: [ 'Expected a promise but got: ' , anAsyncPromise printString ].

	hardPromise := anAsyncPromise.
	weakPromise := anAsyncPromise asWeakReference.
	isComputed := false.
	isRegistered := false.
]

{ #category : #'api - running' }
BlPromiseTask >> run: aWaker [
	| wasSynchronous aPromise |
	
	aPromise := hardPromise 
		ifNil: [ ^ self ].
		
	hardPromise := nil.
	
	isComputed
		ifTrue: [ ^ self ].

	wasSynchronous := false.
	aPromise
		then: [ :aValue :isSynchronous |
			isComputed := true.
			wasSynchronous := isSynchronous.
			isSynchronous ifFalse: [ aWaker wakeUp: self ] ]
		otherwise: [ :anError :isSynchronous |
			isComputed := true.
			wasSynchronous := isSynchronous.
			isSynchronous ifFalse: [ aWaker wakeUp: self ] ].

	wasSynchronous ifFalse: [
		aWaker bePending: self.
		aPromise whenIndefinitelyPending: [
			isComputed := true.
			aWaker wakeUp: self ] ].
			
	isComputed ifTrue: [ ^ self ].
	isRegistered ifTrue: [ ^ self ].
	isRegistered := true.
	
	self
		forPharo11OrNewer: [ aPromise finalizationRegistry
				add: aPromise
				finalizer: (ObjectFinalizer new
						receiver: self;
						selector: #finalize:;
						arguments: { aWaker }) ]
		forPharo10: [ aPromise finalizationRegistry
				add: aPromise
				executor: (ObjectFinalizer new
						receiver: self;
						selector: #finalize:;
						arguments: {aWaker}) ].
	
]

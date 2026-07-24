Class {
	#name : #BlEventsStream,
	#superclass : #Object,
	#traits : 'TAsyncStream',
	#classTraits : 'TAsyncStream classTrait',
	#instVars : [
		'eventTarget',
		'eventClass',
		'waker',
		'eventHandler',
		'events',
		'shouldLimitToOne'
	],
	#category : #'Bloc-Events-Handler'
}

{ #category : #'instance creation' }
BlEventsStream class >> forEventTarget: anEventTarget on: anEvent [
	^ self new registerTo: anEventTarget on: anEvent
]

{ #category : #initialization }
BlEventsStream >> finalize [
	super finalize.
	
	eventTarget removeEventHandler: eventHandler
]

{ #category : #printing }
BlEventsStream >> gtDisplayOn: aStream [
	self printOn: aStream.
	
	aStream
		nextPutAll: ' on ';
		print: eventClass
]

{ #category : #initialization }
BlEventsStream >> initialize [
	super initialize.
	
	shouldLimitToOne := false
]

{ #category : #initialization }
BlEventsStream >> keepOnlyLast [
	shouldLimitToOne := true
]

{ #category : #'private - event handling' }
BlEventsStream >> onEvent: anEvent [
	events lock: [ :theEvents |
		shouldLimitToOne ifTrue: [ theEvents removeAll ].
		theEvents addLast: anEvent.
		waker wakeUp ]
]

{ #category : #'api - stream' }
BlEventsStream >> pollNext: anAsynchronousContext [
	"Attempt to pull out the next value of this stream, registering the current task for wakeup if the value is not yet available, and returning None if the stream is exhausted.
	There are several possible return values, each indicating a distinct stream state:
	 - Poll::Pending means that this stream's next value is not ready yet. Implementations will ensure that the current task will be notified when the next value may be ready.
	 - Poll::Ready(Some(val)) means that the stream has successfully produced a value, val, and may produce further values on subsequent poll_next calls.
	 - Poll::Ready(None) means that the stream has terminated, and poll_next should not be invoked again."
	<return: #AsyncPoll>
	
	^ events lock: [ :theEvents |
		theEvents
			ifEmpty: [
				waker register: anAsynchronousContext waker.
				AsyncPoll indefinitelyPending ]
			ifNotEmpty: [
				AsyncPoll ready: (AsyncOptionalValue some: theEvents removeFirst) ] ]
]

{ #category : #'api - stream copy' }
BlEventsStream >> postSimilarCopy [
	"Is called by similarCopy. self is a shallow copy, implementors should set the fields as necessary to complete the similar copy"
	
	self registerTo: eventTarget on: eventClass
]

{ #category : #initialization }
BlEventsStream >> registerTo: anEventTarget on: anEventClass [
	events := AsyncMutex for: LinkedList new.
	waker := AsyncFutureExecutionAtomicWaker new.

	eventTarget := anEventTarget.
	eventClass := anEventClass.
	
	eventHandler := BlEventHandler on: anEventClass do: (WeakMessageSend receiver: self selector: #onEvent:).
	
	eventTarget addEventHandler: eventHandler.
	
	self class finalizationRegistry add: self
]

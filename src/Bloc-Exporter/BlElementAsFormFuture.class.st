Class {
	#name : #BlElementAsFormFuture,
	#superclass : #Object,
	#traits : 'TAsyncFuture',
	#classTraits : 'TAsyncFuture classTrait',
	#instVars : [
		'targetElement',
		'contextElement',
		'preferredExtent',
		'preferredScaleFactor',
		'hdpiScaleFactor',
		'form',
		'taskIsEnqueued',
		'waker'
	],
	#category : #'Bloc-Exporter'
}

{ #category : #'instance creation' }
BlElementAsFormFuture class >> forElement: anElement [
	^ self new
		targetElement: anElement
]

{ #category : #private }
BlElementAsFormFuture >> doRender [
	| aSnapshot |

	aSnapshot := targetElement
		asSpartaForm: preferredExtent value
		scaleFactor: preferredScaleFactor value
		hdpiScaleFactor: hdpiScaleFactor.

	form := AsyncOptionalValue some: aSnapshot.
	waker wakeUp
]

{ #category : #private }
BlElementAsFormFuture >> enqueueRenderTask [
	| shouldForcePulse |
	
	shouldForcePulse := true.
	targetElement spaceDo: [ :aSpace | aSpace universe uiProcessDo: [ :aUIProcess |
		shouldForcePulse := aUIProcess isSuspended or: [ aUIProcess isTerminated or: [ aUIProcess isTerminating ] ] ]  ].
	
	shouldForcePulse
		ifTrue: [ self doRender ]
		ifFalse: [ targetElement enqueueTask: (BlTaskAction new action: [ self doRender ]) ]
]

{ #category : #accessing }
BlElementAsFormFuture >> hdpiScaleFactor [
	^ hdpiScaleFactor
]

{ #category : #accessing }
BlElementAsFormFuture >> hdpiScaleFactor: aNumber [
	hdpiScaleFactor := aNumber
]

{ #category : #initialization }
BlElementAsFormFuture >> initialize [
	super initialize.

	preferredExtent := AsyncOptionalValue none.
	preferredScaleFactor := AsyncOptionalValue none.
	hdpiScaleFactor := 1.0.

	taskIsEnqueued := false.
	waker := AsyncFutureExecutionAtomicWaker new.
	form := AsyncOptionalValue none
]

{ #category : #'api - future' }
BlElementAsFormFuture >> poll: anAsynchronousContext [
	<return: #AsyncPoll>

	taskIsEnqueued
		ifFalse: [
			self enqueueRenderTask.
			taskIsEnqueued := true ].

	^ form
		ifSome: [ :aForm |
			AsyncPoll ready: aForm  ]
		ifNone: [
			waker register: anAsynchronousContext waker.
			AsyncPoll pending ]
]

{ #category : #accessing }
BlElementAsFormFuture >> preferredExtent: anExtent [
	preferredExtent := AsyncOptionalValue some: anExtent
]

{ #category : #accessing }
BlElementAsFormFuture >> preferredScaleFactor: aNumber [
	preferredScaleFactor := AsyncOptionalValue some: aNumber
]

{ #category : #accessing }
BlElementAsFormFuture >> targetElement: anElement [
	targetElement := anElement
]

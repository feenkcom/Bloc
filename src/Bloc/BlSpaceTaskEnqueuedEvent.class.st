Class {
	#name : #BlSpaceTaskEnqueuedEvent,
	#superclass : #BlSpaceTaskEvent,
	#instVars : [
		'stack'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #testing }
BlSpaceTaskEnqueuedEvent >> isTaskEnqueuedEvent [
	^ true
]

{ #category : #initialization }
BlSpaceTaskEnqueuedEvent >> prepareForDelivery [
	super prepareForDelivery.
	
	stack ifNil: [ stack := self relevantStackWithoutSelf ]
]

{ #category : #accessing }
BlSpaceTaskEnqueuedEvent >> relevantStackWithoutSelf [
	| s |
	s := thisContext stack.
	s := s allButFirst: (s findLast: [ :each | each receiver = self or: [ each receiver = self class ] ]).
	s := s allButFirst: (s findFirst: [ :each | each compiledCode = (BlSpaceTaskQueue >> #onTaskEnqueued:) ]).
	s := s allButFirst: (s findFirst: [ :each | each compiledCode = (BlTaskQueue >> #enqueue:) ]).
	^ s
]

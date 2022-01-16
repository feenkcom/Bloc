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
	s := s allButFirst: (s findLast: [ :each | self = each receiver or: [ self class = each receiver ] ]).
	s := s allButFirst: (s findFirst: [ :each | (BlSpaceTaskQueue >> #onTaskEnqueued:) = each compiledCode ]).
	s := s allButFirst: (s findFirst: [ :each | (BlTaskQueue >> #enqueue:) = each compiledCode ]).
	^ s
]

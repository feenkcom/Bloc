Class {
	#name : #BlSpaceTaskRequeuedEvent,
	#superclass : #BlSpaceTaskEvent,
	#instVars : [
		'stack'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #testing }
BlSpaceTaskRequeuedEvent >> isTaskRequeuedEvent [
	^ true
]

{ #category : #initialization }
BlSpaceTaskRequeuedEvent >> prepareForDelivery [
	super prepareForDelivery.
	
	stack ifNil: [ stack := self relevantStackWithoutSelf ]
]

{ #category : #accessing }
BlSpaceTaskRequeuedEvent >> relevantStackWithoutSelf [
	| s |
	s := thisContext stack.
	s := s allButFirst: (s findLast: [ :each | self = each receiver or: [ self class = each receiver ] ]).
	s := s allButFirst: (s findFirst: [ :each | (BlSpaceTaskQueue >> #onTaskRequeued:) = each compiledCode ]).
	^ s
]

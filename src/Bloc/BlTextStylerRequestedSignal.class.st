Class {
	#name : #BlTextStylerRequestedSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'element',
		'text'
	],
	#category : #'Bloc-Space - Support'
}

{ #category : #testing }
BlTextStylerRequestedSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	Excluding these signals makes a good starting point for application specific logging, or logging unexpected signals"

	^ true.
]

{ #category : #accessing }
BlTextStylerRequestedSignal >> element [
	^ element
]

{ #category : #accessing }
BlTextStylerRequestedSignal >> element: anObject [
	element := anObject
]

{ #category : #initialization }
BlTextStylerRequestedSignal >> prepareForDelivery [
	super prepareForDelivery.

	element ifNotNil: [ :anElement | 
		text := anElement text copy ]
]

{ #category : #accessing }
BlTextStylerRequestedSignal >> printOneLineContentsOn: stream [
	stream print: element identityHash; space.
	
	self text
		ifEmpty: [ stream nextPutAll: 'Empty text' ]
		ifNotEmpty: [ 
			| anIndex |
			anIndex := self text finder endOfLine; search.
			anIndex isZero 
				ifTrue: [ stream print: self text ]
				ifFalse: [ stream print: (self text from: 1 to: (anIndex - 1 max: 1)) ] ].

	stream space.
	super printOneLineContentsOn: stream
]

{ #category : #accessing }
BlTextStylerRequestedSignal >> text [
	^ text
]

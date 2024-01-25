Class {
	#name : #BlMarkElementNeedsPaintSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'element',
		'sourceElement',
		'initialBoundsInSpace',
		'boundsInSpace'
	],
	#category : #'Bloc-Space - Support'
}

{ #category : #testing }
BlMarkElementNeedsPaintSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	Excluding these signals makes a good starting point for application specific logging, or logging unexpected signals"

	^ true.
]

{ #category : #accessing }
BlMarkElementNeedsPaintSignal >> boundsInSpace [
	boundsInSpace ifNotNil: [ ^ boundsInSpace ].

	element isAttachedToSceneGraph
		ifTrue: [ boundsInSpace := element bounds inSpace asRectangle ].

	^ boundsInSpace := initialBoundsInSpace
]

{ #category : #accessing }
BlMarkElementNeedsPaintSignal >> element [
	^ element
]

{ #category : #accessing }
BlMarkElementNeedsPaintSignal >> element: anObject [
	element := anObject
]

{ #category : #accessing }
BlMarkElementNeedsPaintSignal >> prepareForDelivery [
	super prepareForDelivery.

	initialBoundsInSpace ifNil: [ initialBoundsInSpace := element bounds inSpace asRectangle ]
]

{ #category : #accessing }
BlMarkElementNeedsPaintSignal >> sourceElement [
	^ sourceElement
]

{ #category : #accessing }
BlMarkElementNeedsPaintSignal >> sourceElement: anObject [
	sourceElement := anObject
]

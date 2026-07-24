Class {
	#name : #BlRequestLayoutSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'element',
		'boundsInSpace',
		'initialBoundsInSpace'
	],
	#category : #'Bloc-Layouts-Support'
}

{ #category : #testing }
BlRequestLayoutSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	Excluding these signals makes a good starting point for application specific logging, or logging unexpected signals"

	^ true.
]

{ #category : #accessing }
BlRequestLayoutSignal >> boundsInSpace [
	boundsInSpace ifNotNil: [ ^ boundsInSpace ].

	element isAttachedToSceneGraph
		ifTrue: [ boundsInSpace := element bounds inSpace asRectangle ].

	^ boundsInSpace := initialBoundsInSpace
]

{ #category : #accessing }
BlRequestLayoutSignal >> element [
	^ element
]

{ #category : #accessing }
BlRequestLayoutSignal >> element: anObject [
	element := anObject
]

{ #category : #accessing }
BlRequestLayoutSignal >> initialBoundsInSpace [
	^ initialBoundsInSpace
]

{ #category : #accessing }
BlRequestLayoutSignal >> prepareForDelivery [
	super prepareForDelivery.

	initialBoundsInSpace ifNil: [ initialBoundsInSpace := element bounds inSpace asRectangle ]
]

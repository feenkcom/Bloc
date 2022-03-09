Class {
	#name : #BlMarkElementNeedsPaintSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'element'
	],
	#category : 'Bloc-Space - Support'
}

{ #category : #testing }
BlMarkElementNeedsPaintSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	Excluding these signals makes a good starting point for application specific logging, or logging unexpected signals"

	^ true.
]

{ #category : #accessing }
BlMarkElementNeedsPaintSignal >> element [
	^ element
]

{ #category : #accessing }
BlMarkElementNeedsPaintSignal >> element: anObject [
	element := anObject
]

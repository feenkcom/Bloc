Class {
	#name : #BlGotFocusSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Space - Support'
}

{ #category : #testing }
BlGotFocusSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	Excluding these signals makes a good starting point for application specific logging, or logging unexpected signals"

	^ true.
]

{ #category : #accessing }
BlGotFocusSignal >> element [
	^ element
]

{ #category : #accessing }
BlGotFocusSignal >> element: anObject [
	element := anObject
]

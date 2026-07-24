Class {
	#name : #BlEventErrorHandler,
	#superclass : #BlSingleErrorHandler,
	#category : #'Bloc-Core-Errors'
}

{ #category : #testing }
BlEventErrorHandler >> matches: aFramePhase [
	^ aFramePhase isEventPhase
]

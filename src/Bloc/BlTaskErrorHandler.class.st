Class {
	#name : #BlTaskErrorHandler,
	#superclass : #BlSingleErrorHandler,
	#category : #'Bloc-Core-Errors'
}

{ #category : #testing }
BlTaskErrorHandler >> matches: aFramePhase [
	^ aFramePhase isTaskPhase
]

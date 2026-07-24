Class {
	#name : #BlIdleErrorHandler,
	#superclass : #BlSingleErrorHandler,
	#category : #'Bloc-Core-Errors'
}

{ #category : #testing }
BlIdleErrorHandler >> matches: aFramePhase [
	^ aFramePhase isIdlePhase
]

{ #category : #'error handling' }
BlIdleErrorHandler >> processError: aHandledError [
	
]

Class {
	#name : #BlDevScripterStepFinishedSignal,
	#superclass : #BlDevScripterStepSignal,
	#category : #'Bloc-Scripter-Signals'
}

{ #category : #printing }
BlDevScripterStepFinishedSignal >> printOneLineContentsOn: aStream [
	aStream nextPutAll: 'Stop '.
	super printOneLineContentsOn: aStream
]

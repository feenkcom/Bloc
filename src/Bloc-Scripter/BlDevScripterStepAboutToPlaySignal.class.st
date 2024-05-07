Class {
	#name : #BlDevScripterStepAboutToPlaySignal,
	#superclass : #BlDevScripterStepSignal,
	#category : #'Bloc-Scripter-Signals'
}

{ #category : #printing }
BlDevScripterStepAboutToPlaySignal >> printOneLineContentsOn: aStream [
	aStream nextPutAll: 'Play '.
	super printOneLineContentsOn: aStream
]

Class {
	#name : #BlDevScripterStepPulsationFinishedSignal,
	#superclass : #BlDevScripterStepSignal,
	#instVars : [
		'pulseDuration',
		'numberOfPulses',
		'usedDelays'
	],
	#category : #'Bloc-Scripter-Signals'
}

{ #category : #accessing }
BlDevScripterStepPulsationFinishedSignal >> numberOfPulses [
	^ numberOfPulses
]

{ #category : #accessing }
BlDevScripterStepPulsationFinishedSignal >> numberOfPulses: anObject [
	numberOfPulses := anObject
]

{ #category : #printing }
BlDevScripterStepPulsationFinishedSignal >> printOneLineContentsOn: aStream [
	aStream nextPutAll: 'Pulsed '.
	super printOneLineContentsOn: aStream.
	aStream
		nextPutAll: ', ';
		print: numberOfPulses;
		nextPutAll: ' times'
]

{ #category : #accessing }
BlDevScripterStepPulsationFinishedSignal >> pulseDuration [
	^ pulseDuration
]

{ #category : #accessing }
BlDevScripterStepPulsationFinishedSignal >> pulseDuration: anObject [
	pulseDuration := anObject
]

{ #category : #accessing }
BlDevScripterStepPulsationFinishedSignal >> usedDelays [
	^ usedDelays
]

{ #category : #accessing }
BlDevScripterStepPulsationFinishedSignal >> usedDelays: anObject [
	usedDelays := anObject
]

Class {
	#name : #BlDevScripterStepPulsationTimeoutedSignal,
	#superclass : #BlDevScripterStepSignal,
	#instVars : [
		'pulseDuration',
		'numberOfPulses',
		'usedDelays'
	],
	#category : #'Bloc-Scripter-Signals'
}

{ #category : #accessing }
BlDevScripterStepPulsationTimeoutedSignal >> numberOfPulses [
	^ numberOfPulses
]

{ #category : #accessing }
BlDevScripterStepPulsationTimeoutedSignal >> numberOfPulses: anObject [
	numberOfPulses := anObject
]

{ #category : #accessing }
BlDevScripterStepPulsationTimeoutedSignal >> pulseDuration [
	^ pulseDuration
]

{ #category : #accessing }
BlDevScripterStepPulsationTimeoutedSignal >> pulseDuration: anObject [
	pulseDuration := anObject
]

{ #category : #accessing }
BlDevScripterStepPulsationTimeoutedSignal >> usedDelays [
	^ usedDelays
]

{ #category : #accessing }
BlDevScripterStepPulsationTimeoutedSignal >> usedDelays: anObject [
	usedDelays := anObject
]

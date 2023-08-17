Class {
	#name : #BlDevScripterStepExecutionProperty,
	#superclass : #BlDevScripterStepProperty,
	#instVars : [
		'numberOfPulses',
		'isFinishedOnTime',
		'isPulseRequested',
		'isSpaceTaskQueueWithTasks',
		'pulseDuration',
		'playDuration'
	],
	#category : #'Bloc-Scripter-Scripter-Properties'
}

{ #category : #printing }
BlDevScripterStepExecutionProperty >> gtDisplayOn: aStream [
	
	self playDuration 
		ifNotNil: [ :aDuration | 
			aStream nextPutAll: 'play: '.
			aDuration printHumanReadableOn: aStream ]
		ifNil: [ 
			aStream nextPutAll: 'missing execution information'.
			^ self ].
	self pulseDuration ifNotNil: [ :aDuration | 
		aStream nextPutAll: ', '.
		aStream nextPutAll: 'pulse: '.
		aDuration printHumanReadableOn: aStream ].
	self numberOfPulses ifNotNil: [ :aNumber |
		aStream nextPutAll: ', '.
		aStream print: aNumber.
		aStream nextPutAll: (' pulse' asPluralBasedOn: aNumber) ].
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> isFinishedOnTime [
	^ isFinishedOnTime
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> isFinishedOnTime: anObject [
	isFinishedOnTime := anObject
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> isPulseRequested [
	^ isPulseRequested
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> isPulseRequested: anObject [
	isPulseRequested := anObject
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> isSpaceTaskQueueWithTasks [
	^ isSpaceTaskQueueWithTasks
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> isSpaceTaskQueueWithTasks: anObject [
	isSpaceTaskQueueWithTasks := anObject
]

{ #category : #testing }
BlDevScripterStepExecutionProperty >> isStepExecution [
	^ true
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> numberOfPulses [
	^ numberOfPulses
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> numberOfPulses: anObject [
	numberOfPulses := anObject
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> playDuration [
	^ playDuration
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> playDuration: anObject [
	playDuration := anObject
]

{ #category : #printing }
BlDevScripterStepExecutionProperty >> printOn: aStream [
	super printOn: aStream.

	aStream nextPut: $(.
	self playDuration ifNotNil: [ :aDuration | 
		aDuration printHumanReadableOn: aStream ].
	self pulseDuration ifNotNil: [ :aDuration | 
		aStream nextPutAll: '+ '.
		aDuration printHumanReadableOn: aStream ].
	self numberOfPulses ifNotNil: [ :aNumber |
		aStream nextPutAll: ', '.
		aStream print: aNumber.
		aStream nextPutAll: (' pulse' asPluralBasedOn: aNumber) ].
	aStream nextPut: $)
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> pulseDuration [
	^ pulseDuration
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> pulseDuration: anObject [
	pulseDuration := anObject
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> totalDuration [
	^ (self playDuration ifNil: [ 0 seconds ])
		+ (self pulseDuration ifNil: [ 0 seconds ])
]

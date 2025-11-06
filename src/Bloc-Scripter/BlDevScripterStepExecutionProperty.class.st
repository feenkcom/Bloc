Class {
	#name : #BlDevScripterStepExecutionProperty,
	#superclass : #BlDevScripterStepProperty,
	#instVars : [
		'numberOfPulses',
		'isFinishedOnTime',
		'isPulseRequested',
		'isSpaceTaskQueueWithTasks',
		'pulseDuration',
		'playDuration',
		'usedDelays'
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
BlDevScripterStepExecutionProperty >> lastUsedDelay [
	usedDelays ifNil: [ ^ 0 seconds ].
	usedDelays ifEmpty: [ ^ 0 seconds ].
	^ usedDelays last
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
BlDevScripterStepExecutionProperty >> numberOfUsedDelays [
	^ usedDelays ifNil: [ 0 ] ifNotNil: #size
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
	"Return a pulsing duration, waiting for empty Space queue.
	It includes #sumUsedDelays.
	See {{gtMethod: BlDevScripterPulseUntilReady >> #start }} for more details."

	^ pulseDuration
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> pulseDuration: anObject [
	pulseDuration := anObject
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> pulseWithoutSleepDuration [
	^ (pulseDuration ifNil: [ 0 seconds ]) - self sumUsedDelays
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> sumUsedDelays [
	usedDelays ifNil: [ ^ 0 seconds ].
	^ usedDelays inject: 0 seconds into: [ :sum :value | sum + value ]
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> totalDuration [
	^ (self playDuration ifNil: [ 0 seconds ])
		+ (self pulseDuration ifNil: [ 0 seconds ])
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> usedDelays [
	"Return used delays. One used delay represents a `wait` (or sleep) duration.
	See {{gtMethod: BlDevScripterPulseUntilReady >> #pulse }} for more details."

	^ usedDelays
]

{ #category : #accessing }
BlDevScripterStepExecutionProperty >> usedDelays: anObject [
	usedDelays := anObject
]

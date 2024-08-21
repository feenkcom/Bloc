Class {
	#name : #BlDevScripterMemoryLoggerStep,
	#superclass : #BlDevScripterToolActionStep,
	#instVars : [
		'memoryLogger',
		'signal'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMemoryLoggerStep >> assertSignalsOfKind: aSignalClass countIs: aCount [
	^ self assert
		label: ('Assert {1} signals count is {2}'
				format: {aSignalClass.
						aCount});
		value: [ (self recordingsOfClass: aSignalClass) size ] equals: aCount
]

{ #category : #accessing }
BlDevScripterMemoryLoggerStep >> defaultLabel [
	^ 'Beacon logger'
]

{ #category : #initialization }
BlDevScripterMemoryLoggerStep >> initialize [
	super initialize.
	memoryLogger := MemoryLogger new
]

{ #category : #accessing }
BlDevScripterMemoryLoggerStep >> recordings [
	^ memoryLogger recordings
]

{ #category : #accessing }
BlDevScripterMemoryLoggerStep >> recordingsOfClass: aSignalClass [
	^ self recordings select: [ :eachSignal | eachSignal isKindOf: aSignalClass ]
]

{ #category : #actions }
BlDevScripterMemoryLoggerStep >> runFor: aSignalOrSetOfSignals during: aBlock [
	signal := aSignalOrSetOfSignals.
	memoryLogger startFor: aSignalOrSetOfSignals.
	[ aBlock value: self ] ensure: [ memoryLogger stop ]
]

Class {
	#name : #BlDevScripterMemoryLoggerStep,
	#superclass : #BlDevScripterMultipleActionStep,
	#instVars : [
		'memoryLogger',
		'signal'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

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

{ #category : #actions }
BlDevScripterMemoryLoggerStep >> runFor: aSignalOrSetOfSignals during: aBlock [
	signal := aSignalOrSetOfSignals.
	memoryLogger startFor: aSignalOrSetOfSignals.
	[ aBlock value: self ] ensure: [ memoryLogger stop ]
]

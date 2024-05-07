"
I organize {{gtClass:BeaconSignal}} recordings per steps during which signals happened.
I am used by {{gtClass:BlDevScripterMemoryLoggerStep}}. 

"
Class {
	#name : #BlDevScripterMemoryLoggerToStepOrganizer,
	#superclass : #Object,
	#instVars : [
		'steps',
		'recordings',
		'stepRecordings'
	],
	#category : #'Bloc-Scripter-Scripter-Utilities'
}

{ #category : #actions }
BlDevScripterMemoryLoggerToStepOrganizer >> organize [
	| aCurrentStep |
	aCurrentStep := BlDevScripterBetweenStepsSignals new.
	stepRecordings := OrderedDictionary new.
	recordings
		withIndexDo: [ :aSignal :anIndex | 
			(aSignal isKindOf: BlDevScripterStepAboutToPlaySignal)
				ifTrue: [ aCurrentStep := aSignal step ].

			aCurrentStep
				ifNotNil: [ stepRecordings
						at: aCurrentStep
						ifPresent: [ :aCollection | aCollection add: aSignal ]
						ifAbsentPut: [ OrderedCollection with: aSignal ] ].

			(aSignal isKindOf: BlDevScripterStepPulsationFinishedSignal)
				ifTrue: [ aCurrentStep := BlDevScripterBetweenStepsSignals new
							previousStep: aCurrentStep ].
			(aSignal isKindOf: BlDevScripterStepPulsationTimeoutedSignal)
				ifTrue: [ aCurrentStep := BlDevScripterBetweenStepsSignals new
							previousStep: aCurrentStep ] ]
]

{ #category : #accessing }
BlDevScripterMemoryLoggerToStepOrganizer >> recordings [
	^ recordings
]

{ #category : #accessing }
BlDevScripterMemoryLoggerToStepOrganizer >> recordings: anObject [
	recordings := anObject
]

{ #category : #accessing }
BlDevScripterMemoryLoggerToStepOrganizer >> steps [
	^ steps
]

{ #category : #accessing }
BlDevScripterMemoryLoggerToStepOrganizer >> steps: anObject [
	steps := anObject
]

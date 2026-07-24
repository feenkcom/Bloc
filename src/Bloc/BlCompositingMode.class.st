Class {
	#name : #BlCompositingMode,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Core-Support'
}

{ #category : #accessing }
BlCompositingMode class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
BlCompositingMode >> wantsBufferedLayer [
	^ self subclassResponsibility
]

{ #category : #testing }
BlCompositingMode >> wantsCompositionLayer [
	^ self subclassResponsibility
]

Class {
	#name : #BlRunRopedTextIteratorExamples,
	#superclass : #Object,
	#traits : 'TBlTextIteratorExamples',
	#classTraits : 'TBlTextIteratorExamples classTrait',
	#category : #'Bloc-Text-Examples-Model'
}

{ #category : #'instance creation' }
BlRunRopedTextIteratorExamples >> textForString: aString [
	^ BlRunRopedText string: aString
]

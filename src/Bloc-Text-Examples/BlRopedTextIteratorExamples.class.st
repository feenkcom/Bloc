Class {
	#name : #BlRopedTextIteratorExamples,
	#superclass : #Object,
	#traits : 'TBlTextIteratorExamples',
	#classTraits : 'TBlTextIteratorExamples classTrait',
	#category : #'Bloc-Text-Examples-Model'
}

{ #category : #'instance creation' }
BlRopedTextIteratorExamples >> textForString: aString [
	^ aString asRopedText
]

"
I represent a homogeneous styled piece of text where every character has the same set of attributes.
I am data structure independent and rely only on BrText's public API

"
Class {
	#name : #BlSpan,
	#superclass : #BlWrappedText,
	#instVars : [
		'attributes'
	],
	#category : 'Bloc-Text-Text'
}

{ #category : #'instance creation' }
BlSpan class >> text: aBrText attributes: theAttributes [
	^ self basicNew
		initialize;
		text: aBrText attributes: theAttributes;
		yourself
]

{ #category : #'span - accessing' }
BlSpan >> attributes [
	"Return a set of attributes applied on this span"
	<return: #Set of: #BlTextAttribute>

	^ attributes
]

{ #category : #'text - attributes' }
BlSpan >> attributesFinder [
	^ BlTextAttributesExplicitFinder new
		initializeForAttributes: attributes
		interval: ((1 min: self size) to: self size)
]

{ #category : #initialization }
BlSpan >> text: aBrText attributes: theAttributes [
	text := aBrText.
	attributes := theAttributes
]

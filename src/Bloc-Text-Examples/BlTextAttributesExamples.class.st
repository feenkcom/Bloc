Class {
	#name : #BlTextAttributesExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Examples-Model'
}

{ #category : #accessing }
BlTextAttributesExamples >> textWithAttributesOnARange [
	<gtExample>
	| text |
	text := String loremIpsum asRopedText.
	(text from: 15 to: 45)
		attributes: {BlFontFamilyAttribute named: 'Source Code Pro'.
				BlFontWeightAttribute bold.
				BlTextForegroundAttribute paint: Color blue}.
	self assert: (text attributesAt: 1) isEmpty.
	self assert: (text attributesAt: 15) size equals: 3.
	self assert: (text attributesAt: 45) size equals: 3.
	self assert: (text attributesAt: 46) isEmpty.
	^ text
]

{ #category : #accessing }
BlTextAttributesExamples >> textWithGlobalAttributes [
	<gtExample>
	| text |
	text := String loremIpsum asRopedText.
	text
		attributes: {BlFontFamilyAttribute named: 'Source Code Pro'.
				BlFontWeightAttribute bold.
				BlTextForegroundAttribute paint: Color blue}.
	self assert: (text attributesAt: 1) size equals: 3.
	self assert: (text attributesAt: text size) size equals: 3.
	^ text
]

{ #category : #accessing }
BlTextAttributesExamples >> textWithOverlappingFonts [
	<gtExample>
	| text |
	text := '1234567890' asRopedText.
	(text from: 2 to: 6)
		attributes: {BlFontFamilyAttribute named: 'Source Code Pro'.
				BlFontWeightAttribute bold.
				BlTextForegroundAttribute paint: Color red}.
	(text from: 4 to: 8)
		attributes: {BlFontFamilyAttribute named: 'Source Code Pro'.
				BlFontWeightAttribute bold.
				BlTextForegroundAttribute paint: Color blue}.
	self assert: (text attributesAt: 1) isEmpty.
	self assert: (text attributesAt: 4) size equals: 3.
	self assert: (text attributesAt: 6) size equals: 3.
	self assert: (text attributesAt: text size) isEmpty.
	^ text
]

Class {
	#name : #BlTextStylerExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Examples-Model'
}

{ #category : #'as yet unclassified' }
BlTextStylerExamples >> nullStyler [
	<gtExample>
	| text styler newText |
	text := 'abc' asRopedText.
	styler := BlTextNullStyler new.
	newText := styler style: text copy.
	self assert: (text equals: newText).
	^ text
]

{ #category : #'as yet unclassified' }
BlTextStylerExamples >> pluggableStyler [
	<gtExample>
	| text styler styledText attribute |
	text := 'abc' asRopedText.
	attribute := BlTextHighlightAttribute paint: Color cyan.
	styler := BlPluggableStyler new
			block: [ :textToStyle | 
				(textToStyle from: 1 to: 1) attributes: {attribute} ].
	styledText := styler style: text copy.
	self assert: (text equals: styledText) not.
	self assert: ((styledText from: 1 to: 1) hasAttribute: attribute).
	^ text
]

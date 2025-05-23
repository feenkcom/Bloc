Class {
	#name : #BlTextElementExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Examples-Elements'
}

{ #category : #example }
BlTextElementExamples >> helloText [
	<gtExample>
	<return: #BlRunRopedText>
	^ 'mama' asRopedText fontSize: 80
]

{ #category : #example }
BlTextElementExamples >> loremIpsumText [
	<gtExample>
	<return: #BlRunRopedText>
	^ (String loremIpsum: 50) asRopedText
]

{ #category : #example }
BlTextElementExamples >> simpleText [
	<gtExample>
	<return: #BlTextElement>
	| text textElement |
	text := (String loremIpsum: 50) asRopedText.
	textElement := BlTextElement new.
	textElement text: text.
	textElement background: Color paleYellow.
	textElement padding: (BlInsets all: 20).
	^ textElement
]

{ #category : #example }
BlTextElementExamples >> textAttributes [
	<gtExample>
	<return: #BlElement>
	| text lineElements textElement |
	text := ('Hello world!' , String cr , 'How are you?') asRopedText.
	text
		fontSize: 16;
		italic.	"emphasis"
	(text from: 1 to: 12)
		foreground: Color red;
		bold;
		normal.	"text color"	"weight"	"emphasis"
	(text from: 13 to: text size)
		fontSize: 20;
		monospace.	"font-family"

	lineElements := Array
			streamContents: [ :aStream | 
				| anIterator |
				anIterator := text iterator.
				[ anIterator hasNext ]
					whileTrue: [ aStream nextPut: (BlTextElement text: anIterator nextLine) ] ].

	textElement := BlElement new
			layout: BlLinearLayout vertical;
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			addChildren: lineElements;
			yourself.

	^ textElement
]

{ #category : #example }
BlTextElementExamples >> textElement [
	<gtExample>
	<return: #BlTextElement>
	| text textElement |
	text := self helloText.
	textElement := BlTextElement new.
	textElement text: text.
	textElement clipChildren: false.
	self assert: textElement text equals: text.
	^ textElement
]

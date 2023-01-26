Class {
	#name : #BlTextStreamExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Examples-Stream'
}

{ #category : #accessing }
BlTextStreamExamples >> appendAfterAttributedText [
	<gtExample>
	| stream text |
	stream := self putObjectWithHighlight.
	stream next put: $a.
	text := stream contents.
	self assert: (self hasHighlight: text at: text size) not.
	^ stream
]

{ #category : #accessing }
BlTextStreamExamples >> changeAttributesInBuilder [
	<gtExample>
	| stream text |
	stream := self emptyText.
	stream foreground: Color darkGray.
	stream next
		highlight: Color lightCyan;
		print: 1.
	stream next
		bold;
		print: 2.
	stream next print: 3.
	text := stream contents.
	self assert: (self hasHighlight: text at: 1).
	self assert: (self hasHighlight: text at: 2) not.
	self assert: (self hasHighlight: text at: 3) not.
	^ stream
]

{ #category : #accessing }
BlTextStreamExamples >> changeDefaultAttributes [
	<gtExample>
	| stream text |
	stream := self defaultAttributes.
	stream foreground: Color blue.
	stream print: 5.
	text := stream contents.
	self
		assert: ((text attributesAt: text size)
				detect: [ :each | each class = BlTextForegroundAttribute ]) paint
		equals: Color blue.
	^ stream
]

{ #category : #accessing }
BlTextStreamExamples >> defaultAttributes [
	<gtExample>
	| stream text |
	stream := self emptyText.
	stream foreground: Color red.
	stream
		nextPutAll: 'abc';
		nextPut: $d;
		cr;
		tab;
		print: 123.
	stream bold.
	stream print: 4.
	text := stream contents.
	1
		to: text size
		do: [ :i | 
			self
				assert: ((text attributesAt: i)
						anySatisfy: [ :each | each class = BlTextForegroundAttribute ]) ].
	self
		assert: ((text attributesAt: text size)
				anySatisfy: [ :each | each class = BlFontWeightAttribute ]).
	^ stream
]

{ #category : #accessing }
BlTextStreamExamples >> emptyText [
	<gtExample>
	| stream |
	stream := BlTextStream new.
	self assert: stream contents isEmpty.
	^ stream
]

{ #category : #accessing }
BlTextStreamExamples >> hasHighlight: text at: position [
	^ (text attributesAt: position)
		anySatisfy: [ :each | each class = BlTextHighlightAttribute ]
]

{ #category : #accessing }
BlTextStreamExamples >> putObjectWithHighlight [
	<gtExample>
	| stream |
	stream := self emptyText.
	stream next
		highlight: Color yellow;
		put: #(1 2 3).
	self assert: (self hasHighlight: stream contents at: 1).
	^ stream
]

{ #category : #accessing }
BlTextStreamExamples >> simpleString [
	<gtExample>
	| stream |
	stream := self emptyText.
	stream next putAll: 'abcd'.
	self assert: stream contents asString equals: 'abcd'.
	^ stream
]

"
I contain examples of more complicated pieces of text to exemplify the rope structure.

"
Class {
	#name : #BlRopedTextExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Examples-Model'
}

{ #category : #'example - insert' }
BlRopedTextExamples >> append_empty_text [
	<gtExample>
	<return: #BlRunRopedText>
	| aText wasAnnounced |
	aText := 'Hello' asRopedText.

	wasAnnounced := 0.
	aText 
		when: BlTextStringsInserted 
		do: [ wasAnnounced := wasAnnounced + 1 ]
		for: self.

	aText , '' asRopedText.

	self assert: aText asString equals: 'Hello'.
	self assert: wasAnnounced equals: 0.

	^ aText
]

{ #category : #examples }
BlRopedTextExamples >> copyEmptyTextWithAttributes [
	<gtExample>
	<return: #BlRopedTextExamples>
	| original copy att |
	att := BlTextForegroundAttribute color: Color red.
	original := '' asRopedText attribute: att.
	copy := original copy.
	self assert: ((copy attributesAt: 0) includes: att)
]

{ #category : #examples }
BlRopedTextExamples >> copyTextWithAttributesFromZero [
	<gtExample>
	<return: #BlRunRopedText>
	| original copy red blue |
	red := BlTextForegroundAttribute color: Color red.
	blue := BlTextForegroundAttribute color: Color blue.
	original := 'Hello' asRopedText.
	(original from: 1 to: 3) attribute: red.
	(original from: 4 to: 5) attribute: blue.

	copy := original copyFrom: 0 to: original size.
	self assert: ((copy attributesAt: 1) includes: red).
	self assert: ((copy attributesAt: 2) includes: red).
	self assert: ((copy attributesAt: 3) includes: red).
	self assert: ((copy attributesAt: 4) includes: blue).
	self assert: ((copy attributesAt: 5) includes: blue).

	^ copy
]

{ #category : #examples }
BlRopedTextExamples >> copyWithoutExternalReferences [
	<gtExample>
	<return: #BlRunRopedText>
	| text copy |
	text := (BlRunRopedText string: 'r')
			attributeRuns: (BlRunTree basicNew
					instVarAt: 1
						put: (BlRunTreeNode basicNew
								instVarAt: 1 put: 2;
								instVarAt: 2
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 1;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1
															put: (BrTextAdornmentDynamicAttribute new beNotOverwritableByStyler beAppend
																	stencil: [ BlElement new background: Color red ]);
														at: 2
															put: (BlFontFamilyDefaultAttribute new name: 'Source Sans Pro');
														at: 3 put: (BlFontSizeDefaultAttribute new size: 14.0);
														yourself);
											yourself);
								instVarAt: 3
									put: (BlRunTreeLeafNode basicNew
											instVarAt: 1 put: 1;
											instVarAt: 2
												put: ((Array new: 3)
														at: 1
															put: (BlFontFamilyDefaultAttribute new name: 'Source Sans Pro');
														at: 2 put: GtFixItMarkerAttribute new;
														at: 3 put: (BlFontSizeDefaultAttribute new size: 14.0);
														yourself);
											yourself);
								instVarAt: 4 put: 0.18524433168826826;
								yourself);
					yourself).

	copy := text copyWithoutExternalReferences.
	0
		to: copy size
		do: [ :i | 
			(copy attributesAt: i)
				do: [ :att | self assert: (att isKindOf: BrTextAdornmentDynamicAttribute) not ] ].
	^ copy
]

{ #category : #accessing }
BlRopedTextExamples >> insertAtRandomPoints [
	<gtExample>
	<return: #BlRopedTextExamples>
	| text string |
	string := 'abcd'.
	text := string asRopedText.
	1
		to: 1000
		do: [ :i | 
			| position inserted |
			position := string size atRandom.
			inserted := '<' , i printString , '>'.
			string := (string first: position) , inserted
					, (string allButFirst: position).
			text insertText: inserted asRopedText at: position.
			self assert: text asString equals: string ].
	text
]

{ #category : #'example - insert' }
BlRopedTextExamples >> insert_empty_strings [
	<gtExample>
	<return: #BlRunRopedText>
	| aText insertedStrings |
	aText := 'Hello' asRopedText.

	insertedStrings := #().
	aText
		when: BlTextStringsInserted
		do: [ :anAnnouncement | insertedStrings := anAnnouncement strings ]
		for: self.

	aText
		insertStrings: {''.
				'World'}
		atAll: {1.
				5}.

	self assert: aText asString equals: 'HelloWorld'.
	self assert: insertedStrings equals: {'World'}.

	^ aText
]

{ #category : #'examples - next span' }
BlRopedTextExamples >> nextSpanFontColorOnHelloWorldWithColor [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIterator aSpan |
	aText := 'Hello World' asRopedText.
	(aText from: 1 to: 5) foreground: Color red.
	(aText from: 7 to: 11) foreground: Color blue.

	anIterator := aText iterator.

	aSpan := anIterator
			nextSpan: [ :eachAttribute | eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan start equals: 1.
	self assert: aSpan end equals: 5.
	self assert: anIterator hasNext.
	self assert: aSpan asString equals: 'Hello'.

	aSpan := anIterator
			nextSpan: [ :eachAttribute | eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan start equals: 6.
	self assert: aSpan end equals: 6.
	self assert: anIterator hasNext.
	self assert: aSpan asString equals: ' '.

	aSpan := anIterator
			nextSpan: [ :eachAttribute | eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan start equals: 7.
	self assert: aSpan end equals: 11.
	self assert: anIterator hasNext not.
	self assert: aSpan asString equals: 'World'.

	^ aText
]

{ #category : #'example - insert' }
BlRopedTextExamples >> replace_text [
	<gtExample>
	<return: #BlRopedTextExamples>
	| aText |
	aText := 'Hello' asRopedText.
	aText
		replace: 3
		to: 4
		withString: 'a'.
	self assert: aText asString equals: 'Heao'
]

{ #category : #'example - insert' }
BlRopedTextExamples >> replace_text_at_beginning [
	<gtExample>
	<return: #BlRopedTextExamples>
	| aText |
	aText := 'Hello' asRopedText.
	aText
		replace: 1
		to: 2
		withString: 'a'.
	self assert: aText asString equals: 'allo'
]

{ #category : #'example - insert' }
BlRopedTextExamples >> replace_text_at_end [
	<gtExample>
	<return: #BlRopedTextExamples>
	| aText |
	aText := 'Hello' asRopedText.
	aText
		replace: 4
		to: 5
		withString: 'a'.
	self assert: aText asString equals: 'Hela'
]

{ #category : #examples }
BlRopedTextExamples >> textEqualsWithAttributes [
	<gtExample>
	<return: #Array>
	| left right |
	left := 'ab' asRopedText.
	right := 'ab' asRopedText.
	self assert: (left equals: right).
	left
		attributes: {BlTextForegroundAttribute color: Color red}
		from: 1
		to: 1.
	self assert: (left equals: right) not.
	right
		attributes: {BlTextForegroundAttribute color: Color red}
		from: 1
		to: 1.
	self assert: (left equals: right).
	left
		attributes: {BlTextForegroundAttribute color: Color blue}
		from: 2
		to: 2.
	self assert: (left equals: right) not.
	right
		attributes: {BlTextForegroundAttribute color: Color yellow}
		from: 2
		to: 2.
	self assert: (left equals: right) not.
	^ {left.
		right}
]

{ #category : #examples }
BlRopedTextExamples >> textWithAttributes [
	<gtExample>
	<return: #BlRunRopedText>
	| text |
	text := 'The moldable editor' asRopedText.
	text insertString: String cr at: text size.
	text insertString: 'can be adapted ' at: text size.
	text insertString: 'to the context.' at: text size.
	(text from: 5 to: 12)
		fontSize: 20;
		monospace;
		foreground: Color blue.

	(text from: 43 to: 49) monospace.

	^ text
]

{ #category : #examples }
BlRopedTextExamples >> textWithCr [
	<gtExample>
	<return: #BlRunRopedText>
	| text |
	text := ('Hello' , String crlf , String tab , 'World') asRopedText.

	^ text
]

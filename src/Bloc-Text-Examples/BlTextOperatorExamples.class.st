Class {
	#name : #BlTextOperatorExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Examples-Model'
}

{ #category : #'finder - characters' }
BlTextOperatorExamples >> findAllCharacters [
	<gtExample>
	<return: #BlRunRopedText>
	| aText allIndexes |
	aText := 'Looking for "STRING" substring' asRopedText.
	allIndexes := aText finder
			character: $s;
			character: $S;
			searchAll.
	self assert: allIndexes equals: #(14 22 25).
	self assert: (aText at: 14) equals: $S.
	self assert: (aText at: 22) equals: $s.
	self assert: (aText at: 25) equals: $s.
	allIndexes
		do: [ :eachIndex | (aText from: eachIndex to: eachIndex) foreground: Color red ].
	^ aText
]

{ #category : #accessing }
BlTextOperatorExamples >> findAllCharacters_EmptyResult [
	<gtExample>
	<return: #BlRunRopedText>
	| aText allIndexes |
	aText := 'Looking for "STRING" substring' asRopedText.
	allIndexes := aText finder
			character: $y;
			character: $Y;
			searchAll.
	self assert: allIndexes equals: #().
	^ aText
]

{ #category : #'finder - case insensitive substring' }
BlTextOperatorExamples >> findCaseInsensitiveSubStringInTheMiddle [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for "STRING" substring' asRopedText.
	anIndex := aText finder
			caseInsensitiveSubstring: '"string"';
			search.
	self assert: anIndex equals: 13.
	self assert: (aText at: 13) equals: $".
	(aText from: anIndex to: anIndex + 7) foreground: Color red.
	^ aText
]

{ #category : #'finder - character' }
BlTextOperatorExamples >> findGCharacterInAMiddle [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for G character' asRopedText.
	anIndex := aText finder
			character: $G;
			search.
	self assert: anIndex equals: 13.
	self assert: (aText at: 13) equals: $G.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #'finder - character' }
BlTextOperatorExamples >> findGCharacterInAMiddleReversed [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for G character' asRopedText.
	anIndex := aText finder
			startAtEnd;
			reversed;
			character: $G;
			search.
	self assert: anIndex equals: 13.
	self assert: (aText at: 13) equals: $G.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findIngSubStringInTheMiddle [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for "ing" substring' asRopedText.
	anIndex := aText finder
			substring: 'ing';
			search.
	self assert: anIndex equals: 5.
	self assert: (aText at: 5) equals: $i.
	(aText from: anIndex to: anIndex + 3) foreground: Color red.
	^ aText
]

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findIngSubStringInTheMiddleReversed [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for "ing" substring' asRopedText.
	anIndex := aText finder
			reversed;
			startAtEnd;
			substring: '"ing"';
			search.
	self assert: anIndex equals: 13.
	self assert: (aText at: 13) equals: $".
	(aText from: anIndex to: anIndex + 4) foreground: Color red.
	^ aText
]

{ #category : #'finder - character' }
BlTextOperatorExamples >> findLCharacterAtTheBeginning [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for L character' asRopedText.
	anIndex := aText finder
			character: $L;
			search.
	self assert: anIndex equals: 1.
	self assert: (aText at: 1) equals: $L.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #'finder - character' }
BlTextOperatorExamples >> findLCharacterAtTheBeginningReversed [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for l character' asRopedText.
	anIndex := aText finder
			startAtEnd;
			reversed;
			character: $L;
			search.
	self assert: anIndex equals: 1.
	self assert: (aText at: 1) equals: $L.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findLookSubStringInTheBeginning [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for "ling" substring' asRopedText.
	anIndex := aText finder
			substring: 'Look';
			search.
	self assert: anIndex equals: 1.
	self assert: (aText at: 1) equals: $L.
	(aText from: anIndex to: anIndex + 3) foreground: Color red.
	^ aText
]

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findLookSubStringInTheBeginningReversed [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for "ling" substring' asRopedText.
	anIndex := aText finder
			startAtEnd;
			reversed;
			substring: 'Look';
			search.
	self assert: anIndex equals: 1.
	self assert: (aText at: 1) equals: $L.
	(aText from: anIndex to: anIndex + 3) foreground: Color red.
	^ aText
]

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findNoSubString [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for not existing substring' asRopedText.
	anIndex := aText finder
			substring: 'something';
			search.
	self assert: anIndex equals: 0.
	^ aText
]

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findNoSubStringReversed [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for not existing substring' asRopedText.
	anIndex := aText finder
			reversed;
			startAtEnd;
			substring: 'something';
			search.
	self assert: anIndex equals: 0.
	^ aText
]

{ #category : #'finder - character' }
BlTextOperatorExamples >> findNothing [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for not included character' asRopedText.
	anIndex := aText finder
			character: $Z;
			search.
	self assert: anIndex equals: 0.
	^ aText
]

{ #category : #'finder - character' }
BlTextOperatorExamples >> findRCharacterAtTheEnd [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for r characteR' asRopedText.
	anIndex := aText finder
			character: $R;
			search.
	self assert: anIndex equals: 23.
	self assert: (aText at: 23) equals: $R.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #'finder - character' }
BlTextOperatorExamples >> findRCharacterAtTheEndReversed [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for r characteR' asRopedText.
	anIndex := aText finder
			startAtEnd;
			reversed;
			character: $R;
			search.
	self assert: anIndex equals: 23.
	self assert: (aText at: 23) equals: $R.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findRingSubStringInTheEnd [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for "Ring" substring' asRopedText.
	anIndex := aText finder
			substring: 'ring';
			search.
	self assert: anIndex equals: 25.
	self assert: (aText at: 25) equals: $r.
	(aText from: anIndex to: anIndex + 3) foreground: Color red.
	^ aText
]

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findRingSubStringInTheEndReversed [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for "Ring" substring' asRopedText.
	anIndex := aText finder
			startAtEnd;
			reversed;
			substring: 'ring';
			search.
	self assert: anIndex equals: 25.
	self assert: (aText at: 25) equals: $r.
	(aText from: anIndex to: anIndex + 3) foreground: Color red.
	^ aText
]

{ #category : #'finder - characters' }
BlTextOperatorExamples >> findxXCharactersAtTheBeginning [
	<gtExample>
	<return: #BlRunRopedText>
	| aText anIndex |
	aText := 'Looking for X character' asRopedText.
	anIndex := aText finder
			characters: 'xX';
			search.
	self assert: anIndex equals: 13.
	self assert: (aText at: 13) equals: $X.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #'trimmer - line breaks' }
BlTextOperatorExamples >> lineBreaks [
	<gtExample>
	<return: #ByteString>
	| aString |
	aString := String cr.
	self assert: (aString allSatisfy: #isLineBreak).
	self assert: aString size equals: 1.
	^ aString
]

{ #category : #trimmer }
BlTextOperatorExamples >> separators [
	<gtExample>
	<return: #ByteString>
	| aString |
	aString := String space , String tab , String cr.
	self assert: (aString allSatisfy: #isSeparator).
	self assert: aString size equals: 3.
	^ aString
]

{ #category : #'trimmer - line breaks' }
BlTextOperatorExamples >> stringWithLineBreaksInTheMiddle [
	<gtExample>
	<return: #ByteString>
	^ 'the first text' , self lineBreaks , 'the second text'
]

{ #category : #'trimmer - line breaks' }
BlTextOperatorExamples >> stringWithLineBreaksOnBothSidesAndInTheMiddle [
	<gtExample>
	<return: #ByteString>
	^ self lineBreaks , self stringWithLineBreaksInTheMiddle , self lineBreaks
]

{ #category : #trimmer }
BlTextOperatorExamples >> stringWithSeparatorsInTheMiddle [
	<gtExample>
	<return: #ByteString>
	^ 'the first text' , self separators , 'the second text'
]

{ #category : #trimmer }
BlTextOperatorExamples >> stringWithSeparatorsOnBothSidesAndInTheMiddle [
	<gtExample>
	<return: #ByteString>
	^ self separators , self stringWithSeparatorsInTheMiddle , self separators
]

{ #category : #'trimmer - line breaks' }
BlTextOperatorExamples >> trimBothTextWithLineBreakssOnBothSidesAndInTheMiddle [
	<gtExample>
	<return: #BlRunRopedText>
	| aText |
	aText := self stringWithLineBreaksOnBothSidesAndInTheMiddle asRopedText.
	aText trimmer
		bothLineBreaks;
		trim.
	self
		assert: aText size
		equals: self stringWithLineBreaksOnBothSidesAndInTheMiddle size
				- (self lineBreaks size * 2).
	^ aText
]

{ #category : #trimmer }
BlTextOperatorExamples >> trimBothTextWithSeparatorsOnBothSidesAndInTheMiddle [
	<gtExample>
	<return: #BlRunRopedText>
	| aText |
	aText := self stringWithSeparatorsOnBothSidesAndInTheMiddle asRopedText.
	aText trimmer
		bothSeparators;
		trim.
	self
		assert: aText size
		equals: self stringWithSeparatorsOnBothSidesAndInTheMiddle size
				- (self separators size * 2).
	^ aText
]

{ #category : #trimmer }
BlTextOperatorExamples >> trimEmptyText [
	<gtExample>
	<return: #BlRunRopedText>
	| aText |
	aText := '' asRopedText.
	aText trimmer
		bothSeparators;
		trim.
	self assert: aText size equals: 0.
	^ aText
]

{ #category : #trimmer }
BlTextOperatorExamples >> trimLeftTextWithSeparatorsOnBothSidesAndInTheMiddle [
	<gtExample>
	<return: #BlRunRopedText>
	| aText |
	aText := self stringWithSeparatorsOnBothSidesAndInTheMiddle asRopedText.
	aText trimmer
		leftSeparators;
		trim.
	self
		assert: aText size
		equals: self stringWithSeparatorsOnBothSidesAndInTheMiddle size - self separators size.
	^ aText
]

{ #category : #trimmer }
BlTextOperatorExamples >> trimOnlySeparatorsText [
	<gtExample>
	<return: #BlRunRopedText>
	| aText |
	aText := self separators asRopedText.
	aText trimmer
		bothSeparators;
		trim.
	self assert: aText size equals: 0.
	^ aText
]

{ #category : #trimmer }
BlTextOperatorExamples >> trimRightTextWithSeparatorsOnBothSidesAndInTheMiddle [
	<gtExample>
	<return: #BlRunRopedText>
	| aText |
	aText := self stringWithSeparatorsOnBothSidesAndInTheMiddle asRopedText.
	aText trimmer
		rightSeparators;
		trim.
	self
		assert: aText size
		equals: self stringWithSeparatorsOnBothSidesAndInTheMiddle size - self separators size.
	^ aText
]

"
I am a specific RopedText iterator
"
Class {
	#name : #BlAttributedRopedTextIterator,
	#superclass : #BlTextIterator,
	#instVars : [
		'rope',
		'iterator',
		'text'
	],
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #'instance creation' }
BlAttributedRopedTextIterator class >> text: aRopedText [
	
	^ self new
		text: aRopedText from: (1 min: aRopedText size) to: aRopedText size;
		yourself
]

{ #category : #'instance creation' }
BlAttributedRopedTextIterator class >> text: aRopedText from: aStartIndex to: anEndIndex [
	
	^ self new
		text: aRopedText from: aStartIndex to: anEndIndex;
		yourself
]

{ #category : #'iterator - accessing' }
BlAttributedRopedTextIterator >> attributes [
	"Return a collection of rope attributes at a current position without duplicates"
	<return: #Collection of: #BlTextAttribute>

	^ iterator attributes
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."
	<return: #BlTextAttribute or: #Object>

	^ iterator detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock
]

{ #category : #'iterator - testing' }
BlAttributedRopedTextIterator >> hasNext [
	"Return true if there is a next text item (character) after a current position"
	<return: #Boolean>
	
	^ iterator hasNext
]

{ #category : #'iterator - testing' }
BlAttributedRopedTextIterator >> hasPrevious [
	"Return true if there is a previous text item (character) before the current position"
	<return: #Boolean>

	^ iterator hasPrevious
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> next [
	"Return an item (character) at current position and move one to the right"
	<return: #Character or: #Object>

	^ iterator next
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> nextLine [
	"Return an instance of BrText which represents a piece of text from current position
	until the first carriage return character"
	<return: #BlText>
	
	^ self nextLineIndicesDo: [ :aStart :anEnd | BlSubText text: text from: aStart to: anEnd ]
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> nextLineIndicesDo: anIndicesBlock [
	" execute anIndicesBlock with 3 arguments for each line:
		- start index of line in text coordinates
		- end index of line without line delimiter in text coordinates
		- end index of line including line delimiter(s) in text coordinates"

	^ iterator nextLineIndicesDo: [ :aStart :anEnd :aLineEndWithDelimiters |
		anIndicesBlock cull: aStart + 1 cull: anEnd cull: aLineEndWithDelimiters ]
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> nextSegment: aBlock [
	<return: #BlText>

	^ iterator
		nextSegment: aBlock
		indicesDo: [ :aStart :anEnd | BlSubText text: text from: ((aStart + 1) min: anEnd) to: anEnd ]
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> nextSegment: aBlock indicesDo: anIndicesBlock [
	"@see BlTextIterator>>#nextSegment:indicesDo:"
	<return: #Object>
	
	^ iterator nextSegment: aBlock indicesDo: anIndicesBlock
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> nextSpan [
	"Return a next homogeneous text span"
	<return: #BlSpan>
	| theAttributes |
	
	theAttributes := iterator attributes.
	
	^ BlSpan
		text: (BlRopedText rope: iterator nextSpan)
		attributes: theAttributes
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> nextWhitespace [
	"Return an instance of BrText which represents a piece of text from current position
	until the first non-whitespace character without including it"
	<return: #BlText>
	| aStartPosition aSegment |
	
	aStartPosition := iterator position + 1.
	aSegment :=  iterator nextWhitespace.

	^ BlSubText text: text from: aStartPosition to: aStartPosition + aSegment size - 1
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> nextWord [
	"Return an instance of BlText which represents a piece of text from current position
	until the first space character not including spaces"
	<return: #BlText>
	| aStartPosition aSegment |
	
	aStartPosition := iterator position.
	aSegment :=  iterator nextWord.

	^ BlSubText text: text from: (aStartPosition max: 1) to: aStartPosition + aSegment size - 1
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> peek [
	"Return an item (character) at current position"
	<return: #Character or: #Object>

	^ iterator peek
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> peer [
	"Return an item (character) before current position"
	<return: #Character or: #Object>

	^ iterator peer
]

{ #category : #'iterator - accessing' }
BlAttributedRopedTextIterator >> position [
	"Return current iterator position within a text"
	<return: #Number>
	
	^ iterator position
]

{ #category : #'iterator - accessing' }
BlAttributedRopedTextIterator >> position: anInteger [

	iterator position: anInteger
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> prevWord [
	"Return an instance of BlText which represents a piece of text from current position
	back until the previous word"
	<return: #BlText>
	| endPosition aSegment |
	
	endPosition := iterator position.
	aSegment :=  iterator prevWord.
	^ BlSubText text: text from: endPosition - aSegment size+1 to: endPosition
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> previous [
	"Return an item (character) at current position and move one to the left"
	<return: #Character or: #Object>

	^ iterator previous
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> previousSegment: aBlock indicesDo: anIndicesBlock [
	"@see BlTextIterator>>#previousSegment:indicesDo:"
	<return: #Object>
	
	^ iterator previousSegment: aBlock indicesDo: anIndicesBlock
]

{ #category : #accessing }
BlAttributedRopedTextIterator >> rope [
	<return: #BlRope>

	^ rope
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> selectAttributes: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #SequenceableCollection of: #BlTextAttribute>

	^ iterator selectAttributes: aBlock
]

{ #category : #'iterator - enumeration' }
BlAttributedRopedTextIterator >> skip: aNumber [
	"Move forward by aNumber characters"

 	iterator skip: aNumber
]

{ #category : #accessing }
BlAttributedRopedTextIterator >> text [
	<return: #BlRopedText>

	^ text
]

{ #category : #accessing }
BlAttributedRopedTextIterator >> text: aBrRopedText from: aStartIndex to: anEndIndex [
	rope := aBrRopedText rope.
	text := aBrRopedText.

	iterator := rope iterator: ((aStartIndex - 1) max: 0) to: anEndIndex
]

Class {
	#name : #BlAbstractRopedTextIterator,
	#superclass : #BlTextIterator,
	#instVars : [
		'rope',
		'iterator',
		'text'
	],
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #'iterator - testing' }
BlAbstractRopedTextIterator >> hasNext [
	"Return true if there is a next text item (character) after a current position"
	<return: #Boolean>
	
	^ iterator hasNext
]

{ #category : #'iterator - testing' }
BlAbstractRopedTextIterator >> hasPrevious [
	"Return true if there is a previous text item (character) before the current position"
	<return: #Boolean>

	^ iterator hasPrevious
]

{ #category : #'iterator - enumeration' }
BlAbstractRopedTextIterator >> next [
	"Return an item (character) at current position and move one to the right"
	<return: #Character or: #Object>

	^ iterator next
]

{ #category : #'iterator - enumeration' }
BlAbstractRopedTextIterator >> nextLine [
	"Return an instance of BrText which represents a piece of text from current position
	until the first carriage return character"
	<return: #BlText>
	
	^ self nextLineIndicesDo: [ :aStart :anEnd | BlSubText text: text from: aStart to: anEnd ]
]

{ #category : #'iterator - enumeration' }
BlAbstractRopedTextIterator >> nextLineIndicesDo: anIndicesBlock [
	" execute anIndicesBlock with 3 arguments for each line:
		- start index of line in text coordinates
		- end index of line without line delimiter in text coordinates
		- end index of line including line delimiter(s) in text coordinates"

	^ iterator nextLineIndicesDo: [ :aStart :anEnd :aLineEndWithDelimiters |
		anIndicesBlock cull: aStart + 1 cull: anEnd cull: aLineEndWithDelimiters ]
]

{ #category : #'iterator - enumeration' }
BlAbstractRopedTextIterator >> nextSegment: aBlock [
	<return: #BlText>

	^ iterator
		nextSegment: aBlock
		indicesDo: [ :aStart :anEnd | BlSubText text: text from: ((aStart + 1) min: anEnd) to: anEnd ]
]

{ #category : #'iterator - enumeration' }
BlAbstractRopedTextIterator >> nextSegment: aBlock indicesDo: anIndicesBlock [
	"@see BlTextIterator>>#nextSegment:indicesDo:"
	<return: #Object>
	
	^ iterator nextSegment: aBlock indicesDo: anIndicesBlock
]

{ #category : #'iterator - enumeration' }
BlAbstractRopedTextIterator >> nextWhitespace [
	"Return an instance of BrText which represents a piece of text from current position
	until the first non-whitespace character without including it"
	<return: #BlText>
	| aStartPosition aSegment |
	
	aStartPosition := iterator position + 1.
	aSegment :=  iterator nextWhitespace.

	^ BlSubText text: text from: aStartPosition to: aStartPosition + aSegment size - 1
]

{ #category : #'iterator - enumeration' }
BlAbstractRopedTextIterator >> nextWord [
	"Return an instance of BlText which represents a piece of text from current position
	until the first space character not including spaces"
	<return: #BlText>
	| aStartPosition aSegment |
	
	aStartPosition := iterator position.
	aSegment :=  iterator nextWord.

	^ BlSubText text: text from: (aStartPosition max: 1) to: aStartPosition + aSegment size - 1
]

{ #category : #'iterator - enumeration' }
BlAbstractRopedTextIterator >> peek [
	"Return an item (character) at current position"
	<return: #Character or: #Object>

	^ iterator peek
]

{ #category : #'iterator - enumeration' }
BlAbstractRopedTextIterator >> peer [
	"Return an item (character) before current position"
	<return: #Character or: #Object>

	^ iterator peer
]

{ #category : #'iterator - accessing' }
BlAbstractRopedTextIterator >> position [
	"Return current iterator position within a text"
	<return: #Number>
	
	^ iterator position
]

{ #category : #'iterator - accessing' }
BlAbstractRopedTextIterator >> position: anInteger [

	iterator position: anInteger
]

{ #category : #'iterator - enumeration' }
BlAbstractRopedTextIterator >> prevWord [
	"Return an instance of BlText which represents a piece of text from current position
	back until the previous word"
	<return: #BlText>
	| endPosition aSegment |
	
	endPosition := iterator position.
	aSegment :=  iterator prevWord.
	^ BlSubText text: text from: endPosition - aSegment size+1 to: endPosition
]

{ #category : #'iterator - enumeration' }
BlAbstractRopedTextIterator >> previous [
	"Return an item (character) at current position and move one to the left"
	<return: #Character or: #Object>

	^ iterator previous
]

{ #category : #'iterator - enumeration' }
BlAbstractRopedTextIterator >> previousSegment: aBlock indicesDo: anIndicesBlock [
	"@see BlTextIterator>>#previousSegment:indicesDo:"
	<return: #Object>
	
	^ iterator previousSegment: aBlock indicesDo: anIndicesBlock
]

{ #category : #accessing }
BlAbstractRopedTextIterator >> rope [
	<return: #BlRope>

	^ rope
]

{ #category : #'iterator - enumeration' }
BlAbstractRopedTextIterator >> skip: aNumber [
	"Move forward by aNumber characters"

 	iterator skip: aNumber
]

{ #category : #accessing }
BlAbstractRopedTextIterator >> text [
	<return: #BlRunRopedText>

	^ text
]

{ #category : #accessing }
BlAbstractRopedTextIterator >> text: aBrRopedText from: aStartIndex to: anEndIndex [
	rope := aBrRopedText rope.
	text := aBrRopedText.

	iterator := rope iterator: ((aStartIndex - 1) max: 0) to: anEndIndex
]

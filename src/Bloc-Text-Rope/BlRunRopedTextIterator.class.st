"
I am a specific RopedText iterator

"
Class {
	#name : #BlRunRopedTextIterator,
	#superclass : #BlAbstractRopedTextIterator,
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #'instance creation' }
BlRunRopedTextIterator class >> text: aRopedText [
	
	^ self new
		text: aRopedText from: (1 min: aRopedText size) to: aRopedText size;
		yourself
]

{ #category : #'instance creation' }
BlRunRopedTextIterator class >> text: aRopedText from: aStartIndex to: anEndIndex [
	
	^ self new
		text: aRopedText from: aStartIndex to: anEndIndex;
		yourself
]

{ #category : #'iterator - accessing' }
BlRunRopedTextIterator >> attributes [
	"Return a collection of rope attributes at a current position without duplicates"

	<return: #Collection of: #BlTextAttribute>
	
	^ (text attributeRuns isEmpty or: [ self position + 1 > text attributeRuns size ])
		ifTrue: [ {} ]
		ifFalse: [ text attributeRuns at: self position + 1 ]
]

{ #category : #'iterator - enumeration' }
BlRunRopedTextIterator >> detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."
	<return: #BlTextAttribute or: #Object>

	^ self attributes
		detect: aBlock
		ifFound: aFoundBlock
		ifNone: anExceptionBlock
]

{ #category : #'iterator - enumeration' }
BlRunRopedTextIterator >> nextSpan [

	"Return a next homogeneous text span"

	<return: #BlSpan>
	| theAttributes spanrope start end runend |
	theAttributes := Set new.
	start := iterator position + 1.
	spanrope := iterator nextSpan.
	end := iterator position.
	text attributeRuns notEmpty ifTrue: [ 
		theAttributes := text attributeRuns at: start.
		runend := text attributeRuns runEndAt: start.
		end := spanrope size min: runend - start + 1.
		spanrope := spanrope from: 0 to: end.
		iterator position: start + end - 1 ].
	^ BlSpan
		  text: (BlRunRopedText rope: spanrope)
		  attributes: theAttributes
]

{ #category : #'iterator - enumeration' }
BlRunRopedTextIterator >> selectAttributes: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #SequenceableCollection of: #BlTextAttribute>

	^  self attributes select: aBlock
]

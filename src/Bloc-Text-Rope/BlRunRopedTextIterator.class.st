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
	^ text attributeRuns isEmpty
		  ifTrue: [ {  } ]
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
	| theAttributes spanrope start end runlength |
	theAttributes := Set new.
	start := iterator position+1.
	spanrope := iterator nextSpan. 
	end := iterator position.
	text attributeRuns notEmpty ifTrue: [ 
		theAttributes := text attributeRuns at: start.
		runlength := text attributeRuns runLengthAt: start.
		runlength < spanrope size ifTrue: [ 
			spanrope := rope from: start-1 to: start + runlength-1.
			iterator position: start + runlength - 1  ] ].
	^ BlSpan text: (BlRunRopedText rope: spanrope) attributes: theAttributes
]

{ #category : #'iterator - enumeration' }
BlRunRopedTextIterator >> selectAttributes: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #SequenceableCollection of: #BlTextAttribute>

	^  self attributes select: aBlock
]

"
I represent a part of original text from `=start`= to `=end`=.
All subtexts of a BrText share the same text instance.
I modify the underlying text when I am modified.

Essentially, I offer a scope that can be used  by upper layers, such as editors, to make it easier to manipulate a logical piece of text, such as a line, or a paragraph.

"
Class {
	#name : #BlSubText,
	#superclass : #BlText,
	#instVars : [
		'text',
		'start',
		'end'
	],
	#category : #'Bloc-Text-Text'
}

{ #category : #'instance creation' }
BlSubText class >> empty: aBrText [
	"Returns a sub-text that is backed up by an empty text"
	<return: #BlSubText>
	
	self
		assert: [ aBrText isEmpty ]
		description: [ 'Underlying text must be empty in order to create empty sub-text' ].
		
	^ self
		text: aBrText
		from: 1
		to: 0
]

{ #category : #'instance creation' }
BlSubText class >> text: aBrText [
	self
		assert: [ (aBrText isKindOf: self) not ]
		description: [ 'Can not create sub text of a subtext' ].

	^ self new
		text: aBrText from: 1 to: aBrText size;
		yourself
]

{ #category : #'instance creation' }
BlSubText class >> text: aBrText from: aStartIndex to: anEndIndex [
	self
		assert: [ (aBrText isKindOf: self) not ]
		description: [ 'Can not create sub text of a subtext' ].

	^ self new
		text: aBrText from: aStartIndex to: anEndIndex;
		yourself
]

{ #category : #comparing }
BlSubText >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject class == self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject start = self start
		and: [ anotherObject end = self end
			and: [ anotherObject text = self text ] ]
]

{ #category : #asserting }
BlSubText >> assertInvariant [
	self assertStart: start end: end
]

{ #category : #asserting }
BlSubText >> assertStart: aStartIndex end: anEndIndex [
	self
		assert: [ aStartIndex isTextIndex and: [ anEndIndex isTextIndex ] ]
		description: [ 'Only integers are alowed as start and end indices' ].
	self
		assert: [ text isNotNil ]
		description: [ 'Text must not be nil' ].
		
	aStartIndex isZero
		ifTrue: [ BlTextOutOfBoundsError signal: ('Start index ({1}) must not be zero' format: { aStartIndex }) ].

	self
		assert: [ aStartIndex between: 1 and: (text size + 1) ]
		description: [ 'Sub-text start ({1}) index is out of bounds ({2})!' format: { aStartIndex . (1 to: text size + 1) } ].
	self
		assert: [ anEndIndex between: 0 and: text size ]
		description: [ 'Sub-text end ({1}) index is out of bounds ({2})!' format: { anEndIndex . (0 to: text size) } ].
	self
		assert: [ text isNotEmpty or: [ aStartIndex = 1 and: [ anEndIndex isZero ] ] ]
		description: [ 'If text is empty, start must be 1 and end index must be Zero!' ].

	self
		assert: [ anEndIndex isZero not or: [ aStartIndex = 1 ] ]
		description: [ 'If end index is zero then start index must be 1' ]
]

{ #category : #'text - accessing' }
BlSubText >> at: anIndex [
	"Return a character at a given index"
	<return: #Character>
	
	^ self text at: anIndex + start - 1
]

{ #category : #'text - attributes' }
BlSubText >> attributeRunsDo: aBlock [
	text
		attributeRunsDo: [ :aStart :aStop :atts | 
			aBlock
				cull: aStart - start+1
				cull: aStop - start+1
				cull: atts ]
		from: start
		to: end
]

{ #category : #'text - attributes' }
BlSubText >> attributes: anAttributesCollection [
	"Apply given attributes on the whole text"

	self text attributes: anAttributesCollection from: start to: end
]

{ #category : #'text - attributes' }
BlSubText >> attributes: anAttributesCollection from: aFromIndex to: aToIndex [ 

	self
		assert: [ aFromIndex <= (aToIndex + 1) ]
		description: [ 'Start must not exceed end' ].

	self
		assert: [ self isNotEmpty or: [ aFromIndex = 1 and: [ aToIndex isZero ] ] ]
		description: [ 'If I am empty then start must be 1 and end must be zero' ].

	self text
		attributes: anAttributesCollection
		from: start + aFromIndex - 1
		to: start + aToIndex - 1
]

{ #category : #'text - accessing' }
BlSubText >> attributesAt: anIndex [
	"Return a collection of text attributes without duplicates at a given text index"

	<return: #Collection of: #BlTextAttribute>
	
	^ self text attributesAt: anIndex + start - 1
]

{ #category : #'text - attributes' }
BlSubText >> attributesFinder [
	^ BlTextAttributesDynamicFinder new initializeForText: self
]

{ #category : #'text - attributes' }
BlSubText >> clearAttributes: aBlock [
	text
		clearAttributes: start
		to: end
		if: aBlock
]

{ #category : #'text - attributes' }
BlSubText >> clearAttributes: aFromIndex to: aToIndex if: aBlock [
	text
		clearAttributes: start + aFromIndex - 1
		to: start + aToIndex - 1
		if: aBlock
]

{ #category : #'text - copying' }
BlSubText >> copyFrom: aStartIndex to: anEndIndex [
	"Create a copy of this text within a given indices interval.
	Note: I am different from ==#from:to:== in a sense that I don't create a sub-text that points
	to the original text, I create an independent copy which can be safely used in text editors and other tools.
	
	README: For compatibility reasons with the rest of the system we allow aStartIndex to be bigger than anEndIndex and also bigger than self size."
	<return: #BlText>

	^ self text
		copyFrom: (start + aStartIndex - 1)
		to: (start + anEndIndex - 1)
]

{ #category : #'text - modifications' }
BlSubText >> deleteAll: aCollectionOfIntervals [

	aCollectionOfIntervals
		ifEmpty: [ ^ self ].

	text deleteAll: (aCollectionOfIntervals collect: [ :eachInterval |
		(eachInterval first + start - 1) to: (eachInterval last + start - 1) ]).

	end := end - (aCollectionOfIntervals sum: #size)
]

{ #category : #'text - enumeration' }
BlSubText >> do: aBlockClosure [ 
	| anIterator |
	anIterator := self iterator.
	[ anIterator hasNext ] whileTrue: [ aBlockClosure value: anIterator next ]
]

{ #category : #'text - accessing' }
BlSubText >> empty [
	"Return a similar (the same backend data structure) but empty text"
	<return: #BlText>
	
	^ self text empty
]

{ #category : #accessing }
BlSubText >> end [
	<return: #Number>

	^ end
]

{ #category : #'text - accessing' }
BlSubText >> from: aStart to: anEnd [
	self assertInvariant.
	
	self
		assert: [ self isNotEmpty or: [ aStart = 1 and: [ anEnd isZero ] ] ]
		description: [ 'If I am empty then start must be 1 and end must be zero' ].
	
	^ self text
		from: ((aStart + start - 1) max: 0)
		to: ((anEnd + start - 1) max: 0)
]

{ #category : #'text - enumeration' }
BlSubText >> from: aFromIndex to: aToIndex do: aBlockClosure [
	| anIterator |
	anIterator := self iterator: aFromIndex to: aToIndex.
	[ anIterator hasNext ] whileTrue: [ aBlockClosure value: anIterator next ]
]

{ #category : #'text - copying' }
BlSubText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>
	
	^ self text generation
]

{ #category : #accessing }
BlSubText >> gtAttributeTreeFor: aView [
	<gtView>
	| attributes |
	attributes := Dictionary new.
	self
		attributeRunsDo: [ :from :to :attrs | 
			attrs
				do: [ :each | 
					| locations |
					locations := attributes at: each ifAbsentPut: [ OrderedCollection new ].
					(locations notEmpty and: [ locations last last + 1 = from ])
						ifTrue: [ locations at: locations size put: (locations last first to: to) ]
						ifFalse: [ locations add: (from to: to) ] ] ].
	^ aView columnedTree
		title: 'All attributes';
		priority: 20;
		items: [ attributes keys
				asSortedCollection: [ :a :b | (attributes at: a) first first < (attributes at: b) first first ] ];
		children: [ :each | attributes at: each ifAbsent: [ #() ] ];
		column: 'Text'
			text: [ :each | 
				each isInterval
					ifTrue: [ self copyFrom: each first to: each last ]
					ifFalse: [ each printString ] ];
		column: 'Interval'
			text: [ :each | 
				each isInterval
					ifTrue: [ each first printString , '-' , each last printString ]
					ifFalse: [ '' ] ]
			width: 80;
		send: [ :each | 
			each isInterval
				ifTrue: [ self from: (each first max: 1) to: each last ]
				ifFalse: [ each ] ]
]

{ #category : #comparing }
BlSubText >> hash [
	^ ((self class hash bitXor: self start hash) bitXor: self end hash) bitXor: self text hash
]

{ #category : #'text - modifications' }
BlSubText >> insertStrings: aCollectionOfStrings atAll: aCollectionOfIndices [
	| aPreviousSize aNewSize |
	
	(aCollectionOfIndices allSatisfy: [ :eachIndex | eachIndex <= end ])
		ifFalse: [ BlTextOutOfBoundsError signal: 'Insertion can not happen past the end of the SubText' ].
	
	aPreviousSize := text size.
	
	text
		insertStrings: aCollectionOfStrings
		atAll: (aCollectionOfIndices collect: [ :eachIndex | start + eachIndex - 1 ]).
	
	aNewSize := text size.
	end := end + (aNewSize - aPreviousSize)
]

{ #category : #accessing }
BlSubText >> insertText: arg1 at: arg2 [ 
	^ self shouldBeImplemented
]

{ #category : #'text - testing' }
BlSubText >> isEmpty [
	^ self size isZero
]

{ #category : #'text - testing' }
BlSubText >> isNotValid [
	^ end > text size
]

{ #category : #'text - enumeration' }
BlSubText >> iterator [
	^ BlSubTextIterator
		text: self
		from: 1
		to: self size
]

{ #category : #'text - enumeration' }
BlSubText >> iterator: aStartIndex to: anEndIndex [
	^ BlSubTextIterator
		text: self
		from: aStartIndex
		to: anEndIndex
]

{ #category : #copying }
BlSubText >> postCopy [
	super postCopy.
	text := text copy
]

{ #category : #'text - converting' }
BlSubText >> printOn: aStream [
	self isNotValid ifTrue: [ ^ aStream << 'BlSubText(end>text size)' ].
	^ super printOn: aStream
]

{ #category : #'text - accessing' }
BlSubText >> size [
	self assertInvariant.

	^ (start = end and: [ start isZero ])
		ifTrue: [ 0 ]
		ifFalse: [ end - start + 1 ]
]

{ #category : #accessing }
BlSubText >> spansBasedOn: aBlock [
	^ (text spansBasedOn: aBlock from: start to: end)
		collect: [ :each | 
			{each first - start + 1.
				each second - start + 1.
				each third} ]
]

{ #category : #accessing }
BlSubText >> spansBasedOn: aBlock from: aStart to: anEnd [
	^ (text spansBasedOn: aBlock from: aStart + start - 1 to: anEnd + start - 1)
		collect: [ :each | 
			{each first - start + 1.
				each second - start + 1.
				each third} ]
]

{ #category : #accessing }
BlSubText >> start [
	<return: #Number>

	^ start
]

{ #category : #initialization }
BlSubText >> start: aStartIndex end: anEndIndex [
	self assertStart: aStartIndex end: anEndIndex.

	start := aStartIndex.
	end := anEndIndex.
	
	self assertInvariant
]

{ #category : #'text - notifying' }
BlSubText >> suspendAnnouncementsWhile: aBlock [
	super suspendAnnouncementsWhile: [
		self text suspendAnnouncementsWhile: aBlock ]
]

{ #category : #accessing }
BlSubText >> text [
	^ text
]

{ #category : #initialization }
BlSubText >> text: aBrText from: aStartIndex to: anEndIndex [

	text := aBrText.

	self assertStart: aStartIndex end: anEndIndex.
	start := aStartIndex.
	end := anEndIndex.
	
	self assertInvariant
]

{ #category : #'text - accessing' }
BlSubText >> textOffset [
	"Return absolute text offset to better deal with sub-texts"
	<return: #Number>
	
	^ ((self start - 1) max: 0) + self text textOffset
]

{ #category : #accessing }
BlSubText >> unstyle: aFromIndex to: aToIndex [
	self text unstyle: (start + aFromIndex - 1) to: (start + aToIndex - 1)
]

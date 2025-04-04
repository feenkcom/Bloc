"
I am a concrete implementation of a text model backed up by a persistent rope data structure.

See {{gtClass:BlText}} for more information.
See {{gtClass:BlRope}} to learn more about ropes.
See {{gtClass:BlRunTree}} for more about the Run Tree data structures

"
Class {
	#name : #BlRunRopedText,
	#superclass : #BlText,
	#instVars : [
		'attributeRuns',
		'rope'
	],
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #'instance creation' }
BlRunRopedText class >> file: aFileReference [
	<return: #BlRunRopedText>

	^ self rope: (BlCollectionRope collection: (BlRopeableCollectionFile new fileReference: aFileReference))
]

{ #category : #'instance creation' }
BlRunRopedText class >> items: aCollectionOfItems [
	<return: #BlRunRopedText>

	^ self rope: (BlCollectionRope collection: aCollectionOfItems)
]

{ #category : #'instance creation' }
BlRunRopedText class >> rope: aRope [
	^ self new
		initializeWith: aRope;
		yourself
]

{ #category : #'instance creation' }
BlRunRopedText class >> string: aString [
	"Take the supplied string like object, convert it to a normalised string and answer as roped text"
	<return: #BlRunRopedText>

	^ self rope: (BlCollectionRope collection: aString)
]

{ #category : #'text - converting' }
BlRunRopedText >> asRopedText [
	^ self
]

{ #category : #'text - accessing' }
BlRunRopedText >> at: anIndex [
	"Return a character at a given index"
	<return: #Character>

	^ self rope at: anIndex
]

{ #category : #accessing }
BlRunRopedText >> attributeRuns [
	^ attributeRuns ifNil: [ attributeRuns := BlRunTree new: rope size+1 withAll: {  } ]
]

{ #category : #accessing }
BlRunRopedText >> attributeRuns: aRunTree [
	attributeRuns := aRunTree
]

{ #category : #'text - attributes' }
BlRunRopedText >> attributeRunsDo: aBlock [
	self attributeRuns withStartStopAndValueDo: aBlock
]

{ #category : #'text - attributes' }
BlRunRopedText >> attributeRunsDo: aBlock from: aStart to: anEnd [
	self attributeRuns
		withStartStopAndValueDo: aBlock
		from: aStart
		to: anEnd
]

{ #category : #'text - attributes' }
BlRunRopedText >> attributes: anAttributesCollection [
	self
		attributes: anAttributesCollection
		from: 0
		to: self size
]

{ #category : #'text - attributes' }
BlRunRopedText >> attributes: anAttributesCollection from: aFromIndex to: aToIndex [
	| anAffectedText |
	self
		assert: [ aFromIndex <= (aToIndex + 1) ]
		description: 'Start must not exceed end'.

	anAffectedText := self copyFrom: aFromIndex to: aToIndex.

	"Special case to handle attributes on empty text"
	(self isEmpty and: [ aFromIndex = 1 and: [ aToIndex = 0 ] ]) ifTrue: [ 
		self attributeRuns append: anAttributesCollection withOccurrences: 0.
		^ self ].

	self attributeRuns size < aToIndex ifTrue: [ 
		self attributeRuns
			append: {  }
			withOccurrences: aToIndex - self attributeRuns size ].
			
	(self attributeRuns
		 add: anAttributesCollection
		 from: aFromIndex
		 to: aToIndex)
		 	ifFalse: [ ^ self ].
	
	self
		notifyAttributesAdded: anAttributesCollection
		from: aFromIndex
		to: aToIndex
		affectedText: anAffectedText
]

{ #category : #'text - attributes' }
BlRunRopedText >> attributesAt: anIndex [
	"Return a collection of text attributes without duplicates at a given text index"

	<return: #Collection of: #BlTextAttribute>
	
	^ self attributeRuns at: anIndex
]

{ #category : #'text - attributes' }
BlRunRopedText >> attributesFinder [
	^ BlTextAttributesRunFinder new initializeForText: self
]

{ #category : #'text - attributes' }
BlRunRopedText >> clearAttributes: aFromIndex to: aToIndex if: aBlock [
	| anAffectedText |

	aFromIndex <= aToIndex
		ifFalse: [ ^ self ].

	anAffectedText := self copyFrom: aFromIndex to: aToIndex.

	(self attributeRuns
		clearAttributes: aFromIndex
		to: aToIndex
		if: aBlock)
			ifFalse: [ ^ self ].

	self
		notifyAttributesRemovedFrom: aFromIndex
		to: aToIndex
		affectedText: anAffectedText
]

{ #category : #'text - copying' }
BlRunRopedText >> copyFrom: aStartIndex to: anEndIndex [
	"Create a copy of this text within a given indices interval.
	Note: I am different from ==#from:to:== in a sense that I don't create a sub-text that points
	to the original text, I create an independent copy which can be safely used in text editors and other tools.

	README: For compatibility reasons with the rest of the system we allow aStartIndex to be bigger than anEndIndex and also bigger than self size."

	<return: #BlText>
	| result normalizedStartIndex |
	
	"A startIndex is allowed to be 0, so we should prevent negative values"
	normalizedStartIndex := (aStartIndex - 1) max: 0.

	aStartIndex > anEndIndex
		ifTrue: [ ^ self empty
				attributeRuns: (self attributeRuns copyFrom: normalizedStartIndex to: aStartIndex - 1) ].
	result := self class
			rope: (self rope from: normalizedStartIndex to: anEndIndex).
	self attributeRuns size > 0
		ifTrue: [ result
				attributeRuns: (self attributeRuns copyFrom: normalizedStartIndex to: anEndIndex) ].
	^ result
]

{ #category : #'text - modifications' }
BlRunRopedText >> deleteAll: aCollectionOfIntervals [
	"Intervals must not overlap!"

	| theDeletedTexts aRope theUpdatedIntervals |
	theDeletedTexts := aCollectionOfIntervals
		collect: [ :eachInterval | self copyFrom: eachInterval first to: eachInterval last ].
	aRope := rope.
	theUpdatedIntervals := aCollectionOfIntervals collect: #copy.
	theUpdatedIntervals
		do:
			[ :eachCurrentDeletionInterval | 
			eachCurrentDeletionInterval last ~= 0
				ifTrue:
					[ aRope := aRope delete: (eachCurrentDeletionInterval first - 1 max: 0) to: eachCurrentDeletionInterval last.
					self attributeRuns delete: eachCurrentDeletionInterval first to: eachCurrentDeletionInterval last.
					1
						to: theUpdatedIntervals size
						do:
							[ :eachIntervalIndex | 
							| aCurrentIntervalToUpdate |
							aCurrentIntervalToUpdate := theUpdatedIntervals at: eachIntervalIndex.
							aCurrentIntervalToUpdate first > eachCurrentDeletionInterval last
								ifTrue:
									[ theUpdatedIntervals
										at: eachIntervalIndex
										put:
											(aCurrentIntervalToUpdate first - eachCurrentDeletionInterval size
												to: aCurrentIntervalToUpdate last - eachCurrentDeletionInterval size) ] ] ] ].
	self rope: aRope.
	self
		notifyDeletedAll: theUpdatedIntervals
		requested: aCollectionOfIntervals
		texts: theDeletedTexts
]

{ #category : #'text - enumeration' }
BlRunRopedText >> do: aBlock [
	self rope do: aBlock
]

{ #category : #'text - accessing' }
BlRunRopedText >> empty [
	"Return a similar (the same backend data structure) but empty text"
	<return: #BlText>
	
	^ self class string: ''
]

{ #category : #'text - enumeration' }
BlRunRopedText >> from: aFromIndex to: aToIndex do: aBlock [

	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'Start must not exceed end' ].

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].

	self rope
		from: ((aFromIndex - 1) max: 0)
		to: aToIndex
		do: aBlock
]

{ #category : #'text - copying' }
BlRunRopedText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>

	^ {self rope.
		self attributeRuns root}
]

{ #category : #accessing }
BlRunRopedText >> gtAttributeTreeFor: aView [
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

{ #category : #accessing }
BlRunRopedText >> gtIntervalTreeFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Intervals';
		priority: 21;
		items: [ self
				gtIntervalsFrom: 1
				to: self size
				ignoring: #() ];
		children: [ :each | 
			| children |
			children := self
					gtIntervalsFrom: each first
					to: each second
					ignoring: each third , each last.
			(children size = 1 and: [ children first = each ])
				ifTrue: [ #() ]
				ifFalse: [ children ] ];
		column: 'Interval'
			text: [ :each | each first printString , '-' , each second printString ]
			width: 120;
		column: 'Text' text: [ :each | self copyFrom: each first to: each second ];
		column: 'Attributes'
			text: [ :each | String space join: (each third collect: #printString) ];
		send: [ :each | self from: each first to: each second ]
]

{ #category : #accessing }
BlRunRopedText >> gtIntervalsFrom: from to: to ignoring: aCollection [
	| current start children attrs |
	children := OrderedCollection new.
	current := #().
	start := from.
	from
		to: to
		do: [ :i | 
			attrs := (self attributesAt: i) reject: [ :each | aCollection includes: each ].
			(current intersection: attrs)
				ifEmpty: [ (current isEmpty and: [ attrs isEmpty ])
						ifFalse: [ start = i
								ifFalse: [ children
										add: {start.
												i - 1.
												current.
												aCollection}.
									start := i ].
							current := attrs ] ]
				ifNotEmpty: [ :col | current := col ] ].
	(start = from and: [ from > 1 or: [ to < self size ] ])
		ifFalse: [ children
				add: {start.
						to.
						current.
						aCollection} ].
	^ children
]

{ #category : #accessing }
BlRunRopedText >> gtTextAttributesFor: aView [

	<gtView>
	^ aView forward
		  title: 'Attributes';
		  object: [ self attributeRuns ];
		  view: #gtTreeFor:
]

{ #category : #initialization }
BlRunRopedText >> initializeWith: aRope [
	rope := aRope

]

{ #category : #accessing }
BlRunRopedText >> insertAttributeTree: tree atIndex: anInteger [
	| atts |
	atts := tree collectFrom: 1 to: tree size-1.
	self attributeRuns insertAttributes: atts atIndex: anInteger

]

{ #category : #accessing }
BlRunRopedText >> insertAttributes: atts atIndex: anIndex [
	self attributeRuns insertAttributes: atts atIndex: anIndex
]

{ #category : #'text - modifications' }
BlRunRopedText >> insertItems: aCollectionOfCollectionsOfItems atAll: aCollectionOfIndices [
	"I return actual indices after insertion"

	<return: #Collection of: #Number>
	
	| theUpdatedIndices aRope aCurrentItemsIndex |
	aRope := rope.
	theUpdatedIndices := aCollectionOfIndices copy.
	aCurrentItemsIndex := 0.
	aCollectionOfCollectionsOfItems
		with: theUpdatedIndices
		do:
			[ :eachCollection :eachCurrentInsertionIndex | 
			| atts |
			atts := (self isEmpty or: [ eachCurrentInsertionIndex = 0 ])
				ifTrue: [ self attributeRuns first ]
				ifFalse:
					[ (eachCurrentInsertionIndex >= 1 and: [ eachCurrentInsertionIndex <= self attributeRuns size ])
						ifTrue: [ self attributeRuns at: eachCurrentInsertionIndex ]
						ifFalse: [ {} ] ].
			atts := atts select: [ :each | each shouldPropagate ].
			self insertAttributes: (Array new: eachCollection size withAll: atts) atIndex: eachCurrentInsertionIndex + 1.
			aRope := aRope insertItems: eachCollection at: eachCurrentInsertionIndex.
			aCurrentItemsIndex := aCurrentItemsIndex + 1.
			1
				to: theUpdatedIndices size
				do:
					[ :each | 
					| aCurrentIndexToUpdate |
					aCurrentIndexToUpdate := theUpdatedIndices at: each.
					(aCurrentIndexToUpdate >= eachCurrentInsertionIndex and: [ aCurrentItemsIndex ~= each ])
						ifTrue: [ theUpdatedIndices at: each put: aCurrentIndexToUpdate + eachCollection size ] ] ].
	self rope: aRope.
	^ theUpdatedIndices
]

{ #category : #'text - modifications' }
BlRunRopedText >> insertStrings: aCollectionOfStrings atAll: aCollectionOfIndices [
	self
		notifyStringsInserted: aCollectionOfStrings
		atAll: (self
			insertItems: aCollectionOfStrings
			atAll: aCollectionOfIndices)
		requested: aCollectionOfIndices
]

{ #category : #accessing }
BlRunRopedText >> insertText: aText at: anIndex [
	self
		assert: [ aText isKindOf: BlText ]
		description:
			[ 'Trying to insert a {1} instead of {2}'
				format:
					{aText class name.
						BlText name} ].
	self insertAttributeTree: aText attributeRuns atIndex: anIndex+1.
	self rope: (rope insert: aText rope at: anIndex).

	self
		notifyStringsInserted: {aText characters asString}
		atAll: {anIndex}
		requested: {anIndex}
]

{ #category : #'text - testing' }
BlRunRopedText >> isEmpty [
	<return: #Boolean>

	^ self rope size = 0
]

{ #category : #'text - enumeration' }
BlRunRopedText >> iterator [
	"Return an iterator pointing to the first text item (character)"
	<return: #BlTextIterator>

	^ BlRunRopedTextIterator text: self
]

{ #category : #'text - enumeration' }
BlRunRopedText >> iterator: aFromIndex to: aToIndex [
	"Return an iterator pointing to the anStartIndex text item (character) limited by anEndIndex"
	<return: #BlTextIterator>
	
	self
		assert: [ aFromIndex <= (aToIndex + 1) ]
		description: [ 'Start must not exceed end more than by one' ].

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].

	^ BlRunRopedTextIterator text: self from: aFromIndex to: aToIndex
]

{ #category : #accessing }
BlRunRopedText >> postCopy [
	super postCopy.
	attributeRuns := attributeRuns copy
]

{ #category : #accessing }
BlRunRopedText >> rope [
	^ rope
]

{ #category : #accessing }
BlRunRopedText >> rope: aBlRope [
	self initializeWith: aBlRope
]

{ #category : #'text - accessing' }
BlRunRopedText >> size [
	^ self rope size
]

{ #category : #accessing }
BlRunRopedText >> spansBasedOn: aBlock [ 
	^self attributeRuns spansBasedOn: aBlock
]

{ #category : #'as yet unclassified' }
BlRunRopedText >> spansBasedOn: aBlock from: start to: stop [
	^ self attributeRuns
		spansBasedOn: aBlock
		from: start
		to: stop
]

{ #category : #'text - printing' }
BlRunRopedText >> storeOn: aStream [
	aStream
		parenthesize: [ aStream
				parenthesize: [ aStream nextPutAll: 'BlRunRopedText string: '.
					aStream nextPutAll: self asString printString ];
				cr;
				nextPutAll: 'attributeRuns: ';
				parenthesize: [ self attributeRuns storeOn: aStream ] ]
]

{ #category : #'text - attributes' }
BlRunRopedText >> unstyle: aFromIndex to: aToIndex [
	<return: #BlText>
	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'Start must not exceed end' ].
	self
		assert: [ aFromIndex >= 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].
	self
		clearAttributes: aFromIndex
		to: aToIndex
		if: [ :anAttribute | anAttribute isOverwritableByStyler ].
	self
		assert: [ rope size = (self attributeRuns size - 1) ]
		description: 'data structure mismatch'
]

{ #category : #accessing }
BlRunRopedText >> updateFrom: aRopedText [

	"Update the contents from another roped text"

	self rope: aRopedText rope.
	self attributeRuns: aRopedText attributeRuns copy
]

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

{ #category : #'as yet unclassified' }
BlRunRopedText >> attributeRunsDo: aBlock [
	attributeRuns withStartStopAndValueDo: aBlock
]

{ #category : #accessing }
BlRunRopedText >> attributeRunsDo: aBlock from: aStart to: anEnd [
	attributeRuns
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

	self
		assert: [ aFromIndex <= (aToIndex + 1) ]
		description: 'Start must not exceed end'.

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
		 to: aToIndex) ifTrue: [ 
		anAttributesCollection do: [ :eachAttribute | 
			self
				notifyAttributeAdded: eachAttribute
				from: aFromIndex
				to: aToIndex ] ]
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
	aFromIndex <= aToIndex ifFalse: [ ^ self ].
	(self attributeRuns
		clearAttributes: aFromIndex
		to: aToIndex
		if: aBlock) ifTrue: [ self notifyAttributesRemovedFrom: aFromIndex to: aToIndex ]
]

{ #category : #'text - copying' }
BlRunRopedText >> copyFrom: aStartIndex to: anEndIndex [
	"Create a copy of this text within a given indices interval.
	Note: I am different from ==#from:to:== in a sense that I don't create a sub-text that points
	to the original text, I create an independent copy which can be safely used in text editors and other tools.

	README: For compatibility reasons with the rest of the system we allow aStartIndex to be bigger than anEndIndex and also bigger than self size."

	<return: #BlText>
	
	| result |
	aStartIndex > anEndIndex ifTrue: [ ^ self empty ].
	result := self class rope: (self rope from: (aStartIndex - 1 max: 0) to: anEndIndex).
	self attributeRuns size > 0
		ifTrue: [ result attributeRuns: (self attributeRuns copyFrom: aStartIndex-1 to: anEndIndex) ].
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
		parenthesize:
			[ aStream
				parenthesize:
						[ aStream nextPutAll: 'BlRunRopedText string: '.
							aStream stringQuote: [ aStream nextPutAll: self asString ] ];
				cr;
				nextPutAll: 'attributeRuns: ';
				parenthesize: [ self attributeRuns storeOn: aStream ] ]
]

{ #category : #'text - attributes' }
BlRunRopedText >> unstyle: aFromIndex to: aToIndex [
	<return: #BlText>
	
	self assert: [ aFromIndex <= aToIndex ] description: [ 'Start must not exceed end' ].
	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].
	self
		clearAttributes: aFromIndex
		to: aToIndex
		if: [ :anAttribute | anAttribute isOverwritableByStyler ].
			self assert: [rope size = (self attributeRuns size - 1)] description: 'data structure mismatch'.
]

{ #category : #accessing }
BlRunRopedText >> updateFrom: aRopedText [

	"Update the contents from another roped text"

	self rope: aRopedText rope.
	self attributeRuns: aRopedText attributeRuns copy
]

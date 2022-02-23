"
I am a concrete implementation of a text model backed up by a persistent rope data structure.
I store text attributes as part of the rope
"
Class {
	#name : #BlAttributedRopedText,
	#superclass : #BlText,
	#instVars : [
		'rope',
		'attributesFinder'
	],
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #'instance creation' }
BlAttributedRopedText class >> file: aFileReference [
	<return: #BlAttributedRopedText>

	^ self rope: (BlCollectionRope collection: (BlRopeableCollectionFile new fileReference: aFileReference))
]

{ #category : #'instance creation' }
BlAttributedRopedText class >> items: aCollectionOfItems [
	<return: #BlAttributedRopedText>

	^ self rope: (BlCollectionRope collection: aCollectionOfItems)
]

{ #category : #'instance creation' }
BlAttributedRopedText class >> rope: aRope [
	^ self new
		initializeWith: aRope;
		yourself
]

{ #category : #'instance creation' }
BlAttributedRopedText class >> string: aString [
	"Take the supplied string like object, convert it to a normalised string and answer as roped text"
	<return: #BlAttributedRopedText>

	^ self rope: (BlCollectionRope collection: aString)
]

{ #category : #'text - converting' }
BlAttributedRopedText >> asRopedText [
	^ self
]

{ #category : #'text - accessing' }
BlAttributedRopedText >> at: anIndex [
	"Return a character at a given index"
	<return: #Character>

	^ self rope at: anIndex
]

{ #category : #'text - attributes' }
BlAttributedRopedText >> attributes: anAttributesCollection [
	| aNewRope |
	
	aNewRope := rope attributes: anAttributesCollection.
	aNewRope == rope
		ifTrue: [ ^ self ].

	self rope: aNewRope.

	anAttributesCollection do: [ :eachAttribute |
		self notifyAttributeAdded: eachAttribute from: (1 min: aNewRope size) to: aNewRope size ]
]

{ #category : #'text - attributes' }
BlAttributedRopedText >> attributes: anAttributesCollection from: aFromIndex to: aToIndex [
	| aNewRope |
	
	self
		assert: [ aFromIndex <= (aToIndex + 1) ]
		description: [ 'Start must not exceed end' ].

	self
		assert: [ self isNotEmpty or: [ aFromIndex = 1 and: [ aToIndex isZero ] ] ]
		description: [ 'If I am empty then start must be 1 and end must be zero' ].
	
	aNewRope := rope attributes: anAttributesCollection from: ((aFromIndex - 1) max: 0) to: aToIndex.	
	aNewRope == rope
		ifTrue: [ ^ self ].
	
	self rope: aNewRope.
	
	anAttributesCollection do: [ :eachAttribute |
		self notifyAttributeAdded: eachAttribute from: aFromIndex to: aToIndex ]
]

{ #category : #'text - attributes' }
BlAttributedRopedText >> attributesFinder [
	^ attributesFinder ifNil: [ attributesFinder := BlTextAttributesCachingFinder new initializeForText: self ]
]

{ #category : #'text - attributes' }
BlAttributedRopedText >> clearAttributes: aFromIndex to: aToIndex if: aBlock [
	| aNewRope |
	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'Start must not exceed end' ].

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].
	
	aNewRope := rope clearAttributes: ((aFromIndex - 1) max: 0) to: aToIndex if: aBlock.
	aNewRope == rope
		ifTrue: [ ^ self ].
	
	self rope: aNewRope.
	self notifyAttributesRemovedFrom: aFromIndex to: aToIndex
]

{ #category : #'text - copying' }
BlAttributedRopedText >> copyFrom: aStartIndex to: anEndIndex [
	"Create a copy of this text within a given indices interval.
	Note: I am different from ==#from:to:== in a sense that I don't create a sub-text that points
	to the original text, I create an independent copy which can be safely used in text editors and other tools.

	README: For compatibility reasons with the rest of the system we allow aStartIndex to be bigger than anEndIndex and also bigger than self size."
	<return: #BlText>

	aStartIndex > anEndIndex
		ifTrue: [ ^ self empty ].

	^ self class rope: (self rope from: ((aStartIndex - 1) max: 0) to: anEndIndex)
]

{ #category : #'text - modifications' }
BlAttributedRopedText >> deleteAll: aCollectionOfIntervals [
	"Intervals must not overlap!"
	| theDeletedTexts aRope theUpdatedIntervals |
	
	theDeletedTexts := aCollectionOfIntervals
		collect: [ :eachInterval | self copyFrom: eachInterval first to: eachInterval last ].
	
	aRope := rope.
	
	theUpdatedIntervals := aCollectionOfIntervals collect: #copy.
	
	theUpdatedIntervals
		do: [ :eachCurrentDeletionInterval |
			aRope := aRope delete: ((eachCurrentDeletionInterval first - 1) max: 0) to: eachCurrentDeletionInterval last.
	
			1 to: theUpdatedIntervals size do: [ :eachIntervalIndex |
				| aCurrentIntervalToUpdate |
			
				aCurrentIntervalToUpdate := theUpdatedIntervals at: eachIntervalIndex.
				
				aCurrentIntervalToUpdate first > eachCurrentDeletionInterval last
					ifTrue: [
						theUpdatedIntervals
							at: eachIntervalIndex
							put: (
								(aCurrentIntervalToUpdate first - eachCurrentDeletionInterval size)
								to: (aCurrentIntervalToUpdate last - eachCurrentDeletionInterval size)) ] ] ].
	
	self rope: aRope.
	self
		notifyDeletedAll: theUpdatedIntervals
		requested: aCollectionOfIntervals
		texts: theDeletedTexts
]

{ #category : #'text - enumeration' }
BlAttributedRopedText >> do: aBlock [
	self rope do: aBlock
]

{ #category : #'text - accessing' }
BlAttributedRopedText >> empty [
	"Return a similar (the same backend data structure) but empty text"
	<return: #BlText>
	
	^ self class string: ''
]

{ #category : #'text - enumeration' }
BlAttributedRopedText >> from: aFromIndex to: aToIndex do: aBlock [

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
BlAttributedRopedText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>

	^ self rope
]

{ #category : #initialization }
BlAttributedRopedText >> initialize [
	super initialize.
	
	attributesFinder := nil
]

{ #category : #initialization }
BlAttributedRopedText >> initializeWith: aRope [
	rope := aRope.
	attributesFinder := nil
]

{ #category : #'text - modifications' }
BlAttributedRopedText >> insertItems: aCollectionOfCollectionsOfItems atAll: aCollectionOfIndices [
	"I return actual indices after insertion"
	<return: #Collection of: #Number>
	| theUpdatedIndices aRope aCurrentItemsIndex |
	
	aRope := rope.
	
	theUpdatedIndices := aCollectionOfIndices copy.
	
	aCurrentItemsIndex := 0.
	aCollectionOfCollectionsOfItems
		with: theUpdatedIndices
		do: [ :eachCollection :eachCurrentInsertionIndex |
			aRope := aRope insertItems: eachCollection at: eachCurrentInsertionIndex.
	
			aCurrentItemsIndex := aCurrentItemsIndex + 1.
			1 to: theUpdatedIndices size do: [ :each |
				| aCurrentIndexToUpdate |
				aCurrentIndexToUpdate := theUpdatedIndices at: each.
				(aCurrentIndexToUpdate >= eachCurrentInsertionIndex and: [ aCurrentItemsIndex ~= each ])
					ifTrue: [
						theUpdatedIndices
							at: each
							put: (aCurrentIndexToUpdate + eachCollection size) ] ] ].
	self rope: aRope.
	^ theUpdatedIndices
]

{ #category : #'text - modifications' }
BlAttributedRopedText >> insertStrings: aCollectionOfStrings atAll: aCollectionOfIndices [
	self
		notifyStringsInserted: aCollectionOfStrings
		atAll: (self
			insertItems: aCollectionOfStrings
			atAll: aCollectionOfIndices)
		requested: aCollectionOfIndices
]

{ #category : #accessing }
BlAttributedRopedText >> insertText: aText at: anIndex [
	self
		assert: [ aText isKindOf: BlText ]
		description: [ 'Trying to insert a {1} instead of {2}'
				format:
					{aText class name.
					BlText name} ].
	self rope: (rope insert: aText rope at: anIndex).
	self
		notifyStringsInserted: { aText characters asString }
		atAll: { anIndex }
		requested: { anIndex }
]

{ #category : #'text - testing' }
BlAttributedRopedText >> isEmpty [
	<return: #Boolean>

	^ self rope size = 0
]

{ #category : #'text - enumeration' }
BlAttributedRopedText >> iterator [
	"Return an iterator pointing to the first text item (character)"
	<return: #BlTextIterator>

	^ BlAttributedRopedTextIterator text: self
]

{ #category : #'text - enumeration' }
BlAttributedRopedText >> iterator: aFromIndex to: aToIndex [
	"Return an iterator pointing to the anStartIndex text item (character) limited by anEndIndex"
	<return: #BlTextIterator>
	
	self
		assert: [ aFromIndex <= (aToIndex + 1) ]
		description: [ 'Start must not exceed end more than by one' ].

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].

	^ BlAttributedRopedTextIterator text: self from: aFromIndex to: aToIndex
]

{ #category : #accessing }
BlAttributedRopedText >> rope [
	^ rope
]

{ #category : #accessing }
BlAttributedRopedText >> rope: aBlRope [
	self initializeWith: aBlRope
]

{ #category : #'text - accessing' }
BlAttributedRopedText >> size [
	^ self rope size
]

{ #category : #'text - printing' }
BlAttributedRopedText >> storeOn: aStream [
	| anIterator allPieces attributesMap bindingsMap |
		
	anIterator := self iterator.
	
	allPieces := Array streamContents: [ :anArrayStream |
		[ anIterator hasNext ] whileTrue: [
			| aSpan aSpanIterator aDelta |
			aDelta := anIterator position.
			aSpan := anIterator nextSpan.
			aSpanIterator := aSpan iterator.
			[ aSpanIterator hasNext ] whileTrue: [
				aSpanIterator
					nextAttributedEnd: [ :eachAttribute | true ]
					indicesDo: [ :aStart :anEnd :theAttributes |
						anArrayStream nextPut: { aStart + aDelta . anEnd + aDelta . theAttributes }  ] ] ] ].
	
	attributesMap := (allPieces flatCollect: [ :eachTuple | eachTuple last ])
		groupedBy: [ :eachAttribute | eachAttribute ]
		having: [ :eachGroup | eachGroup size > 1 ].
	attributesMap := attributesMap collect: #size.

	attributesMap := attributesMap associations groupedBy: [ :eachAssociation | eachAssociation key class ].
	bindingsMap := IdentityDictionary new.

	attributesMap keysAndValuesDo: [ :eachClass :theAttributes |
		theAttributes withIndexDo: [ :eachAttribute :eachIndex |
			bindingsMap at: eachAttribute key put: 'a', eachClass name, eachIndex asString ] ].

	bindingsMap keysAndValuesDo: [ :eachAttribute :eachVariableName |
		aStream nextPutAll: eachVariableName.
		aStream nextPutAll: ' := '.
		aStream store: eachAttribute.
		aStream nextPut: $. ; cr ].
	
	allPieces withIndexDo: [ :eachTuple :anIndex |
		anIndex > 1
			ifTrue: [ aStream nextPutAll: ', '; cr ].
		
		aStream
			nextPut: $(;
			nextPut: $';
			nextPutAll: ((self from: eachTuple first to: eachTuple second) asString copyReplaceAll: $' asString with: '''''');
			nextPut: $';
			space;
			nextPutAll: #asRopedText asString.
		
		eachTuple third ifNotEmpty: [ :theAttributes |
			aStream
				space;
				nextPutAll: #attributes: asString;
				space.
			aStream nextPut: ${; cr.
			theAttributes
				do: [ :eachAttribute |
					aStream tab.
					
					aStream nextPutAll: (bindingsMap
						at: eachAttribute
						ifAbsent: [ eachAttribute storeString ]) ]
				separatedBy: [ aStream nextPut: $.; cr ].
			aStream cr; nextPut: $} ].
		aStream nextPut: $)
	]
]

{ #category : #'text - attributes' }
BlAttributedRopedText >> unstyle: aFromIndex to: aToIndex [
	<return: #BlText>
	| anUnstyledRope aPreviousRope |

	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'Start must not exceed end' ].

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].

	aPreviousRope := rope.

	"First refer original rope to support multithreading"
	anUnstyledRope := rope.
	anUnstyledRope := anUnstyledRope
		clearAttributes: ((aFromIndex - 1) max: 0)
		to: aToIndex
		if: [ :anAttribute | anAttribute isOverwritableByStyler ].
	
	self rope: anUnstyledRope.
	
	aPreviousRope == anUnstyledRope
		ifFalse: [ self notifyAttributesRemovedFrom: aFromIndex to: aToIndex ]
]

{ #category : #accessing }
BlAttributedRopedText >> updateFrom: aRopedText [

	"Update the contents from another roped text"

	self rope: aRopedText rope
]

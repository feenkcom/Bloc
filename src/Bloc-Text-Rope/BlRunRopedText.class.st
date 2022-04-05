"
I am a concrete implementation of a text model backed up by a persistent rope data structure.

See BrText for more information.
See BrRope to learn more about rope.

	attributeRuns: <RunArray> 	Run array of text attributes.

"
Class {
	#name : #BlRunRopedText,
	#superclass : #BlAbstractRopedText,
	#instVars : [
		'attributeRuns'
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

{ #category : #accessing }
BlRunRopedText >> attributeRuns [
	^ attributeRuns ifNil: [ attributeRuns := BlRunTree new: rope size+1 withAll: {  } ]
]

{ #category : #accessing }
BlRunRopedText >> attributeRuns: aRunTree [
	attributeRuns := aRunTree
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
BlRunRopedText >> attributesFinder [
	^ BlTextAttributesRunFinder new initializeForText: self
]

{ #category : #'text - attributes' }
BlRunRopedText >> clearAttributes: aFromIndex to: aToIndex if: aBlock [
	aFromIndex <= aToIndex ifFalse: [ ^ self ].
	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: 'Start and end must be positive or both zero'.
	(aFromIndex = 0 and: [ aToIndex = 0 ]) ifTrue: [ ^ self ].
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

{ #category : #accessing }
BlRunRopedText >> gtTextAttributesFor: aView [

	<gtView>
	^ aView forward
		  title: 'Attributes';
		  object: [ self attributeRuns ];
		  view: #gtTreeFor:
]

{ #category : #accessing }
BlRunRopedText >> gtTextFor: aView [

	^ aView explicit
		  title: 'Text';
		  priority: 1;
		  stencil: [ 
			  BrEditorElement new
				  editor: (BrTextEditor new text: self);
				  margin: (BlInsets all: 10);
				  constraintsDo: [ :c | 
					  c vertical matchParent.
					  c horizontal matchParent ] ]
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
			self insertAttributes: (Array new: eachCollection size withAll: atts) atIndex: eachCurrentInsertionIndex.
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

{ #category : #'text - printing' }
BlRunRopedText >> storeOn: aStream [
	aStream
		nextPutAll: '((BlRunRopedText string: ''';
		nextPutAll: self asString;
		nextPutAll: ''')';
		cr;
		nextPutAll: 'attributeRuns: (';
		cr.
	self attributeRuns storeOn: aStream.
	aStream nextPutAll: '))'
]

{ #category : #'text - attributes' }
BlRunRopedText >> unstyle: aFromIndex to: aToIndex [
	<return: #BlText>
	
	| anUnstyledRope aPreviousRope |
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

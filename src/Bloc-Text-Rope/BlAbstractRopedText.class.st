Class {
	#name : #BlAbstractRopedText,
	#superclass : #BlText,
	#instVars : [
		'rope'
	],
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #'text - converting' }
BlAbstractRopedText >> asRopedText [
	^ self
]

{ #category : #'text - accessing' }
BlAbstractRopedText >> at: anIndex [
	"Return a character at a given index"
	<return: #Character>

	^ self rope at: anIndex
]

{ #category : #accessing }
BlAbstractRopedText >> collapse [
	"Collapse data structure"
]

{ #category : #'text - enumeration' }
BlAbstractRopedText >> do: aBlock [
	self rope do: aBlock
]

{ #category : #'text - accessing' }
BlAbstractRopedText >> empty [
	"Return a similar (the same backend data structure) but empty text"
	<return: #BlText>
	
	^ self class string: ''
]

{ #category : #'text - enumeration' }
BlAbstractRopedText >> from: aFromIndex to: aToIndex do: aBlock [

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
BlAbstractRopedText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>

	^ self rope
]

{ #category : #initialization }
BlAbstractRopedText >> initializeWith: aRope [
	rope := aRope

]

{ #category : #'text - modifications' }
BlAbstractRopedText >> insertItems: aCollectionOfCollectionsOfItems atAll: aCollectionOfIndices [
	self subclassResponsibility 
]

{ #category : #'text - modifications' }
BlAbstractRopedText >> insertStrings: aCollectionOfStrings atAll: aCollectionOfIndices [
	self
		notifyStringsInserted: aCollectionOfStrings
		atAll: (self
			insertItems: aCollectionOfStrings
			atAll: aCollectionOfIndices)
		requested: aCollectionOfIndices
]

{ #category : #'text - modifications' }
BlAbstractRopedText >> insertText: aText at: anIndex [
	self subclassResponsibility 
]

{ #category : #'text - testing' }
BlAbstractRopedText >> isEmpty [
	<return: #Boolean>

	^ self rope size = 0
]

{ #category : #'text - enumeration' }
BlAbstractRopedText >> iterator [
	self subclassResponsibility 
]

{ #category : #'text - enumeration' }
BlAbstractRopedText >> iterator: aFromIndex to: aToIndex [
	self subclassResponsibility 
]

{ #category : #accessing }
BlAbstractRopedText >> rope [
	^ rope
]

{ #category : #accessing }
BlAbstractRopedText >> rope: aBlRope [
	self initializeWith: aBlRope
]

{ #category : #'text - accessing' }
BlAbstractRopedText >> size [
	^ self rope size
]

{ #category : #accessing }
BlAbstractRopedText >> updateFrom: aRopedText [
	self subclassResponsibility 
]

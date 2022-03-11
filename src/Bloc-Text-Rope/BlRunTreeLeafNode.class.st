Class {
	#name : #BlRunTreeLeafNode,
	#superclass : #BlRunTreeAbstractNode,
	#instVars : [
		'attributes'
	],
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #accessing }
BlRunTreeLeafNode class >> length: anInteger attributes: anObject [
	^ (self new)
		length: anInteger;
		attributes: anObject;
		yourself
]

{ #category : #accessing }
BlRunTreeLeafNode class >> mergeAttributes: aCollectionOfAttributes and: anotherCollectionOfAttributes [
	"Merge two collection of attributes letting anotherCollectionOfAttributes to override
	attributes from aCollectionOfAttributes based on its type"
	<return: #Collection of: #Object>
	| anOrderedDictionary |
	
	((aCollectionOfAttributes isKindOf: HashedCollection) or: [ anotherCollectionOfAttributes isKindOf: HashedCollection ])
		ifTrue: [ self notify: 'Hashed collection is unordered, so the order of attributes will be ignored!' ].
	
	anOrderedDictionary := OrderedDictionary new.

	aCollectionOfAttributes do: [ :each | anOrderedDictionary at: (self typeOf: each) put: each ].
	anotherCollectionOfAttributes do: [ :each | anOrderedDictionary at: (self typeOf: each) put: each ].

	^ anOrderedDictionary values
]

{ #category : #accessing }
BlRunTreeLeafNode class >> typeOf: anObject [
	| anAttributeClass |
	
	anAttributeClass := self environment
		at: #BlTextAttribute
		ifAbsent: [ ^ anObject ].
		
	^ (anObject class == anAttributeClass or: [ anObject class inheritsFrom: anAttributeClass ])
		ifTrue: [ anObject type ]
		ifFalse: [ anObject ]
]

{ #category : #accessing }
BlRunTreeLeafNode >> add: someAttributes from: start to: end [

	| left middle right |
	(start = 1 and: [ end = length ]) ifTrue: [ 
		attributes := self class
			              mergeAttributes: attributes
			              and: someAttributes.
		^ self ].
	start > 1 ifTrue: [ 
		left := BlRunTreeLeafNode length: start - 1 attributes: attributes ].
	middle := BlRunTreeLeafNode
		          length: end - start + 1
		          attributes:
		          (self class
			           mergeAttributes: attributes
			           and: someAttributes).
	end < length ifTrue: [ 
		right := BlRunTreeLeafNode
			         length: length - end
			         attributes: attributes ].
	left ifNil: [ ^ BlRunTreeNode left: middle right: right ].
	right ifNil: [ ^ BlRunTreeNode left: left right: middle ].
	^ BlRunTreeNode
		  left: left
		  right: (BlRunTreeNode left: middle right: right)
]

{ #category : #accessing }
BlRunTreeLeafNode >> append: someAttributes withOccurrences: anInteger [
	| left middle right |
	someAttributes = attributes
		ifTrue:
			[ length := length + anInteger.
			^ self ].
	^ BlRunTreeNode left: self right: (BlRunTreeLeafNode length: anInteger attributes: someAttributes)
]

{ #category : #accessing }
BlRunTreeLeafNode >> at: anIndex [
	self assert: [ (anIndex >= 1) & (anIndex <= length) ] description: 'Out of bounds access'.
	^ attributes
]

{ #category : #accessing }
BlRunTreeLeafNode >> attributes [

	^ attributes
]

{ #category : #accessing }
BlRunTreeLeafNode >> attributes: anObject [

	attributes := anObject
]

{ #category : #accessing }
BlRunTreeLeafNode >> children [
	^{ }
]

{ #category : #accessing }
BlRunTreeLeafNode >> clearAttributes: start to: end if: aBlock [
	| left middle right |
	(start = 1 and: [ end = length ])
		ifTrue:
			[ attributes := attributes reject: aBlock.
			^ self ].
	start > 1 ifTrue: [ left := BlRunTreeLeafNode length: start - 1 attributes: attributes ].
	middle := BlRunTreeLeafNode length: end - start + 1 attributes: (attributes reject: aBlock).
	end < length ifTrue: [ right := BlRunTreeLeafNode length: length - end attributes: attributes ].
	left ifNil: [ ^ BlRunTreeNode left: middle right: right ].
	right ifNil: [ ^ BlRunTreeNode left: left right: middle ].
	^ BlRunTreeNode left: left right: (BlRunTreeNode left: middle right: right)
]

{ #category : #copying }
BlRunTreeLeafNode >> collectInto: aCollection from: start to: end [
	self assert: [ end <= length ] description: 'access out bounds in leafnode'.
	aCollection add: attributes withOccurrences: end - start + 1.
	^ aCollection
]

{ #category : #copying }
BlRunTreeLeafNode >> copyFrom: start to: end [
	self assert: [ end <= length] description: 'access out bounds in leafnode'.
	^BlRunTreeLeafNode length: end - start + 1 attributes: attributes
]

{ #category : #accessing }
BlRunTreeLeafNode >> foo [
	^#[1]
]

{ #category : #accessing }
BlRunTreeLeafNode >> gtAttributesFor: aView [
	<gtView>
	^aView list
		title: 'Attributes';
		priority: 1;
		items: [ self attributes ]
]

{ #category : #accessing }
BlRunTreeLeafNode >> height [
	^1
]

{ #category : #accessing }
BlRunTreeLeafNode >> insert: someAttributes atIndex: anInteger [
	| left middle right |
	someAttributes = attributes
		ifTrue:
			[ length := length + 1.
			^ self ].
	anInteger > 1 ifTrue: [ left := BlRunTreeLeafNode length: anInteger - 1 attributes: attributes ].
	middle := BlRunTreeLeafNode length: 1 attributes: someAttributes.
	anInteger <= length ifTrue: [ right := BlRunTreeLeafNode length: length - anInteger + 1 attributes: attributes ].
	left ifNil: [ ^ BlRunTreeNode left: middle right: right ].
	right ifNil: [ ^ BlRunTreeNode left: left right: middle ].
	^ BlRunTreeNode left: left right: (BlRunTreeNode left: middle right: right)
]

{ #category : #accessing }
BlRunTreeLeafNode >> isLeaf [
	^true
]

{ #category : #accessing }
BlRunTreeLeafNode >> replaceAllWith: someAttributes from: start to: end [
	| left middle right |
	(someAttributes = attributes or: [ start = 1 and: [ end = length ] ])
		ifTrue:
			[ attributes := someAttributes.
			^ self ].
	start > 1 ifTrue: [ left := BlRunTreeLeafNode length: start - 1 attributes: attributes ].
	middle := BlRunTreeLeafNode length: end - start + 1 attributes: someAttributes.
	end < length ifTrue: [ right := BlRunTreeLeafNode length: length - end attributes: attributes ].
	left ifNil: [ ^ BlRunTreeNode left: middle right: right ].
	right ifNil: [ ^ BlRunTreeNode left: left right: middle ].
	^ BlRunTreeNode left: left right: (BlRunTreeNode left: middle right: right)
]

{ #category : #accessing }
BlRunTreeLeafNode >> runEndAt: anIndex [
	^length
]

{ #category : #enumerating }
BlRunTreeLeafNode >> withOffset: anInteger do: aBlock [
	aBlock value: anInteger value: self
]

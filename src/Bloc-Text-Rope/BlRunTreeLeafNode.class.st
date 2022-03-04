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
BlRunTreeLeafNode >> add: someAttributes from: start to: end [
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
BlRunTreeLeafNode >> at: anIndex [
	self assert: [ (anIndex >= 1 & anIndex) <= length ] description: 'Out of bounds access'.
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

{ #category : #copying }
BlRunTreeLeafNode >> copyFrom: start to: end [
	self assert: [ end <= length] description: 'access out bounds in leafnode'.
	^BlRunTreeLeafNode length: end - start + 1 attributes: attributes
]

{ #category : #accessing }
BlRunTreeLeafNode >> height [
	^1
]

{ #category : #accessing }
BlRunTreeLeafNode >> isLeaf [
	^true
]

{ #category : #accessing }
BlRunTreeLeafNode >> replaceWith: someAttributes from: start to: end [
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

{ #category : #enumerating }
BlRunTreeLeafNode >> withOffset: anInteger do: aBlock [
	aBlock value: anInteger value: self
]

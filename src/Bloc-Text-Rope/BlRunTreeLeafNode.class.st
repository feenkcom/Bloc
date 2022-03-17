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

{ #category : #'add / remove' }
BlRunTreeLeafNode >> add: someAttributes from: start to: end [
	| left middle right |
	start > 1 ifTrue: [ left := BlRunTreeLeafNode length: start - 1 attributes: attributes ].
	middle := BlRunTreeLeafNode
		length: end - start + 1
		attributes: (BlTextAttribute mergeAttributes: attributes and: someAttributes).
	end < length ifTrue: [ right := BlRunTreeLeafNode length: length - end attributes: attributes ].
	(left isNil and: [ right isNil ]) ifTrue: [ ^ middle ].
	left ifNil: [ ^ BlRunTreeNode left: middle right: right ].
	right ifNil: [ ^ BlRunTreeNode left: left right: middle ].
	^ self
		threeLeafSubtreeFromLeft: left
		middle: middle
		right: right
]

{ #category : #'add / remove' }
BlRunTreeLeafNode >> append: someAttributes withOccurrences: anInteger [

	| left middle right |
	someAttributes = attributes ifTrue: [ 
		length := length + anInteger.
		^ self ].
	length isZero ifTrue: [ 
		length := anInteger.
		attributes := someAttributes.
		^ self ].
	^ BlRunTreeNode
		  left: self
		  right:
		  (BlRunTreeLeafNode length: anInteger attributes: someAttributes)
]

{ #category : #accessing }
BlRunTreeLeafNode >> at: anIndex [

	(anIndex >= 1 and: [ length == 0 or: [ anIndex <= length ] ]) 
		ifFalse: [ ^ #(  ) ].
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

{ #category : #'add / remove' }
BlRunTreeLeafNode >> clearAttributes: start to: end if: aBlock [
	| left middle right |
	start > 1 ifTrue: [ left := BlRunTreeLeafNode length: start - 1 attributes: attributes ].
	middle := BlRunTreeLeafNode length: end - start + 1 attributes: (attributes reject: aBlock).
	end < length ifTrue: [ right := BlRunTreeLeafNode length: length - end attributes: attributes ].
	(left isNil and: [ right isNil ]) ifTrue: [ ^ middle ].
	left
		ifNil:
			[ ^ middle attributes = right attributes
				ifTrue: [ BlRunTreeLeafNode length: middle length + right length attributes: middle attributes ]
				ifFalse: [ BlRunTreeNode left: middle right: right ] ].
	right
		ifNil:
			[ ^ left attributes = middle attributes
				ifTrue: [ BlRunTreeLeafNode length: left length + middle length attributes: left attributes ]
				ifFalse: [ BlRunTreeNode left: left right: middle ] ].
	^ self
		threeLeafSubtreeFromLeft: left
		middle: middle
		right: right
]

{ #category : #enumerating }
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

{ #category : #'add / remove' }
BlRunTreeLeafNode >> delete: start to: end [
	self assert: [ end <= length ] description: 'Attempted to deleted outside bounds of leaf node'.
	length := length - (end - start + 1) max: 0.
	^ self
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

{ #category : #'add / remove' }
BlRunTreeLeafNode >> insert: someAttributes atIndex: anInteger [
	| left middle right |
	someAttributes = attributes
		ifTrue:
			[ length := length + 1.
			^ self ].
	anInteger > 1 ifTrue: [ left := BlRunTreeLeafNode length: anInteger - 1 attributes: attributes ].
	middle := BlRunTreeLeafNode length: 1 attributes: someAttributes.
	anInteger <= length ifTrue: [ right := BlRunTreeLeafNode length: length - anInteger + 1 attributes: attributes ].
	(left isNil and: [ right isNil ]) ifTrue: [ ^ middle ].
	left ifNil: [ ^ BlRunTreeNode left: middle right: right ].
	right ifNil: [ ^ BlRunTreeNode left: left right: middle ].
	^ self
		threeLeafSubtreeFromLeft: left
		middle: middle
		right: right
]

{ #category : #accessing }
BlRunTreeLeafNode >> isLeaf [
	^true
]

{ #category : #accessing }
BlRunTreeLeafNode >> priority [
	"Leaf nodes should never rotate up"
	^-1
]

{ #category : #'add / remove' }
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
	^ self
		threeLeafSubtreeFromLeft: left
		middle: middle
		right: right
]

{ #category : #accessing }
BlRunTreeLeafNode >> runEndAt: anIndex [
	^length
]

{ #category : #'add / remove' }
BlRunTreeLeafNode >> threeLeafSubtreeFromLeft: left middle: middle right: right [
	| child parent |
	child := BlRunTreeNode left: middle right: right.
	parent := BlRunTreeNode left: left right: child.
	child priority: parent priority / 2.
	^ parent
]

{ #category : #enumerating }
BlRunTreeLeafNode >> withOffset: anInteger do: aBlock [
	aBlock value: anInteger value: self
]

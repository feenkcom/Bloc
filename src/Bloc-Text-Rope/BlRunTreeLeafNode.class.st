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

	| left middle right newAtts |
	newAtts := BlTextAttribute
		           mergeAttributes: attributes
		           and: someAttributes.
	(newAtts = attributes and: [ start <= 0 and: [ end >= (length - 1) ] ]) 
		ifTrue: [ ^ self ].
	start > 0 ifTrue: [ 
		left := BlRunTreeLeafNode length: start attributes: attributes ].
	middle := BlRunTreeLeafNode
		          length: end - start + 1
		          attributes: newAtts.
	end < (length - 1) ifTrue: [ 
		right := BlRunTreeLeafNode
			         length: length - end - 1
			         attributes: attributes ].
	(left isNil and: [ right isNil ]) ifTrue: [ ^ middle ].
	left ifNil: [ ^ BlRunTreeNode left: middle right: right ].
	right ifNil: [ ^ BlRunTreeNode left: left right: middle ].
	^ self threeLeafSubtreeFromLeft: left middle: middle right: right
]

{ #category : #'add / remove' }
BlRunTreeLeafNode >> append: someAttributes withOccurrences: anInteger [

	| left middle right |
	someAttributes = attributes ifTrue: [ 
		^ BlRunTreeLeafNode
			  length: length + anInteger
			  attributes: attributes ].
	length isZero ifTrue: [ 
		^ BlRunTreeLeafNode length: anInteger attributes: someAttributes ].
	^ BlRunTreeNode
		  left: self
		  right:
		  (BlRunTreeLeafNode length: anInteger attributes: someAttributes)
]

{ #category : #accessing }
BlRunTreeLeafNode >> at: anIndex [

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
	| left middle right newAtts |
	newAtts := attributes reject: aBlock.
	newAtts size = attributes size ifTrue: [ ^ self ].
	start > 0 ifTrue: [ left := BlRunTreeLeafNode length: start attributes: attributes ].
	middle := BlRunTreeLeafNode length: end - start + 1 attributes: newAtts.
	end < (length - 1) ifTrue: [ right := BlRunTreeLeafNode length: length - end - 1 attributes: attributes ].
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
	self assert: [ end < length ] description: 'access out bounds in leafnode'.
	aCollection add: attributes withOccurrences: end - start + 1.
	^ aCollection
]

{ #category : #copying }
BlRunTreeLeafNode >> copyFrom: start to: end [
	self assert: [ end < length] description: 'access out bounds in leafnode'.
	^BlRunTreeLeafNode length: end - start + 1 attributes: attributes
]

{ #category : #'add / remove' }
BlRunTreeLeafNode >> delete: start to: end [
	self assert: [ end < length ] description: 'Attempted to deleted outside bounds of leaf node'.
	^ BlRunTreeLeafNode length: (length - (end - start + 1) max: 0) attributes: attributes
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
	someAttributes = attributes ifTrue: [ ^ BlRunTreeLeafNode length: length + 1 attributes: attributes ].
	anInteger > 0 ifTrue: [ left := BlRunTreeLeafNode length: anInteger attributes: attributes ].
	middle := BlRunTreeLeafNode length: 1 attributes: someAttributes.
	anInteger < length ifTrue: [ right := BlRunTreeLeafNode length: length - anInteger attributes: attributes ].
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
	start > 0 ifTrue: [ left := BlRunTreeLeafNode length: start attributes: attributes ].
	middle := BlRunTreeLeafNode length: end - start + 1 attributes: someAttributes.
	end < (length - 1) ifTrue: [ right := BlRunTreeLeafNode length: length - end - 1 attributes: attributes ].
	(left isNil and: [ right isNil ]) ifTrue: [ ^ middle ].
	left ifNil: [ ^ BlRunTreeNode left: middle right: right ].
	right ifNil: [ ^ BlRunTreeNode left: left right: middle ].
	^ self
		threeLeafSubtreeFromLeft: left
		middle: middle
		right: right
]

{ #category : #accessing }
BlRunTreeLeafNode >> runEndAt: anIndex [
	^length-1
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

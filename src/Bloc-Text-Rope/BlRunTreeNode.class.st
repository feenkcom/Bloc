Class {
	#name : #BlRunTreeNode,
	#superclass : #BlRunTreeAbstractNode,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #'instance creation' }
BlRunTreeNode class >> left: aLeftNode right: aRightNode [
	^ (self new)
		left: aLeftNode;
		right: aRightNode;
		yourself
]

{ #category : #accessing }
BlRunTreeNode >> add: attributes from: start to: end [

	end <= left length
		ifTrue: [ self left: (left add: attributes from: start to: end) ]
		ifFalse: [ 
			start > left length
				ifTrue: [ 
					self right:
						(right
							 add: attributes
							 from: start - left length
							 to: end - left length) ]
				ifFalse: [ 
					self left: (left add: attributes from: start to: left length).
					self right: (right add: attributes from: 1 to: end - left length) ] ].
	^ self coalesceAndBalance
]

{ #category : #accessing }
BlRunTreeNode >> append: attributes withOccurrences: anInteger [
	"coalesce"
	self right: (right append: attributes withOccurrences: anInteger).
	^ self coalesceAndBalance
]

{ #category : #accessing }
BlRunTreeNode >> at: anIndex [
	^ anIndex <= left length ifTrue: [ left at: anIndex ] ifFalse: [ right at: anIndex - left length ]
]

{ #category : #accessing }
BlRunTreeNode >> children [
	^{ left . right }
]

{ #category : #accessing }
BlRunTreeNode >> clearAttributes: start to: end if: aBlock [
	"coalesce"
	end <= left length
		ifTrue:
			[ self
				left:
					(left
						clearAttributes: start
						to: end
						if: aBlock) ]
		ifFalse:
			[ start > left length
				ifTrue:
					[ self
						right:
							(right
								clearAttributes: start - left length
								to: end - left length
								if: aBlock) ]
				ifFalse:
					[ self
						left:
							(left
								clearAttributes: start
								to: left length
								if: aBlock).
					self
						right:
							(right
								clearAttributes: 1
								to: end - left length
								if: aBlock) ] ].
	^ self coalesceAndBalance
]

{ #category : #private }
BlRunTreeNode >> coalesceAndBalance [
	(left isLeaf and: [ right isLeaf and: [ left attributes = right attributes ] ])
		ifTrue: [ ^ BlRunTreeLeafNode length: left length + right length attributes: left attributes ].
	(right isLeaf not and: [ right length > (left length << 1) ]) ifTrue: [ ^ self rotateLeft ].
	(left isLeaf not and: [ left length > (right length << 1) ]) ifTrue: [ ^ self rotateRight ].
	^ self
]

{ #category : #accessing }
BlRunTreeNode >> collectInto: aCollection from: start to: end [
	end <= left length
		ifTrue:
			[ ^ left
				collectInto: aCollection
				from: start
				to: end ].
	start > left length
		ifTrue:
			[ ^ right
				collectInto: aCollection
				from: start - left length
				to: end - left length ].
	left
		collectInto: aCollection
		from: start
		to: left length.
	^ right
		collectInto: aCollection
		from: 1
		to: end - left length
]

{ #category : #accessing }
BlRunTreeNode >> copyFrom: start to: end [
	end <= left length ifTrue: [ ^ left copyFrom: start to: end ].
	start > left length ifTrue: [ ^ right copyFrom: start - left length to: end - left length ].
	^ BlRunTreeNode left: (left copyFrom: start to: left length) right: (right copyFrom: 1 to: end - left length)
]

{ #category : #private }
BlRunTreeNode >> foo [
	#( #[ 1 2 3 56 7 3 5 74 34] 
	#[4 5 6]
	#[7 8 9] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1]
	#[7 8 9] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1] #[1])
]

{ #category : #accessing }
BlRunTreeNode >> height [
	^ 1 + (left height max: right height)
]

{ #category : #accessing }
BlRunTreeNode >> insert: attributes atIndex: anInteger [
	anInteger <= left length
		ifTrue: [ self left: (left copy insert: attributes atIndex: anInteger) ]
		ifFalse: [ self right: (right copy insert: attributes atIndex: anInteger - left length) ].
	^self coalesceAndBalance 
]

{ #category : #accessing }
BlRunTreeNode >> left [

	^ left
]

{ #category : #accessing }
BlRunTreeNode >> left: aNode [
	self assert: aNode notNil description: 'Children cannot be nil'.
	left notNil ifTrue: [length := length - left length].
	length := length + aNode length.
	left := aNode
]

{ #category : #accessing }
BlRunTreeNode >> replaceAllWith: attributes from: start to: end [
	(start = 1 and: [ end = length ]) ifTrue: [ ^ BlRunTreeLeafNode length: end - start + 1 attributes: attributes ].
	end <= left length
		ifTrue:
			[ self
				left:
					(left
						replaceAllWith: attributes
						from: start
						to: end) ]
		ifFalse:
			[ start > left length
				ifTrue:
					[ self
						right:
							(right
								replaceAllWith: attributes
								from: start - left length
								to: end - left length) ]
				ifFalse:
					[ self
						left:
							(left
								replaceAllWith: attributes
								from: start
								to: left length).
					self
						right:
							(right
								replaceAllWith: attributes
								from: 1
								to: end - left length) ] ].
	^ self coalesceAndBalance
]

{ #category : #accessing }
BlRunTreeNode >> right [

	^ right
]

{ #category : #accessing }
BlRunTreeNode >> right: aNode [
	right notNil ifTrue: [length := length - right length].
	length := length + aNode length.
	right := aNode
]

{ #category : #private }
BlRunTreeNode >> rotateLeft [
	| newLeft |
	newLeft := BlRunTreeNode left: left right: right left.
	(newLeft left isLeaf and: [ newLeft right isLeaf and: [ newLeft left attributes = newLeft right attributes ] ])
		ifTrue:
			[ newLeft := BlRunTreeLeafNode length: newLeft left length + newLeft right length attributes: newLeft left attributes ].
	self left: newLeft.
	self right: right right.
	^ self
]

{ #category : #private }
BlRunTreeNode >> rotateRight [
	| newRight |
	newRight := BlRunTreeNode left: left right right: right.
	(newRight left isLeaf and: [ newRight right isLeaf and: [ newRight left attributes = newRight right attributes ] ])
		ifTrue:
			[ newRight := BlRunTreeLeafNode length: newRight left length + newRight right length attributes: newRight left attributes ].
	self right: newRight.
	self left: left left.
	^self
]

{ #category : #accessing }
BlRunTreeNode >> runEndAt: anIndex [

	| end |
	anIndex > left length ifTrue: [ 
		^ left length + (right runEndAt: anIndex - left length) ].
	end := left runEndAt: anIndex.
	"check for split run"
	^ (end = left length and: [ (self at: end) = (self at: end + 1) ])
		  ifTrue: [ 
		  left length + (right runEndAt: anIndex - left length + 1) ]
		  ifFalse: [ end ]
]

{ #category : #enumerating }
BlRunTreeNode >> withOffset: anInteger do: aBlock [
	aBlock value: anInteger value: self.
	left withOffset: anInteger do: aBlock.
	right withOffset: anInteger + left length do: aBlock 
]

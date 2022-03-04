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
BlRunTreeNode >> at: anIndex [
	^ anIndex <= left length ifTrue: [ left at: anIndex ] ifFalse: [ right at: anIndex - left length ]
]

{ #category : #accessing }
BlRunTreeNode >> children [
	^{ left . right }
]

{ #category : #accessing }
BlRunTreeNode >> copyFrom: start to: end [
	end <= left length ifTrue: [ ^ left copyFrom: start to: end ].
	start > left length ifTrue: [ ^ right copyFrom: start - left length to: end - left length ].
	^ BlRunTreeNode left: (left copyFrom: start to: left length) right: (right copyFrom: 1 to: end - left length)
]

{ #category : #accessing }
BlRunTreeNode >> height [
	^ 1 + (left height max: right height)
]

{ #category : #accessing }
BlRunTreeNode >> left [

	^ left
]

{ #category : #accessing }
BlRunTreeNode >> left: aNode [
	left notNil ifTrue: [length := length - left length].
	length := length + aNode length.
	left := aNode
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

{ #category : #accessing }
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

{ #category : #accessing }
BlRunTreeNode >> rotateRight [
	| newRight |
	newRight := BlRunTreeNode left: left right right: right.
	(newRight left isLeaf and: [ newRight right isLeaf and: [ newRight left attributes = newRight right attributes ] ]).
	self right: newRight.
	self left: left left.
	^self
]

{ #category : #accessing }
BlRunTreeNode >> set: attributes from: start to: end [
	(start = 1 and: [ end = length ]) ifTrue: [ ^ BlRunTreeLeafNode length: end - start + 1 attributes: attributes ].
	end <= left length
		ifTrue:
			[ self
				left:
					(left
						set: attributes
						from: start
						to: end) ]
		ifFalse:
			[ start > left length
				ifTrue:
					[ self
						right:
							(right
								set: attributes
								from: start - left length
								to: end - left length) ]
				ifFalse:
					[ self
						left:
							(left
								set: attributes
								from: start
								to: left length).
					self
						right:
							(right
								set: attributes
								from: 1
								to: end - left length) ] ].	"coalesce"
	(left isLeaf and: [ right isLeaf and: [ left attributes = right attributes ] ])
		ifTrue: [ ^ BlRunTreeLeafNode length: left length + right length attributes: attributes ].
	(left isLeaf not and: [ left length > (right length << 1) ]) ifTrue: [ ^ self rotateRight ].
	(right isLeaf not and: [ right length > (left length << 1) ]) ifTrue: [ ^ self rotateLeft].
	^ self
]

{ #category : #enumerating }
BlRunTreeNode >> withOffset: anInteger do: aBlock [
	aBlock value: anInteger value: self.
	left withOffset: anInteger do: aBlock.
	right withOffset: anInteger + left length do: aBlock 
]

"
The Run Tree data structure is used to store the attributes associated with a BLText object.

The basic requirement is that the data structure stores a list of attributes at every index. A naive implementation of this data structure (e.g., OrderedCollection of Arrays) has both storage and performance issues. Since attributed texts typically have sequences of characters with the exact, same attributes, much storage can be saved by storing these as ""Runs"". This is is the approach used by the RunArray data structure in the standard image.

The biggest problem with the RunArray approach is in accessing and modifications. In order to find the corresponding attributes at a given index, the code has to traverse the RunArray from the beginning, calculating the sum of the run lengths. This is O(n) operation, and although the constant is often small, in larger, more complex texts, it can be considerable. Additionally, modification of the structure requires insertion/deletion in the middle of the RunArray which are also, O(n) operations.

The RunTree data structure solves this by using a balanced, binary tree where the leaf nodes are runs of identical attributes, and the internal nodes are binary nodes. All nodes know the length of the text that they represent. By taking this approach, all accesses are O(lg n) and insertions/deletions are also O(lg n). 

The balancing is handled by using a randomized ""Treap."" Every node that is added to the structure receives a random ""priority"". The heap property is maintained by using rotations to move elements with higher priority up the tree. This essentially randomizes the creation of the binary tree, providing a probabilistically balanced tree.


"
Class {
	#name : #BlRunTree,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #accessing }
BlRunTree class >> new: anInteger withAll: anObject [
	^self new setRoot: anInteger withAll: anObject
]

{ #category : #accessing }
BlRunTree >> add: attributes from: start to: end [

	| oldRoot |
	oldRoot := root.
	root := root add: attributes from: start to: end.
	^ oldRoot ~~ root
]

{ #category : #accessing }
BlRunTree >> append: attributes [
	self append: attributes withOccurrences: 1
]

{ #category : #accessing }
BlRunTree >> append: attributes withOccurrences: anInteger [
	root := root append: attributes withOccurrences: anInteger
]

{ #category : #accessing }
BlRunTree >> at: anInd [
	^root at: anInd
]

{ #category : #accessing }
BlRunTree >> clearAttributes: aFromIndex to: aToIndex if: aBlock [
	| oldRoot |
	oldRoot := root.
	root := root clearAttributes: aFromIndex to: aToIndex if: aBlock.
	^oldRoot ~~ root
]

{ #category : #accessing }
BlRunTree >> collectFrom: start to: end [
	^ root
		collectInto: OrderedCollection new
		from: start
		to: end
]

{ #category : #copying }
BlRunTree >> copyFrom: start to: end [
	^ self class new root: (root copyFrom: start to: end)
]

{ #category : #accessing }
BlRunTree >> delete: fromIndex to: toIndex [
	root := root delete: fromIndex to: toIndex
]

{ #category : #accessing }
BlRunTree >> first [
	^self at: 1
]

{ #category : #accessing }
BlRunTree >> gtTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Tree';
		painting: [ :aMondrian | root paintTreeWith: aMondrian ]
]

{ #category : #accessing }
BlRunTree >> height [
	^root height
]

{ #category : #accessing }
BlRunTree >> insertAttributes: attCollection atIndex: anInteger [
	attCollection reverseDo: [:each |
		root := root insert: each atIndex: anInteger]
]

{ #category : #accessing }
BlRunTree >> isEmpty [
	^ self size = 0
]

{ #category : #accessing }
BlRunTree >> notEmpty [
	^ self size > 0
]

{ #category : #accessing }
BlRunTree >> replaceAllWith: attributes from: start to: end [
	root := root replaceAllWith: attributes from: start to: end
]

{ #category : #private }
BlRunTree >> root [
	^root
]

{ #category : #private }
BlRunTree >> root: aNode [
	root := aNode
]

{ #category : #accessing }
BlRunTree >> runEndAt: anIndex [
	^root runEndAt: anIndex
]

{ #category : #accessing }
BlRunTree >> setRoot: anInteger withAll: anObject [
	root := BlRunTreeLeafNode length: anInteger attributes: anObject
]

{ #category : #accessing }
BlRunTree >> size [
	^root length
]

{ #category : #enumerating }
BlRunTree >> withOffsetDo: aBlock [
	root withOffset: 1 do: aBlock
]

{ #category : #enumerating }
BlRunTree >> withStartStopAndValueDo: aBlock [
	root
		withOffset: 0
		do:
			[ :off :node | 
			node isLeaf
				ifTrue:
					[ aBlock
						cull: off
						cull: off + node length - 1
						cull: node attributes ] ]
]

{ #category : #enumerating }
BlRunTree >> withStartStopAndValueDo: aBlock from: start to: end [
	| interval |
	interval := start to: end.
	root
		withOffset: 0
		do: [ :off :node | 
			| nodeInterval |
			nodeInterval := off to: off + node length - 1.
			(interval first <= nodeInterval last
				and: [ interval last >= nodeInterval first and: [ node isLeaf ] ])
				ifTrue: [ aBlock
						cull: (off max: interval first)
						cull: (off + node length - 1 min: interval last)
						cull: node attributes ] ]
]

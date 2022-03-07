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
	root := root add: attributes from: start to: end
]

{ #category : #accessing }
BlRunTree >> at: anInd [
	^root at: anInd
]

{ #category : #accessing }
BlRunTree >> clearAttributes: aFromIndex to: aToIndex if: aBlock [
	root := root clearAttributes: aFromIndex to: aToIndex if: aBlock
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
BlRunTree >> replaceAllWith: attributes from: start to: end [
	root := root replaceAllWith: attributes from: start to: end
]

{ #category : #accessing }
BlRunTree >> replaceWith: attCollection from: start to: end [
	self
		assert: attCollection size
		equals: end - start + 1
		description: 'Collection size must equal range size'.
	root := root
		replaceWith: attCollection
		from: start
		to: end
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

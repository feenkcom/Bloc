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
BlRunTree >> at: anInd [
	^root at: anInd
]

{ #category : #copying }
BlRunTree >> copyFrom: start to: end [
	^ self class new root: (root copyFrom: start to: end)
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

{ #category : #private }
BlRunTree >> root [
	^root
]

{ #category : #private }
BlRunTree >> root: aNode [
	root := aNode
]

{ #category : #accessing }
BlRunTree >> set: attributes from: start to: end [
	root := root set: attributes from: start to: end
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

Class {
	#name : #BlRunTreeNode,
	#superclass : #BlRunTreeAbstractNode,
	#instVars : [
		'left',
		'right',
		'priority'
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

{ #category : #'add / remove' }
BlRunTreeNode >> add: attributes from: start to: end [
	| copy |
	copy := self copy.
	end < left length
		ifTrue:
			[ copy
				left:
					(left
						add: attributes
						from: start
						to: end) ]
		ifFalse:
			[ start >= left length
				ifTrue:
					[ copy
						right:
							(right
								add: attributes
								from: start - left length
								to: end - left length) ]
				ifFalse:
					[ copy
						left:
							(left
								add: attributes
								from: start
								to: left length-1).
					copy
						right:
							(right
								add: attributes
								from: 0
								to: end - left length) ] ].
	^ copy coalesceAndBalance
]

{ #category : #'add / remove' }
BlRunTreeNode >> append: attributes withOccurrences: anInteger [
	"coalesce"
	| copy |
	copy := self copy.
	copy right: (right append: attributes withOccurrences: anInteger).
	^ copy coalesceAndBalance
]

{ #category : #accessing }
BlRunTreeNode >> at: anIndex [
	^ anIndex < left length ifTrue: [ left at: anIndex ] ifFalse: [ right at: anIndex - left length ]
]

{ #category : #accessing }
BlRunTreeNode >> children [
	^{ left . right }
]

{ #category : #'add / remove' }
BlRunTreeNode >> clearAttributes: start to: end if: aBlock [
	"coalesce"
	| copy |
	copy := self copy.
	end < left length
		ifTrue:
			[ copy
				left:
					(left
						clearAttributes: start
						to: end
						if: aBlock) ]
		ifFalse:
			[ start > left length
				ifTrue:
					[ copy
						right:
							(right
								clearAttributes: start - left length
								to: end - left length
								if: aBlock) ]
				ifFalse:
					[ copy
						left:
							(left
								clearAttributes: start
								to: left length - 1
								if: aBlock).
					copy
						right:
							(right
								clearAttributes: 0
								to: end - left length
								if: aBlock) ] ].
	^ copy coalesceAndBalance
]

{ #category : #private }
BlRunTreeNode >> coalesceAndBalance [
	left length isZero ifTrue: [ ^ right ].
	right length isZero ifTrue: [ ^ left ].
	(left isLeaf and: [ right isLeaf and: [ left attributes = right attributes ] ])
		ifTrue: [ ^ BlRunTreeLeafNode length: left length + right length attributes: left attributes ].
	right priority > priority ifTrue: [ ^ self rotateLeft ].
	left priority > priority ifTrue: [ ^ self rotateRight ].
	^ self
]

{ #category : #accessing }
BlRunTreeNode >> collectInto: aCollection from: start to: end [
	end < left length
		ifTrue:
			[ ^ left
				collectInto: aCollection
				from: start
				to: end ].
	start >= left length
		ifTrue:
			[ ^ right
				collectInto: aCollection
				from: start - left length
				to: end - left length ].
	left
		collectInto: aCollection
		from: start
		to: left length-1.
	^ right
		collectInto: aCollection
		from: 0
		to: end - left length
]

{ #category : #copying }
BlRunTreeNode >> copyFrom: start to: end [

	end < left length ifTrue: [ ^ left copyFrom: start to: end ].
	start >= left length ifTrue: [ 
		^ right copyFrom: start - left length to: end - left length ].
	^ (BlRunTreeNode
		   left: (left copyFrom: start to: left length-1)
		   right: (right copyFrom: 0 to: end - left length))
		  priority: priority;
		  yourself
]

{ #category : #'add / remove' }
BlRunTreeNode >> delete: start to: end [
	| copy |
	copy := self copy.
	end < left length
		ifTrue: [ copy left: (left delete: start to: end) ]
		ifFalse:
			[ start >= left length
				ifTrue: [ copy right: (right delete: start - left length to: end - left length) ]
				ifFalse:
					[ copy right: (right delete: 0 to: end - left length).
					copy left: (left delete: start to: left length - 1) ] ].
	^ copy coalesceAndBalance
]

{ #category : #accessing }
BlRunTreeNode >> height [
	^ 1 + (left height max: right height)
]

{ #category : #accessing }
BlRunTreeNode >> initialize [
	"Assign random priority for heap balancing algorithm"
	super initialize.
	priority := SharedRandom globalGenerator next.
]

{ #category : #'add / remove' }
BlRunTreeNode >> insert: attributes atIndex: anInteger [

	| copy |
	copy := self copy.
	anInteger < left length
		ifTrue: [ copy left: (left insert: attributes atIndex: anInteger) ]
		ifFalse: [ 
			copy right:
				(right insert: attributes atIndex: anInteger - left length) ].
	^ copy coalesceAndBalance
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
BlRunTreeNode >> priority [
	^priority
]

{ #category : #accessing }
BlRunTreeNode >> priority: anInteger [
	priority := anInteger
]

{ #category : #'add / remove' }
BlRunTreeNode >> replaceAllWith: attributes from: start to: end [
	| copy |
	copy := self copy.
	(start = 0 and: [ end = (length - 1) ]) ifTrue: [ ^ BlRunTreeLeafNode length: end - start + 1 attributes: attributes ].
	end < left length
		ifTrue:
			[ copy
				left:
					(left
						replaceAllWith: attributes
						from: start
						to: end) ]
		ifFalse:
			[ start >= left length
				ifTrue:
					[ copy
						right:
							(right
								replaceAllWith: attributes
								from: start - left length
								to: end - left length) ]
				ifFalse:
					[ copy
						left:
							(left
								replaceAllWith: attributes
								from: start
								to: left length-1).
					copy
						right:
							(right
								replaceAllWith: attributes
								from: 0
								to: end - left length) ] ].
	^ copy coalesceAndBalance
]

{ #category : #accessing }
BlRunTreeNode >> right [

	^ right
]

{ #category : #accessing }
BlRunTreeNode >> right: aNode [
	self assert: aNode notNil description: 'Children cannot be nil'.
	right notNil ifTrue: [length := length - right length].
	length := length + aNode length.
	right := aNode
]

{ #category : #private }
BlRunTreeNode >> rotateLeft [
	| newLeft |
	newLeft := BlRunTreeNode left: left right: right left.
	newLeft priority: priority.
	priority := right priority.
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
	newRight priority: priority.
	priority := left priority.
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
	anIndex >= left length ifTrue: [ ^ left length + (right runEndAt: anIndex - left length) ].
	end := left runEndAt: anIndex.	"check for split run"
	^ (end = (left length - 1) and: [ (self at: end) = (self at: end + 1) ])
		ifTrue: [ left length + (right runEndAt: anIndex - left length) ]
		ifFalse: [ end ]
]

{ #category : #enumerating }
BlRunTreeNode >> withOffset: anInteger do: aBlock [
	aBlock value: anInteger value: self.
	left withOffset: anInteger do: aBlock.
	right withOffset: anInteger + left length do: aBlock 
]

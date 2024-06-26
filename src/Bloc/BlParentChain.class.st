Class {
	#name : #BlParentChain,
	#superclass : #DoubleLinkedList,
	#category : 'Bloc-Space - Support'
}

{ #category : #'instance creation' }
BlParentChain class >> of: anElement [
	| aChain |
	
	aChain := self new.
	anElement withAllParentsDo: [ :aParent |
		aChain addFirst: aParent ].

	^ aChain
]

{ #category : #'instance creation' }
BlParentChain class >> of: anElement upToExclusive: aParentElement [
	| aChain |
	
	aChain := self new.
	anElement
		withAllParentsDo: [ :aParent |
			aParent = aParentElement
				ifTrue: [ ^ aChain ].
			aChain addFirst: aParent ].
	^ aChain
]

{ #category : #'instance creation' }
BlParentChain class >> of: anElement upToInclusive: aParentElement [
	| aChain |
	
	aChain := self new.
	anElement
		withAllParentsDo: [ :aParent |
			aChain addFirst: aParent.
			aParent = aParentElement
				ifTrue: [ ^ aChain ]. ].
	^ aChain
]

{ #category : #'as yet unclassified' }
BlParentChain >> gtInspectorElementsIn: aComposite [
	<gtInspectorPresentationOrder: 10>
	
	^ aComposite fastList
		title: 'Elements';
		display: [ self asArray ]
]

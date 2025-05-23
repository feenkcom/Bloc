"
I am a composite text selection consisting of multiple independent non-overlapping monotone text selections

"
Class {
	#name : #BlCompositeSelection,
	#superclass : #BlSelection,
	#instVars : [
		'selections'
	],
	#category : #'Bloc-Utilities - Selection'
}

{ #category : #'instance creation' }
BlCompositeSelection class >> fromIndices: aCollectionOfIndices [
	| aBlSelection |
	
	aBlSelection := self new.
	aCollectionOfIndices do: [ :eachIndex |
		aBlSelection select: eachIndex - 1 to: eachIndex ].
	
	^ aBlSelection
]

{ #category : #comparing }
BlCompositeSelection >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].

	^ self selections = anObject selections
]

{ #category : #'private - adding / removing' }
BlCompositeSelection >> add: aMonotoneTextSelection [
	selections insert: aMonotoneTextSelection
]

{ #category : #accessing }
BlCompositeSelection >> children [
	<return: #Collection of: #BlSelection>
	
	^ #()
]

{ #category : #'api - testing' }
BlCompositeSelection >> contains: anIndex [
	"Return true if this selection interval includes a given index, false otherwise"
	<return: #Boolean>
	
	^ selections contains: anIndex
]

{ #category : #'api - testing' }
BlCompositeSelection >> containsIndex: anIndex [
	"Return true if selection indices include a given index, false otherwise.
	I am conceptually same as (self indices includes: anIndex)"
	<return: #Boolean>
	
	^ selections containsIndex: anIndex
]

{ #category : #copying }
BlCompositeSelection >> copyFrom: aStartIndex to: anEndIndex [
	| aNewSelection |
	
	aNewSelection := self class new.
	self do: [ :eachMonotoneSelection |
		aNewSelection select: (eachMonotoneSelection copyFrom: aStartIndex to: anEndIndex) ].
	
	^ aNewSelection
]

{ #category : #'api - selection' }
BlCompositeSelection >> deselect: aSelection [
	"Remove a given selection"

	aSelection do: [ :aMonotoneSelection | self remove: aMonotoneSelection ]
]

{ #category : #'api - selection' }
BlCompositeSelection >> deselect: aFromIndex to: aToIndex [
	"Remove a monotone selection within provided indices"
	
	self remove: (BlSelection from: aFromIndex to: aToIndex)
]

{ #category : #'api - enumerating' }
BlCompositeSelection >> do: aBlock [
	selections do: aBlock
]

{ #category : #'api - accessing' }
BlCompositeSelection >> from [
	"Return the minimum selected index which is the `from` index of the first sub-selection"
	<return: #Number>

	^ selections first selection from
]

{ #category : #printing }
BlCompositeSelection >> gtDisplayOn: aStream [
	self printOn: aStream
]

{ #category : #views }
BlCompositeSelection >> gtSelectionsFor: aView [
	<gtView>
	^ aView forward
		title: 'Selections';
		priority: 5;
		object: [ selections ];
		view: #gtSelectionsFor:
]

{ #category : #comparing }
BlCompositeSelection >> hash [
	^ self class hash bitXor: self selections hash
]

{ #category : #initialization }
BlCompositeSelection >> initialize [
	super initialize.
	
	selections := BlSelectionTree new
]

{ #category : #'api - testing' }
BlCompositeSelection >> isEmpty [
	^ selections isEmpty
]

{ #category : #'api - testing' }
BlCompositeSelection >> isNotEmpty [
	^ selections isNotEmpty
]

{ #category : #copying }
BlCompositeSelection >> postCopy [
	selections := selections copy
]

{ #category : #printing }
BlCompositeSelection >> printOn: aStream [
	selections printOn: aStream
]

{ #category : #'private - adding / removing' }
BlCompositeSelection >> remove: aMonotoneTextSelection [
	selections delete: aMonotoneTextSelection
]

{ #category : #'private - adding / removing' }
BlCompositeSelection >> removeAll [
	selections := BlSelectionTree new
]

{ #category : #'api - enumerating' }
BlCompositeSelection >> reverseDo: aBlock [
	"Evaluate a given block with all recorded selection intervals in reverse direction"

	selections reverseDo: aBlock
]

{ #category : #'api - selection' }
BlCompositeSelection >> select: aSelection [
	"Add a given selection"

	aSelection do: [ :aMonotoneSelection | self add: aMonotoneSelection ]
]

{ #category : #'api - selection' }
BlCompositeSelection >> select: aFromIndex to: aToIndex [
	"Add a new monotone selection merging it with existing ones within provided indices"
	
	self add: (BlSelection from: aFromIndex to: aToIndex)
]

{ #category : #accessing }
BlCompositeSelection >> selections [
	<return: #BlSelectionTree>

	^ selections
]

{ #category : #'api - accessing' }
BlCompositeSelection >> to [
	"Return the maximum selected index which is the `to` index of the last sub-selection"
	<return: #Number>

	^ selections last selection to
]

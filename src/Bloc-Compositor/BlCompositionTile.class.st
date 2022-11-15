Class {
	#name : #BlCompositionTile,
	#superclass : #Object,
	#instVars : [
		'column',
		'row',
		'zoomLevel',
		'extent',
		'localExtent'
	],
	#category : #'Bloc-Compositor-Tiles'
}

{ #category : #comparing }
BlCompositionTile >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ zoomLevel = anObject zoomLevel
		and: [ row = anObject row and: [ column = anObject column ] ]
]

{ #category : #accessing }
BlCompositionTile >> bounds [
	| left top |
	
	left := (self column < 0
		ifTrue: [ self column ]
		ifFalse: [ self column - 1 ]).

	top := (self row < 0
		ifTrue: [ self row ]
		ifFalse: [ self row - 1 ]).

	^ (left @ top) * self extent extent: self extent
]

{ #category : #accessing }
BlCompositionTile >> column [

	^ column
]

{ #category : #accessing }
BlCompositionTile >> column: anObject [

	column := anObject
]

{ #category : #accessing }
BlCompositionTile >> extent [

	^ extent
]

{ #category : #accessing }
BlCompositionTile >> extent: anObject [

	extent := anObject
]

{ #category : #comparing }
BlCompositionTile >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ zoomLevel hash bitXor: (row hash bitXor: column hash)
]

{ #category : #accessing }
BlCompositionTile >> localExtent [

	^ localExtent
]

{ #category : #accessing }
BlCompositionTile >> localExtent: anObject [

	localExtent := anObject
]

{ #category : #accessing }
BlCompositionTile >> row [

	^ row
]

{ #category : #accessing }
BlCompositionTile >> row: anObject [

	row := anObject
]

{ #category : #accessing }
BlCompositionTile >> zoomLevel [

	^ zoomLevel
]

{ #category : #accessing }
BlCompositionTile >> zoomLevel: anObject [

	zoomLevel := anObject
]

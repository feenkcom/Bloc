Class {
	#name : #BlCompositionTile,
	#superclass : #Object,
	#instVars : [
		'column',
		'row',
		'extent'
	],
	#category : #'Bloc-Compositor-Tiles'
}

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

{ #category : #accessing }
BlCompositionTile >> row [

	^ row
]

{ #category : #accessing }
BlCompositionTile >> row: anObject [

	row := anObject
]

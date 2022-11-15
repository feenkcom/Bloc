Class {
	#name : #BlCompositionTileFigure,
	#superclass : #Object,
	#instVars : [
		'offset',
		'extent',
		'picture'
	],
	#category : #'Bloc-Compositor-Tiles'
}

{ #category : #accessing }
BlCompositionTileFigure >> bounds [
	^ self offset extent: self extent
]

{ #category : #accessing }
BlCompositionTileFigure >> extent [

	^ extent
]

{ #category : #accessing }
BlCompositionTileFigure >> extent: anObject [

	extent := anObject
]

{ #category : #accessing }
BlCompositionTileFigure >> offset [

	^ offset
]

{ #category : #accessing }
BlCompositionTileFigure >> offset: anObject [

	offset := anObject
]

{ #category : #accessing }
BlCompositionTileFigure >> picture [

	^ picture
]

{ #category : #accessing }
BlCompositionTileFigure >> picture: anObject [

	picture := anObject
]

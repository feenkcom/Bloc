Class {
	#name : #BlCompositionTileScaleFactor,
	#superclass : #Object,
	#instVars : [
		'scaleFactor'
	],
	#category : #'Bloc-Compositor-Tiles'
}

{ #category : #accessing }
BlCompositionTileScaleFactor class >> label [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlCompositionTileScaleFactor class >> scale: aFloat [
	^ self new scale: aFloat
]

{ #category : #printing }
BlCompositionTileScaleFactor >> gtDisplayOn: aStream [
	aStream
		nextPutAll: self class label;
		nextPut: $:;
		space;
		print: self scale;
		nextPut: $,;
		space;
		nextPutAll: 'zoom level';
		nextPut: $:;
		space;
		print: self zoomLevel
]

{ #category : #'api - zooming' }
BlCompositionTileScaleFactor >> scale [
	^ scaleFactor
]

{ #category : #'api - zooming' }
BlCompositionTileScaleFactor >> scale: aFloat [
	scaleFactor := aFloat
]

{ #category : #'api - zooming' }
BlCompositionTileScaleFactor >> zoomLevel [
	"Return a zoom level represented as a fraction with integer denominator.
	For example, zoom level of (1 / 4) means that we the scene is zoomed out 4 times.
	Contrarily, zoom level of (4 / 1) means that the scene is zoomed in 4 times."
	<return: #Fraction>

	^ self subclassResponsibility
]

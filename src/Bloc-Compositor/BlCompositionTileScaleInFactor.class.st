Class {
	#name : #BlCompositionTileScaleInFactor,
	#superclass : #BlCompositionTileScaleFactor,
	#category : #'Bloc-Compositor-Tiles'
}

{ #category : #accessing }
BlCompositionTileScaleInFactor class >> label [
	^ 'Scale in'
]

{ #category : #'api - zooming' }
BlCompositionTileScaleInFactor >> zoomLevel [
	"Return a zoom level represented as a fraction with integer denominator.
	For example, zoom level of (1 / 4) means that we the scene is zoomed out 4 times.
	Contrarily, zoom level of (4 / 1) means that the scene is zoomed in 4 times."
	<return: #Fraction>

	^ scaleFactor >= 1
		ifTrue: [ scaleFactor floor asFraction ]
		ifFalse: [ 1 / (1 / scaleFactor) ceiling ]
]

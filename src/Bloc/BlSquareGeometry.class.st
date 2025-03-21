Class {
	#name : #BlSquareGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'length',
		'origin'
	],
	#category : #'Bloc-Core-Geometries'
}

{ #category : #'geometry testing' }
BlSquareGeometry >> containsPoint: aPoint in: aBlElement [
	^ (self geometryBounds: BlBounds new) containsPoint: aPoint
]

{ #category : #'geometry bounds' }
BlSquareGeometry >> geometryBounds: aBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>

	^ aBounds
		origin: self origin
		extent: (self length * 2.0) asPoint
]

{ #category : #accessing }
BlSquareGeometry >> length [
	^ length
]

{ #category : #geometry }
BlSquareGeometry >> matchExtent: anExtent [
	length := anExtent min / 2.0.
	origin := (anExtent - anExtent min asPoint) / 2.0.

	self extent: anExtent
]

{ #category : #accessing }
BlSquareGeometry >> origin [
	^ origin
]

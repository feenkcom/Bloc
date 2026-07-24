"
Geometry that consists of multiple polylines whose coordinates are normalized [0..1] which makes the geometry to scale with an element.
"
Class {
	#name : #BlNormalizedMultiPolylineGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'polylines'
	],
	#category : #'Bloc-Core-Geometries'
}

{ #category : #accessing }
BlNormalizedMultiPolylineGeometry class >> polylines: aCollectionOfCollectionOfPoints [
	^ self new polylines: aCollectionOfCollectionOfPoints
]

{ #category : #initialization }
BlNormalizedMultiPolylineGeometry >> initialize [
	super initialize.
	
	polylines := #()
]

{ #category : #geometry }
BlNormalizedMultiPolylineGeometry >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : #accessing }
BlNormalizedMultiPolylineGeometry >> polylines [
	^ polylines
]

{ #category : #accessing }
BlNormalizedMultiPolylineGeometry >> polylines: anObject [
	polylines := anObject
]

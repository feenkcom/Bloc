Class {
	#name : #BlMultiPolylineGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'polylines'
	],
	#category : #'Bloc-Core-Geometries'
}

{ #category : #'instance creation' }
BlMultiPolylineGeometry class >> polylines: aCollectionOfCollectionOfPoints [
	^ self new polylines: aCollectionOfCollectionOfPoints
]

{ #category : #geometry }
BlMultiPolylineGeometry >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #accessing }
BlMultiPolylineGeometry >> polylines [
	^ polylines
]

{ #category : #accessing }
BlMultiPolylineGeometry >> polylines: aCollectionOfPolylines [
	polylines := aCollectionOfPolylines.
	
	extent := self polylines
		ifEmpty: [ 0@0 ]
		ifNotEmpty: [ :thePolyline | (thePolyline detectMax: [ :eachPolyline | eachPolyline max ]) max ]
]

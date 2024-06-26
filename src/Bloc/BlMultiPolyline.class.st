Class {
	#name : #BlMultiPolyline,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'polylines'
	],
	#category : 'Bloc-Basic'
}

{ #category : #'instance creation' }
BlMultiPolyline class >> polylines: aCollectionOfCollectionOfPoints [
	^ self new polylines: aCollectionOfCollectionOfPoints
]

{ #category : #geometry }
BlMultiPolyline >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #accessing }
BlMultiPolyline >> polylines [
	^ polylines
]

{ #category : #accessing }
BlMultiPolyline >> polylines: aCollectionOfPolylines [
	polylines := aCollectionOfPolylines.
	
	extent := self polylines
		ifEmpty: [ 0@0 ]
		ifNotEmpty: [ :thePolyline | (thePolyline detectMax: [ :eachPolyline | eachPolyline max ]) max ]
]

"
Example:

BlPolygon vertices: { 
	10@50.
	50@20.
	150@40.
	180@150.
	80@140
}

"
Class {
	#name : #BlPolygon,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'vertices'
	],
	#category : 'Bloc-Basic'
}

{ #category : #'instance creation' }
BlPolygon class >> vertices: aCollection [
	^ self new vertices: aCollection
]

{ #category : #'geometry bounds' }
BlPolygon >> geometryBounds: aBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>

	^ aBounds
		origin: self vertices min
		corner: self vertices max
]

{ #category : #geometry }
BlPolygon >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #accessing }
BlPolygon >> vertices [
	<return: #SequenceableCollection of: #Point>

	^ vertices
]

{ #category : #accessing }
BlPolygon >> vertices: aCollectionOfPoints [
	| theNewVertices |
	theNewVertices := aCollectionOfPoints collect: [ :eachPoint | eachPoint asFloatPoint ].
	
	theNewVertices = vertices
		ifTrue: [ ^ self ].
	
	vertices := theNewVertices.
	extent := vertices max.
	self releaseCache
]

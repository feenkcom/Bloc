Class {
	#name : #BlCircleGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'radius',
		'origin'
	],
	#category : #'Bloc-Core-Geometries'
}

{ #category : #comparing }
BlCircleGeometry >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #'geometry bounds' }
BlCircleGeometry >> geometryBounds: aBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>

	^ aBounds
		origin: self origin
		extent: (self radius * 2.0) asPoint
]

{ #category : #comparing }
BlCircleGeometry >> hash [
	^ self class hash
]

{ #category : #initialization }
BlCircleGeometry >> initialize [
	super initialize.
	
	radius := 0.
	origin := 0@0
]

{ #category : #geometry }
BlCircleGeometry >> matchExtent: anExtent [
	radius := anExtent min / 2.0.
	origin := (anExtent - anExtent min asPoint) / 2.0.

	self extent: anExtent
]

{ #category : #accessing }
BlCircleGeometry >> origin [
	^ origin
]

{ #category : #accessing }
BlCircleGeometry >> radius [
	^ radius
]

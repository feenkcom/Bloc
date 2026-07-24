Class {
	#name : #BlHostSurfaceRenderer,
	#superclass : #Object,
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #initialization }
BlHostSurfaceRenderer >> initializeSurface: aSurface [
	self subclassResponsibility
]

{ #category : #rendering }
BlHostSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	"Render a given surface on a host space"

	self subclassResponsibility
]

{ #category : #initialization }
BlHostSurfaceRenderer >> resizeSurface: aSurface [
	self initializeSurface: aSurface
]

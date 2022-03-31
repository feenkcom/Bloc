Class {
	#name : #BlWinitMetalSurfaceRenderer,
	#superclass : #BlWinitSurfaceRenderer,
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #initialization }
BlWinitMetalSurfaceRenderer >> initializeForSurface: aMetalSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	aMetalSurface
		nsView: window nsView;
		extent: aMetalSurface physicalSize asPoint
]

{ #category : #rendering }
BlWinitMetalSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	"window requestRedraw"
]

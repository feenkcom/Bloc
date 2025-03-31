Class {
	#name : #BlWinitWaylandSurfaceRenderer,
	#superclass : #BlWinitSurfaceRenderer,
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #initialization }
BlWinitWaylandSurfaceRenderer >> initializeForSurface: aWaylandSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	Smalltalk vm isRunningInWorkerThread
		ifTrue: [
			aWaylandSurface callbackRegistry: window blocCreateCallbackRegistry ].

	aWaylandSurface
		waylandDisplay: window waylandDisplay;
		waylandSurface: window waylandSurface;
		extent: aWaylandSurface physicalSize asPoint
]

{ #category : #rendering }
BlWinitWaylandSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	aSurface callbackRegistry isNullRegistry
		ifTrue: [ ^ self ].

	window requestRedraw
]

{ #category : #initialization }
BlWinitWaylandSurfaceRenderer >> resizeForSurface: aWaylandSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	aWaylandSurface extent: aWaylandSurface physicalSize asPoint
]

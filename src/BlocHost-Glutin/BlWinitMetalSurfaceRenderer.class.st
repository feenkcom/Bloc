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

	Smalltalk vm isRunningInWorkerThread
		ifTrue: [
			aMetalSurface callbackRegistry: (BlWinitSurfaceCallbackRegistry new
				eventLoop: window eventLoop;
				windowId: window primGetRawId) ].

	aMetalSurface
		nsView: window nsView;
		extent: aMetalSurface physicalSize asPoint
]

{ #category : #rendering }
BlWinitMetalSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	aSurface callbackRegistry isNullRegistry
		ifTrue: [ ^ self ].

	window requestRedraw
]

{ #category : #initialization }
BlWinitMetalSurfaceRenderer >> resizeForSurface: aMetalSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	aMetalSurface extent: aMetalSurface physicalSize asPoint
]

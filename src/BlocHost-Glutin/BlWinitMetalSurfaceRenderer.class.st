Class {
	#name : #BlWinitMetalSurfaceRenderer,
	#superclass : #BlWinitSurfaceRenderer,
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #initialization }
BlWinitMetalSurfaceRenderer >> initializeSurface: aMetalSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	Smalltalk vm isRunningInWorkerThread
		ifTrue: [
			aMetalSurface callbackRegistry: window blocCreateCallbackRegistry ].

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
BlWinitMetalSurfaceRenderer >> resizeSurface: aMetalSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	aMetalSurface extent: aMetalSurface physicalSize asPoint
]

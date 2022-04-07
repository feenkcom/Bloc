Class {
	#name : #BlWinitDirect3DSurfaceRenderer,
	#superclass : #BlWinitSurfaceRenderer,
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #initialization }
BlWinitDirect3DSurfaceRenderer >> initializeForSurface: aDirect3DSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	Smalltalk vm isRunningInWorkerThread
		ifTrue: [
			aDirect3DSurface callbackRegistry: (BlWinitSurfaceCallbackRegistry new
				eventLoop: window eventLoop;
				windowId: window primGetRawId) ].

	aDirect3DSurface
		windowHWND: window hwnd;
		extent: aDirect3DSurface physicalSize asPoint
]

{ #category : #rendering }
BlWinitDirect3DSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	aSurface callbackRegistry isNullRegistry
		ifTrue: [ ^ self ].

	window requestRedraw
]

{ #category : #initialization }
BlWinitDirect3DSurfaceRenderer >> resizeForSurface: aDirect3DSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	aDirect3DSurface extent: aDirect3DSurface physicalSize asPoint
]

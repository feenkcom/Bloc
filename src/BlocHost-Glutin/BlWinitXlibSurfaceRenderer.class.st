Class {
	#name : #BlWinitXlibSurfaceRenderer,
	#superclass : #BlWinitSurfaceRenderer,
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #initialization }
BlWinitXlibSurfaceRenderer >> initializeForSurface: anXlibSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	Smalltalk vm isRunningInWorkerThread
		ifTrue: [
			anXlibSurface callbackRegistry: window blocCreateCallbackRegistry ].

	anXlibSurface
		xlibDisplay: window xlibDisplay;
		xlibWindow: window xlibWindow;
		extent: anXlibSurface physicalSize asPoint
]

{ #category : #rendering }
BlWinitXlibSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	aSurface callbackRegistry isNullRegistry
		ifTrue: [ ^ self ].

	window requestRedraw
]

{ #category : #initialization }
BlWinitXlibSurfaceRenderer >> resizeForSurface: anXlibSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	anXlibSurface extent: anXlibSurface physicalSize asPoint
]

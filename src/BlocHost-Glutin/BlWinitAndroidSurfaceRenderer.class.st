Class {
	#name : #BlWinitAndroidSurfaceRenderer,
	#superclass : #BlWinitSurfaceRenderer,
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #initialization }
BlWinitAndroidSurfaceRenderer >> initializeSurface: anAndroidSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	Smalltalk vm isRunningInWorkerThread
		ifTrue: [
			anAndroidSurface callbackRegistry: window blocCreateCallbackRegistry ].

	anAndroidSurface
		nativeWindow: window androidNativeWindow;
		extent: anAndroidSurface physicalSize asPoint
]

{ #category : #rendering }
BlWinitAndroidSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	aSurface callbackRegistry isNullRegistry
		ifTrue: [ ^ self ].

	window requestRedraw
]

{ #category : #initialization }
BlWinitAndroidSurfaceRenderer >> resizeSurface: anAndroidSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	anAndroidSurface extent: anAndroidSurface physicalSize asPoint
]

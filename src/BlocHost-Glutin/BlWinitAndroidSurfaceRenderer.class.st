Class {
	#name : #BlWinitAndroidSurfaceRenderer,
	#superclass : #BlWinitSurfaceRenderer,
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #initialization }
BlWinitAndroidSurfaceRenderer >> initializeForSurface: anAndroidSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	Smalltalk vm isRunningInWorkerThread
		ifTrue: [
			anAndroidSurface callbackRegistry: window blocCreateCallbackRegistry ].

	anAndroidSurface
		nativeWindow: self primitiveGetAndroidNativeWindow;
		extent: anAndroidSurface physicalSize asPoint
]

{ #category : #'private - primitives' }
BlWinitAndroidSurfaceRenderer >> primitiveGetAndroidNativeWindow [
	<primitive: 'primitiveGetAndroidNativeWindow'>
	
	^ ExternalAddress null
]

{ #category : #rendering }
BlWinitAndroidSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	aSurface callbackRegistry isNullRegistry
		ifTrue: [ ^ self ].

	window requestRedraw
]

{ #category : #initialization }
BlWinitAndroidSurfaceRenderer >> resizeForSurface: anAndroidSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	anAndroidSurface extent: anAndroidSurface physicalSize asPoint
]

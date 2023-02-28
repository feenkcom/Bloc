Class {
	#name : #BlSpartaAndroidCompositorSpaceRenderer,
	#superclass : #BlSkiaCompositorSpaceRenderer,
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #initialization }
BlSpartaAndroidCompositorSpaceRenderer >> createCompositor: anAndroidSurface [
	^ SkiaCompositorPlatform
		forAndroid: anAndroidSurface nativeWindow
		extent: anAndroidSurface extent
]

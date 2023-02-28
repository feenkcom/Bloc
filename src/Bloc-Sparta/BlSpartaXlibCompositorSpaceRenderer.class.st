Class {
	#name : #BlSpartaXlibCompositorSpaceRenderer,
	#superclass : #BlSkiaCompositorSpaceRenderer,
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #initialization }
BlSpartaXlibCompositorSpaceRenderer >> createCompositor: anXlibSurface [
	^ SkiaCompositorPlatform
		forXlibDisplay: anXlibSurface xlibDisplay
		window: anXlibSurface xlibWindow
		extent: anXlibSurface extent
]

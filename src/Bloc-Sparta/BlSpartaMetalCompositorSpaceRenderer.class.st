Class {
	#name : #BlSpartaMetalCompositorSpaceRenderer,
	#superclass : #BlSkiaCompositorSpaceRenderer,
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #initialization }
BlSpartaMetalCompositorSpaceRenderer >> createCompositor: aMetalSurface [
	^ SkiaCompositorPlatform
		forMetal: aMetalSurface nsView
		extent: aMetalSurface extent
]

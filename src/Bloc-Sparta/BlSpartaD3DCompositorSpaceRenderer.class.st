Class {
	#name : #BlSpartaD3DCompositorSpaceRenderer,
	#superclass : #BlSkiaCompositorSpaceRenderer,
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #initialization }
BlSpartaD3DCompositorSpaceRenderer >> createCompositor: aD3DSurface [
	^ SkiaCompositorPlatform
		forAngle: aD3DSurface windowHWND
		extent: aD3DSurface extent
]

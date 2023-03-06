Class {
	#name : #BlSpartaWaylandCompositorSpaceRenderer,
	#superclass : #BlSkiaCompositorSpaceRenderer,
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #initialization }
BlSpartaWaylandCompositorSpaceRenderer >> createCompositor: aWaylandSurface [
	 ^ SkiaCompositorPlatform
		forWaylandDisplay: aWaylandSurface waylandDisplay
		surface: aWaylandSurface waylandSurface
		extent: aWaylandSurface extent
]

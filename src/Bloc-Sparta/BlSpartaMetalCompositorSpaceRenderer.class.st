Class {
	#name : #BlSpartaMetalCompositorSpaceRenderer,
	#superclass : #BlSpartaHardwareAcceleratedSpaceRenderer,
	#instVars : [
		'compositor',
		'hasCallbacks'
	],
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #initialization }
BlSpartaMetalCompositorSpaceRenderer >> initializeForSurface: aMetalSurface [
	"Initalize sparta canvas to be used with a given surface"
	| aSpartaCanvas |
	
	BlSpartaSpaceRendererInitializeSignal emit.

	aSpartaCanvas := SkiaCanvas offscreen.

	compositor := SkiaCompositorMetal forNSView: aMetalSurface nsView extent: aMetalSurface extent.

	hasCallbacks := aMetalSurface callbackRegistry isNullRegistry not.
	hasCallbacks ifTrue: [
		aMetalSurface callbackRegistry
			onDrawCall: (FFIBackend current
				loadSymbol: #skia_metal_compositor_draw
				module: SkiaLibrary uniqueInstance libraryName)
			with: compositor;
			onResizeCall: (FFIBackend current
				loadSymbol: #skia_metal_compositor_resize
				module: SkiaLibrary uniqueInstance libraryName)
			with: compositor ].

	self
		initializeCanvas: aSpartaCanvas
		surface: aMetalSurface
]

{ #category : #rendering }
BlSpartaMetalCompositorSpaceRenderer >> renderSpace: aSpace [
	"Render a space and return a collection of damaged rectangles"
	<return: #Collection of: #Rectangle>
	
	self isValid
		ifFalse: [ ^ self ].
	
	BlFrameTelemetry
		timeSync: 'Render space'
		during: [
			| skiaLayer aRootLayer aScaledSkiaLayer |

			aRootLayer := BlCompositionPainter repaintSpace: aSpace.
			BlFrameTelemetry
				timeSync: 'As Skia layer'
				during: [ skiaLayer := aRootLayer asSkiaLayer ].				
			aRootLayer cleanNeedsCompositionFromAllLayers.

			aScaledSkiaLayer := (SkiaCompositionTransformationLayer matrix: (SpartaMatrix scale: scaleFactor asPoint))
				withLayers: (Array with: skiaLayer).

			BlFrameTelemetry
				timeSync: 'Submit layer to the Metal compositor'
				during: [
					compositor submitLayer: aScaledSkiaLayer.
					hasCallbacks ifFalse: [ compositor draw ] ] ].

	^ (self damagedAreasOf: aSpace)
]

{ #category : #initialization }
BlSpartaMetalCompositorSpaceRenderer >> resizeForSurface: aMetalSurface [
	"The metal compositor is resized automatically via event loop callbacks"
	
	hasCallbacks
		ifTrue: [ ^ self ].
		
	compositor resize: aMetalSurface extent
]

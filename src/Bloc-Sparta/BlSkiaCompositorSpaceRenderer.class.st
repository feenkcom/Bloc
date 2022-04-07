Class {
	#name : #BlSkiaCompositorSpaceRenderer,
	#superclass : #BlSpartaHardwareAcceleratedSpaceRenderer,
	#instVars : [
		'compositor',
		'hasCallbacks'
	],
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #initialization }
BlSkiaCompositorSpaceRenderer >> createCompositor: aSurface [
	^ self subclassResponsibility
]

{ #category : #initialization }
BlSkiaCompositorSpaceRenderer >> initializeForSurface: aSurface [
	"Initalize sparta canvas to be used with a given surface"
	
	BlSpartaSpaceRendererInitializeSignal emit.

	compositor := self createCompositor: aSurface.

	hasCallbacks := aSurface callbackRegistry isNullRegistry not.
	hasCallbacks ifTrue: [
		aSurface callbackRegistry
			onDrawCall: (FFIBackend current
				loadSymbol: #skia_platform_compositor_draw
				module: SkiaLibrary uniqueInstance libraryName)
			with: compositor;
			onResizeCall: (FFIBackend current
				loadSymbol: #skia_platform_compositor_resize
				module: SkiaLibrary uniqueInstance libraryName)
			with: compositor ].

	self
		initializeCanvas: SkiaCanvas offscreen
		surface: aSurface
]

{ #category : #rendering }
BlSkiaCompositorSpaceRenderer >> renderSpace: aSpace [
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
				timeSync: 'Submit layer to the Compositor'
				during: [
					compositor submitLayer: aScaledSkiaLayer.
					hasCallbacks ifFalse: [ compositor draw ] ] ].

	^ (self damagedAreasOf: aSpace)
]

{ #category : #initialization }
BlSkiaCompositorSpaceRenderer >> resizeForSurface: aSurface [
	"The compositor is resized automatically via event loop callbacks"
	
	hasCallbacks
		ifTrue: [ ^ self ].
		
	compositor resize: aSurface extent
]

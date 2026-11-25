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
	"Initalize sparta canvas to be used with a given surface.
	A compositor that is still valid in this session is kept: a window holds a single EGL surface,
	so a second compositor cannot be created for it, and the window keeps the draw and resize
	callbacks registered with the first compositor, which must therefore stay alive"

	BlSpartaSpaceRendererInitializeSignal emit.

	(session == Smalltalk session and: [ compositor isNotNil and: [ compositor isValid ] ])
		ifTrue: [ hasCallbacks ifFalse: [ compositor resize: aSurface extent ] ]
		ifFalse: [
			compositor := self createCompositor: aSurface.
			compositor isValid
				ifTrue: [
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
							with: compositor ] ] ].

	self
		initializeCanvas: SkiaCanvas offscreen
		surface: aSurface
]

{ #category : #'as yet unclassified' }
BlSkiaCompositorSpaceRenderer >> isValid [
	super isValid
		ifFalse: [ ^ false ].
		
	^ compositor isNotNil
			and: [ compositor isValid ]
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

			aRootLayer := BlFrameTelemetry
				timeSync: 'Repaint space'
				during: [ BlCompositionPainter repaintSpace: aSpace ].
			
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
	self isValid
		ifFalse: [ ^ self initializeForSurface: aSurface ].

	"The compositor is resized automatically via event loop callbacks"
	physicalSize := aSurface physicalSize.
	scaleFactor := aSurface scaleFactor.
	
	hasCallbacks
		ifTrue: [ ^ self ].

	compositor resize: aSurface extent
]

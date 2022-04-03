Class {
	#name : #BlSpartaMetalCompositorSpaceRenderer,
	#superclass : #BlSpartaHardwareAcceleratedSpaceRenderer,
	#instVars : [
		'cache'
	],
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #initialization }
BlSpartaMetalCompositorSpaceRenderer >> initializeForSurface: aMetalSurface [
	"Initalize sparta canvas to be used with a given surface"
	| aSpartaCanvas |

	aSpartaCanvas := (BlSpartaRenderer pickCanvasForSurface: aMetalSurface) forMetalOn: aMetalSurface.
	cache := SkiaCompositorCache new.

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
				timeSync: 'Draw using Metal compositor'
				during: [ (SkiaCompositor new cache: cache)
					metalDraw: aScaledSkiaLayer
					on: spartaCanvas metalContext ] ].

	^ (self damagedAreasOf: aSpace)
]

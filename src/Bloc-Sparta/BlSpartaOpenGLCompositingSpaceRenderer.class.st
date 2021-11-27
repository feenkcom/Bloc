Class {
	#name : #BlSpartaOpenGLCompositingSpaceRenderer,
	#superclass : #BlSpartaHardwareAcceleratedSpaceRenderer,
	#instVars : [
		'compositor',
		'rootLayer'
	],
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #rendering }
BlSpartaOpenGLCompositingSpaceRenderer >> damagedAreasOf: aSpace [
	^ { 0@0 extent: aSpace extent }
]

{ #category : #initialization }
BlSpartaOpenGLCompositingSpaceRenderer >> initializeForSurface: aSurface [
	"Initalize sparta canvas to be used with a given surface"
	| aSpartaCanvas |

	aSpartaCanvas := (BlSpartaRenderer pickCanvasForSurface: aSurface) forOpenGLOn: aSurface.
	self
		initializeCanvas: aSpartaCanvas
		surface: aSurface.

	compositor ifNotNil: #release.
	compositor := SkiaCompositor new.
	rootLayer := BlCompositionContainerLayer new
]

{ #category : #rendering }
BlSpartaOpenGLCompositingSpaceRenderer >> renderSpace: aSpace [
	"Render a space and return a collection of damaged rectangles"
	<return: #Collection of: #Rectangle>
	
	self isValid
		ifFalse: [ ^ self ].
		
	compositor
		ifNil: [ ^ self ].
	
	compositor isNull
		ifTrue: [ ^ self ].
	
	BlFrameTelemetry
		timeSync: 'Render space'
		during: [
			| skiaLayer aRootLayer |

			aRootLayer := BlCompositionPainter repaintSpace: aSpace.
			
			BlFrameTelemetry
				timeSync: 'As Skia layer'
				during: [ skiaLayer := aRootLayer asSkiaLayer ].
				
			aRootLayer cleanNeedsCompositionFromAllLayers.

			BlFrameTelemetry
				timeSync: 'Draw'
				during: [	
					spartaCanvas surfaceCanvas clear: Color transparent.
					spartaCanvas transform
						by: [ :t | t scaleBy: scaleFactor asPoint ]
						during: [ compositor draw: skiaLayer on: spartaCanvas ]. ].
			
			BlFrameTelemetry
				timeSync: 'Flush'
				during: [ spartaCanvas flush ] ].
	
	^ (self damagedAreasOf: aSpace)
]

"
I am a copy of class BlSpartaMozCanvasBuilder. This comment is copied from there, and might not be entirely accurate

I build sparta canvas using Moz2D backend

"
Class {
	#name : #BlSpartaSkiaCanvasBuilder,
	#superclass : #BlSpartaCanvasBuilder,
	#category : #'Bloc-Sparta'
}

{ #category : #'api - instance creation' }
BlSpartaSkiaCanvasBuilder class >> extent: aPoint [
	<return: #SpartaCanvas>

	^ (self environment at: #SkiaCanvas) extent: aPoint
]

{ #category : #accessing }
BlSpartaSkiaCanvasBuilder class >> isSupported [
	<return: #Boolean>

	^ (self environment includesKey: #SkiaCanvas)
		and: [ (self environment at: #SkiaLibrary) uniqueInstance hasModule ]
]

{ #category : #accessing }
BlSpartaSkiaCanvasBuilder class >> label [
	<return: #String>
	^ 'Skia'
]

{ #category : #'instance creation' }
BlSpartaSkiaCanvasBuilder class >> offscreen [
	<return: #SpartaCanvas>

	^ (self environment at: #SkiaCanvas) offscreen
]

{ #category : #'api - instance creation' }
BlSpartaSkiaCanvasBuilder class >> pdf: aFileName extent: aPoint [
	self shouldBeImplemented
]

{ #category : #accessing }
BlSpartaSkiaCanvasBuilder class >> priority [
	^ 5
]

{ #category : #testing }
BlSpartaSkiaCanvasBuilder class >> supportsAndroidSurface [
	"Return true if this canvas builder can work with Android surface, false otherwise"
	<return: #Boolean>
	
	^ OSPlatform current isAndroid
]

{ #category : #testing }
BlSpartaSkiaCanvasBuilder class >> supportsBufferSurface [
	"Return true if this canvas builder can work with a buffer surface, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #testing }
BlSpartaSkiaCanvasBuilder class >> supportsDirect3DSurface [
	"Return true if this canvas builder can work with Direct3D surface, false otherwise"
	<return: #Boolean>
	
	^ OSPlatform current isWindows
]

{ #category : #testing }
BlSpartaSkiaCanvasBuilder class >> supportsFormSurface [
	"Return true if this canvas builder can work with form surface, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #testing }
BlSpartaSkiaCanvasBuilder class >> supportsMetalSurface [
	"Return true if this canvas builder can work with Metal surface, false otherwise"
	<return: #Boolean>
	
	^ OSPlatform current isMacOS
]

{ #category : #testing }
BlSpartaSkiaCanvasBuilder class >> supportsOpenGLSurface [
	"Return true if this renderer can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #testing }
BlSpartaSkiaCanvasBuilder class >> supportsWaylandSurface [
	"Return true if this canvas builder can work with Wayland surface, false otherwise"
	<return: #Boolean>

	^ OSPlatform current isLinux
]

{ #category : #testing }
BlSpartaSkiaCanvasBuilder class >> supportsXlibSurface [
	"Return true if this canvas builder can work with Xlib surface, false otherwise"
	<return: #Boolean>
	
	^ OSPlatform current isUnix
]

{ #category : #'api - instance creation' }
BlSpartaSkiaCanvasBuilder class >> svg: aFileName extent: aPoint [
	^ SkiaCanvas svg: aFileName extent: aPoint
]

{ #category : #'instance creation' }
BlSpartaSkiaCanvasBuilder >> forBufferOn: aRendererSurface [
	<return: #SpartaCanvas>

	^ (self class environment at: #SkiaCanvas)
		createForData: aRendererSurface buffer
		extent: aRendererSurface extent
		stride: aRendererSurface stride
		format: (self class environment at: #SkiaColorType) BGRA8888
]

{ #category : #'instance creation' }
BlSpartaSkiaCanvasBuilder >> forFormOn: aRendererSurface [
	<return: #SpartaCanvas>

	^ (self class environment at: #SkiaCanvas)
		createForData: aRendererSurface pointer
		extent: aRendererSurface extent
		stride: aRendererSurface stride
		format: (self class environment at: #SkiaColorType) BGRA8888
]

{ #category : #'instance creation' }
BlSpartaSkiaCanvasBuilder >> forOpenGLOn: aRendererSurface [
	| aSkiaBackendRenderTarget |
	<return: #SpartaCanvas>

	aSkiaBackendRenderTarget := (self class environment at: #SkiaBackendRenderTarget)
		newGlExtent: aRendererSurface physicalSize asPoint
		sampleCount: aRendererSurface sampleCount
		stencilBits: aRendererSurface stencilBits
		framebufferId: aRendererSurface framebufferId
		framebufferFormat: aRendererSurface framebufferFormat.

	^ (self class environment at: #SkiaCanvas)
		createFromRenderTarget: aSkiaBackendRenderTarget
		format: (self class environment at: #SkiaColorType) RGBA8888
		context: aRendererSurface context
]

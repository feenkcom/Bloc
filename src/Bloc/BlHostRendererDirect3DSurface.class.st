Class {
	#name : #BlHostRendererDirect3DSurface,
	#superclass : #BlHostRendererSurface,
	#instVars : [
		'extent',
		'windowHWND'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #accessing }
BlHostRendererDirect3DSurface class >> priority [
	"Direct3D should have higher priority than OpenGL"

	^ 5
]

{ #category : #testing }
BlHostRendererDirect3DSurface class >> supportedBy: anObject [
	"Return true if a given object supports form surface, false otherwise"
	<return: #Boolean>

	^ anObject supportsDirect3DSurface
]

{ #category : #initialization }
BlHostRendererDirect3DSurface >> createSpaceRendererOn: anObject [
	<return: #BlHostSpaceRenderer>

	^ anObject createDirect3DSpaceRenderer
]

{ #category : #initialization }
BlHostRendererDirect3DSurface >> createSurfaceRendererOn: anObject [
	<return: #BlHostSurfaceRenderer>

	^ anObject createDirect3DSurfaceRenderer
]

{ #category : #accessing }
BlHostRendererDirect3DSurface >> extent [
	"Return an actual extent of the underlying surface.
	Note: #extent may be different from canvas or window extents"
	<return: #Point>

	^ extent
]

{ #category : #accessing }
BlHostRendererDirect3DSurface >> extent: anObject [

	extent := anObject
]

{ #category : #accessing }
BlHostRendererDirect3DSurface >> windowHWND [

	^ windowHWND
]

{ #category : #accessing }
BlHostRendererDirect3DSurface >> windowHWND: anObject [

	windowHWND := anObject
]

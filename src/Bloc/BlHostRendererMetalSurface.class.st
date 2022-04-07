Class {
	#name : #BlHostRendererMetalSurface,
	#superclass : #BlHostRendererSurface,
	#instVars : [
		'extent',
		'nsView'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #accessing }
BlHostRendererMetalSurface class >> priority [
	"Metal should have higher priority than OpenGL"

	^ 5
]

{ #category : #testing }
BlHostRendererMetalSurface class >> supportedBy: anObject [
	"Return true if a given object supports form surface, false otherwise"
	<return: #Boolean>

	^ anObject supportsMetalSurface
]

{ #category : #initialization }
BlHostRendererMetalSurface >> createSpaceRendererOn: anObject [
	<return: #BlHostSpaceRenderer>

	^ anObject createMetalSpaceRenderer
]

{ #category : #initialization }
BlHostRendererMetalSurface >> createSurfaceRendererOn: anObject [
	<return: #BlHostSurfaceRenderer>

	^ anObject createMetalSurfaceRenderer
]

{ #category : #geometry }
BlHostRendererMetalSurface >> extent [
	"Return an actual extent of the underlying surface.
	Note: #extent may be different from canvas or window extents"
	<return: #Point>

	^ extent
]

{ #category : #accessing }
BlHostRendererMetalSurface >> extent: anObject [

	extent := anObject
]

{ #category : #accessing }
BlHostRendererMetalSurface >> nsView [

	^ nsView
]

{ #category : #accessing }
BlHostRendererMetalSurface >> nsView: anObject [

	nsView := anObject
]

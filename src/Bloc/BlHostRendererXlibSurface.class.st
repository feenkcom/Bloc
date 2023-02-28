Class {
	#name : #BlHostRendererXlibSurface,
	#superclass : #BlHostRendererSurface,
	#instVars : [
		'extent',
		'xlibDisplay',
		'xlibWindow'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #accessing }
BlHostRendererXlibSurface class >> priority [
	"Xlib should have higher priority than OpenGL"

	^ 5
]

{ #category : #testing }
BlHostRendererXlibSurface class >> supportedBy: anObject [
	"Return true if a given object supports form surface, false otherwise"
	<return: #Boolean>

	^ anObject supportsXlibSurface
]

{ #category : #initialization }
BlHostRendererXlibSurface >> createSpaceRendererOn: anObject [
	<return: #BlHostSpaceRenderer>

	^ anObject createXlibSpaceRenderer
]

{ #category : #initialization }
BlHostRendererXlibSurface >> createSurfaceRendererOn: anObject [
	<return: #BlHostSurfaceRenderer>

	^ anObject createXlibSurfaceRenderer
]

{ #category : #accessing }
BlHostRendererXlibSurface >> extent [
	"Return an actual extent of the underlying surface.
	Note: #extent may be different from canvas or window extents"
	<return: #Point>

	^ extent
]

{ #category : #accessing }
BlHostRendererXlibSurface >> extent: anObject [
	extent := anObject
]

{ #category : #accessing }
BlHostRendererXlibSurface >> xlibDisplay [
	^ xlibDisplay
]

{ #category : #accessing }
BlHostRendererXlibSurface >> xlibDisplay: anObject [
	xlibDisplay := anObject
]

{ #category : #accessing }
BlHostRendererXlibSurface >> xlibWindow [
	^ xlibWindow
]

{ #category : #accessing }
BlHostRendererXlibSurface >> xlibWindow: anObject [
	xlibWindow := anObject
]

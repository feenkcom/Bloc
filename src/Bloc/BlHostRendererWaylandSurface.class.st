Class {
	#name : #BlHostRendererWaylandSurface,
	#superclass : #BlHostRendererSurface,
	#instVars : [
		'extent',
		'waylandSurface',
		'waylandDisplay'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #accessing }
BlHostRendererWaylandSurface class >> priority [
	"Wayland renderer should have higher priority than OpenGL"

	^ 5
]

{ #category : #testing }
BlHostRendererWaylandSurface class >> supportedBy: anObject [
	"Return true if a given object supports form surface, false otherwise"
	<return: #Boolean>

	^ anObject supportsWaylandSurface
]

{ #category : #initialization }
BlHostRendererWaylandSurface >> createSpaceRendererOn: anObject [
	<return: #BlHostSpaceRenderer>

	^ anObject createWaylandSpaceRenderer
]

{ #category : #initialization }
BlHostRendererWaylandSurface >> createSurfaceRendererOn: anObject [
	<return: #BlHostSurfaceRenderer>

	^ anObject createWaylandSurfaceRenderer
]

{ #category : #geometry }
BlHostRendererWaylandSurface >> extent [
	"Return an actual extent of the underlying surface.
	Note: #extent may be different from canvas or window extents"
	<return: #Point>

	^ extent
]

{ #category : #accessing }
BlHostRendererWaylandSurface >> extent: anObject [
	extent := anObject
]

{ #category : #accessing }
BlHostRendererWaylandSurface >> waylandDisplay [
	^ waylandDisplay
]

{ #category : #accessing }
BlHostRendererWaylandSurface >> waylandDisplay: anObject [
	waylandDisplay := anObject
]

{ #category : #accessing }
BlHostRendererWaylandSurface >> waylandSurface [
	^ waylandSurface
]

{ #category : #accessing }
BlHostRendererWaylandSurface >> waylandSurface: anObject [
	waylandSurface := anObject
]

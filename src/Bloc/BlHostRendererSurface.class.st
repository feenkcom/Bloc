"
I am a mediator between host space and host renderer

"
Class {
	#name : #BlHostRendererSurface,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'physicalSize',
		'scaleFactor',
		'shouldUpdateEveryFrame',
		'updateActions',
		'callbackRegistry'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #accessing }
BlHostRendererSurface class >> allSurfaces [
	"Return a collection of all possible surfaces"
	<return: #Collection of: #'BlHostRendererSurface class'>

	^ self allSubclasses
]

{ #category : #testing }
BlHostRendererSurface class >> supportedBy: anObject [
	"Return true if a given object supports this surface, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'api - updates' }
BlHostRendererSurface >> addUpdateAction: aValuable [
	updateActions add: aValuable
]

{ #category : #'api - accessing' }
BlHostRendererSurface >> callbackRegistry [
	^ callbackRegistry
]

{ #category : #accessing }
BlHostRendererSurface >> callbackRegistry: anObject [

	callbackRegistry := anObject
]

{ #category : #initialization }
BlHostRendererSurface >> createSpaceRendererOn: anObject [
	<return: #BlHostSpaceRenderer>

	^ self subclassResponsibility
]

{ #category : #initialization }
BlHostRendererSurface >> createSurfaceRendererOn: anObject [
	<return: #BlHostSurfaceRenderer>

	^ self subclassResponsibility
]

{ #category : #geometry }
BlHostRendererSurface >> extent [
	"Return an actual extent of the underlying surface.
	Note: #extent may be different from canvas or window extents"
	<return: #Point>

	^ self subclassResponsibility
]

{ #category : #initialization }
BlHostRendererSurface >> initialize [
	super initialize.
	
	shouldUpdateEveryFrame := false.
	updateActions := OrderedCollection new.
	callbackRegistry := BlHostSurfaceCallbackNullRegistry new
]

{ #category : #initialization }
BlHostRendererSurface >> initializeForHostSpace: aBlHostSpace [
	physicalSize := aBlHostSpace physicalSize.
	scaleFactor := aBlHostSpace scaleFactor
]

{ #category : #geometry }
BlHostRendererSurface >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."
	<return: #FensterLogicalSize>

	^ self physicalSize asLogical: self scaleFactor
]

{ #category : #'api - updates' }
BlHostRendererSurface >> performUpdates [
	updateActions do: [ :eachUpdateAction | eachUpdateAction value ]
]

{ #category : #geometry }
BlHostRendererSurface >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."
	<return: #FensterPhysicalSize>

	^ physicalSize
]

{ #category : #initialization }
BlHostRendererSurface >> resizeForHostSpace: aBlHostSpace [
	physicalSize := aBlHostSpace physicalSize.
	scaleFactor := aBlHostSpace scaleFactor
]

{ #category : #geometry }
BlHostRendererSurface >> scaleFactor [
	"Return a scaling dpi factor from logical to physical coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Number>
	
	^ scaleFactor
]

{ #category : #'api - updates' }
BlHostRendererSurface >> shouldUpdateEveryFrame [
	<return: #Boolean>

	^ shouldUpdateEveryFrame
]

{ #category : #'api - updates' }
BlHostRendererSurface >> updateEveryFrame [
	shouldUpdateEveryFrame := true
]

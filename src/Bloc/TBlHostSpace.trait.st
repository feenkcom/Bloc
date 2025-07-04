"
I define the public API needed to be used by the Universe and the Spaces.
I define the public API that Host Spaces must provide.
This API is mostly used by  the Universe and the Host-Independent Spaces.
An Host Space is an  actual screen area provided by the underlying Host.
This area is typically an host-specific window.
"
Trait {
	#name : #TBlHostSpace,
	#instVars : [
		'host',
		'space',
		'universe',
		'renderer'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'host space - displaying' }
TBlHostSpace >> close [
	self explicitRequirement
]

{ #category : #initialization }
TBlHostSpace >> createAndroidSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>
	
	^ self explicitRequirement
]

{ #category : #initialization }
TBlHostSpace >> createBufferSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>
	
	^ self explicitRequirement
]

{ #category : #initialization }
TBlHostSpace >> createFormSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>
	
	^ self explicitRequirement
]

{ #category : #initialization }
TBlHostSpace >> createMetalSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>

	^ self explicitRequirement
]

{ #category : #initialization }
TBlHostSpace >> createOpenGLSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>

	^ self explicitRequirement
]

{ #category : #initialization }
TBlHostSpace >> createXlibSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>

	^ self explicitRequirement
]

{ #category : #'host space - cursor' }
TBlHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"

	self explicitRequirement
]

{ #category : #'host space - geometry' }
TBlHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>
	
	^ self explicitRequirement
]

{ #category : #'host space - accessing' }
TBlHostSpace >> detachHost [
	host := nil
]

{ #category : #'host space - accessing' }
TBlHostSpace >> detachSpace [
	space := nil
]

{ #category : #'host space - accessing' }
TBlHostSpace >> detachUniverse [
	universe := nil
]

{ #category : #'host space - geometry' }
TBlHostSpace >> displayScale [
	"Return a scaling dpi factor from logical to physical coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Number>
	| aPhysicalSize aLogicalSize aWidthScale aHeightScale |
	
	aPhysicalSize := self physicalSize.
	aLogicalSize := self logicalSize.
	
	(aPhysicalSize isZero
		or: [ aLogicalSize isZero ])
		ifTrue: [ ^ 1 ].

	aWidthScale := (aPhysicalSize width / aLogicalSize width) asFloat.
	aHeightScale := (aPhysicalSize height / aLogicalSize height) asFloat.
	
	(aWidthScale closeTo: aHeightScale epsilon: 0.1)
		ifFalse: [ NonInteractiveTranscript stdout
			show: ('DPI factor is different for width {1} and height {2}' format: { aWidthScale . aHeightScale });
			cr ].

	^ aWidthScale
]

{ #category : #'host space - events' }
TBlHostSpace >> enqueueEvent: aBlEvent [
	"I dispatch events directly to the universe or space as soon as they come"

	aBlEvent isUniverseEvent
		ifTrue: [ ^ self universe dispatchEvent: aBlEvent ].

	aBlEvent isSpaceEvent
		ifTrue: [ ^ self space dispatchEvent: aBlEvent ].

	self space dispatchEvent: aBlEvent
]

{ #category : #'host space - events' }
TBlHostSpace >> fetchedEventsDo: aBlock [
	"Flush event queue and evaluate a given block with every queued event as argument"
]

{ #category : #'host space - events' }
TBlHostSpace >> generateEvents [
	"Generate more complex state change events such as window scale event when resolution of the screen changes"
]

{ #category : #'host space - testing' }
TBlHostSpace >> hasResized [
	"Return true if renderer extent changed.
	It may happen if window moved between displays with different dpi,
	e.g. from normal display to retina"
	<return: #Boolean>

	^ self renderer hasResized: self
]

{ #category : #'host space - accessing' }
TBlHostSpace >> host [
	"Return a host that was used to create this host space"
	<return: #BlHost>

	^ host
]

{ #category : #'host space - accessing' }
TBlHostSpace >> host: aBlHost [
	"Assign a host that was used to create this host space"
	
	host := aBlHost
]

{ #category : #initialization }
TBlHostSpace >> initializeRenderer [
	self renderer initializeForHostSpace: self
]

{ #category : #'host space - testing' }
TBlHostSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"
	<return: #Boolean>

	^ self explicitRequirement
]

{ #category : #'host space - geometry' }
TBlHostSpace >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."
	<return: #FensterLogicalSize>

	^ self explicitRequirement
]

{ #category : #'host space - rendering' }
TBlHostSpace >> makeCurrent [
	"When displaying visual content on the screen very often a window framebuffer must be marked as a current"
]

{ #category : #'host space - displaying' }
TBlHostSpace >> maximize [

	self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> maximized [
	^ self explicitRequirement
]

{ #category : #'host space - rendering' }
TBlHostSpace >> measureTextParagraph: aBlTextParagraph [
	self renderer measureTextParagraph: aBlTextParagraph
]

{ #category : #'host space - displaying' }
TBlHostSpace >> minimize [

	self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> minimized [
	^ self explicitRequirement
]

{ #category : #'host space - testing' }
TBlHostSpace >> needsRebuild [
	"Return true if window should be recreated after user saved and quit pharo"
	<return: #Boolean>
	
	^ self explicitRequirement
]

{ #category : #'host space - geometry' }
TBlHostSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."
	<return: #FensterPhysicalSize>

	^ self explicitRequirement
]

{ #category : #'host space - rendering' }
TBlHostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	self renderer render: self
]

{ #category : #'host space - accessing' }
TBlHostSpace >> renderer [
	"Return host renderer used to render spaces"
	<return: #BlHostRenderer>

	^ renderer
]

{ #category : #initialization }
TBlHostSpace >> resizeRenderer [
	self renderer resizeForHostSpace: self
]

{ #category : #'host space - geometry' }
TBlHostSpace >> scaleFactor [
	"Return a total scaling factor from space to display coordinates.
	This includes a `displayScale` and a `userScale`."
	<return: #Number>

	^ self displayScale * self space userScale
]

{ #category : #'host space - displaying' }
TBlHostSpace >> show [
	self explicitRequirement
]

{ #category : #'host space - accessing' }
TBlHostSpace >> space [
	"Return a space I am assigned to"
	<return: #BlSpace>

	^ space
]

{ #category : #'host space - accessing' }
TBlHostSpace >> space: aSpace [
	"Assign me to a given space"

	space := aSpace
]

{ #category : #'host space - testing' }
TBlHostSpace >> supportsAndroidSurface [
	"Return true if this host space can work with metal surface, false otherwise"
	<return: #Boolean>
	
	^ self host supportsAndroidSurface
]

{ #category : #'host space - testing' }
TBlHostSpace >> supportsBufferSurface [
	"Return true if this host space can work with a buffer surface, false otherwise"
	<return: #Boolean>

	^ self host supportsBufferSurface
]

{ #category : #'host space - testing' }
TBlHostSpace >> supportsDirect3DSurface [
	"Return true if this host space can work with Direct3D surface, false otherwise"
	<return: #Boolean>
	
	^ self host supportsDirect3DSurface
]

{ #category : #'host space - testing' }
TBlHostSpace >> supportsFormSurface [
	"Return true if this host space can work with form surface, false otherwise"
	<return: #Boolean>
	
	^ self host supportsFormSurface
]

{ #category : #'host space - testing' }
TBlHostSpace >> supportsMetalSurface [
	"Return true if this host space can work with metal surface, false otherwise"
	<return: #Boolean>
	
	^ self host supportsMetalSurface
]

{ #category : #'host space - testing' }
TBlHostSpace >> supportsOpenGLSurface [
	"Return true if this host space can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ self host supportsOpenGLSurface
]

{ #category : #'host space - testing' }
TBlHostSpace >> supportsWaylandSurface [
	"Return true if this host space can work with Wayland surface, false otherwise"
	<return: #Boolean>
	
	^ self host supportsWaylandSurface
]

{ #category : #'host space - testing' }
TBlHostSpace >> supportsXlibSurface [
	"Return true if this host space can work with Xlib surface, false otherwise"
	<return: #Boolean>
	
	^ self host supportsXlibSurface
]

{ #category : #'host space - displaying' }
TBlHostSpace >> toBack [
	self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> toFront [
	self explicitRequirement
]

{ #category : #'host space - accessing' }
TBlHostSpace >> universe [
	<return: #BlParallelUniverse>

	^ universe
]

{ #category : #'host space - accessing' }
TBlHostSpace >> universe: aUniverse [
	universe := aUniverse
]

{ #category : #'host space - geometry' }
TBlHostSpace >> windowExtent: anExtent [
	self explicitRequirement
]

Class {
	#name : #BlRustWindowingHostSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace + TGlutinEventVisitor + TBlSpaceProperties',
	#classTraits : 'TBlHostSpace classTrait + TGlutinEventVisitor classTrait + TBlSpaceProperties classTrait',
	#instVars : [
		'window',
		'mousePosition',
		'eventFetcher',
		'modifiers',
		'scaleFactor',
		'keyBuffer'
	],
	#classVars : [
		'ZoomFactor'
	],
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #'class initialization' }
BlRustWindowingHostSpace class >> initialize [
	ZoomFactor := 1.0
]

{ #category : #accessing }
BlRustWindowingHostSpace class >> zoomFactor [
	^ ZoomFactor
]

{ #category : #accessing }
BlRustWindowingHostSpace class >> zoomFactor: aNumber [
	ZoomFactor := aNumber.
	BlRustWindowingHostSpace allSubInstancesDo: [ :eachHostSpace | eachHostSpace zoomFactorChanged ]
]

{ #category : #'host space - displaying' }
BlRustWindowingHostSpace >> close [
	window close
]

{ #category : #private }
BlRustWindowingHostSpace >> computeWindowScaleFactor: aScaleFactor [
	<return: #Number>

	^ aScaleFactor * self class zoomFactor
]

{ #category : #'event - handling' }
BlRustWindowingHostSpace >> convertButton: aGlutinButton [
	<return: #BlMouseButton>

	aGlutinButton button_type = WinitEventMouseButtonType Left
		ifTrue: [ ^ BlMouseButton primary ].

	aGlutinButton button_type = WinitEventMouseButtonType Middle
		ifTrue: [ ^ BlMouseButton middle ].

	aGlutinButton button_type = WinitEventMouseButtonType Right
		ifTrue: [ ^ BlMouseButton secondary ].

	^ BlMouseButton code: aGlutinButton button_code
]

{ #category : #'event - handling' }
BlRustWindowingHostSpace >> convertKeyFromEvent: anEvent [
	<return: #BlKeyboardKey>

	^ anEvent has_virtual_keycode
		ifTrue: [ self keyboardKeyTable keyFromVirtualCode: anEvent virtual_keycode ]
		ifFalse: [ BlKeyboardKey unknown: anEvent scan_code ]
]

{ #category : #'event - handling' }
BlRustWindowingHostSpace >> convertKeyModifiers: theGlutinModifiers [
	<return: #BlKeyModifiers>

	^ BlKeyModifiers
		shift: theGlutinModifiers shift
		ctrl: theGlutinModifiers ctrl
		alt: theGlutinModifiers alt
		cmd: theGlutinModifiers logo
]

{ #category : #initialization }
BlRustWindowingHostSpace >> createAndroidSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>

	^ BlWinitAndroidSurfaceRenderer new window: self window
]

{ #category : #initialization }
BlRustWindowingHostSpace >> createDirect3DSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>

	^ BlWinitDirect3DSurfaceRenderer new window: self window
]

{ #category : #initialization }
BlRustWindowingHostSpace >> createMetalSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>

	^ BlWinitMetalSurfaceRenderer new window: self window
]

{ #category : #initialization }
BlRustWindowingHostSpace >> createOpenGLSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>

	^ BlGlutinOpenGLSurfaceRenderer new window: self window
]

{ #category : #initialization }
BlRustWindowingHostSpace >> createWaylandSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>

	^ BlWinitWaylandSurfaceRenderer new window: self window
]

{ #category : #initialization }
BlRustWindowingHostSpace >> createXlibSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>

	^ BlWinitXlibSurfaceRenderer new window: self window
]

{ #category : #'host space - cursor' }
BlRustWindowingHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"

	window cursor: aCursor asWinitCursor
]

{ #category : #'host space - geometry' }
BlRustWindowingHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>
	
	^ 96.0
]

{ #category : #'host space - events' }
BlRustWindowingHostSpace >> enqueueEvent: aBlEvent [
	"I put events in a queue to be processed later"

	self eventFetcher enqueueEvent: aBlEvent
]

{ #category : #'host space - accessing' }
BlRustWindowingHostSpace >> eventFetcher [
	"Return event fetcher used to enqueue events that should be
	processed in the beginning of every frame"
	<return: #BlHostEventFetcher>

	^ eventFetcher
]

{ #category : #'host space - events' }
BlRustWindowingHostSpace >> fetchedEventsDo: aBlock [
	"Flush event queue and evaluate a given block with every queued event as argument"
	
	self eventFetcher fetchedEventsDo: aBlock
]

{ #category : #'event - handling' }
BlRustWindowingHostSpace >> handleKeyPressed: anEvent [
	| aKeyboardKey aBlocEvent |

	aKeyboardKey := self convertKeyFromEvent: anEvent.

	"do nothing if key is already pressed"
	(keyBuffer includes: aKeyboardKey)
		ifTrue: [ ^ self ].
		
	keyBuffer add: aKeyboardKey.

	aBlocEvent := BlKeyDownEvent new
		key: aKeyboardKey;
		scanCode: anEvent scan_code;
		modifiers: modifiers;
		timestamp: self space time now.
	
	self enqueueEvent: aBlocEvent
]

{ #category : #'event - handling' }
BlRustWindowingHostSpace >> handleKeyReleased: anEvent [
	| aKeyboardKey aBlocEvent |

	aKeyboardKey := self convertKeyFromEvent: anEvent.
	
	"do nothing if key is already released"
	(keyBuffer includes: aKeyboardKey)
		ifFalse: [ ^ self ].

	keyBuffer remove: aKeyboardKey.

	aBlocEvent := BlKeyUpEvent new
		key: aKeyboardKey;
		scanCode: anEvent scan_code;
		modifiers: modifiers;
		timestamp: self space time now.
	
	self enqueueEvent: aBlocEvent
]

{ #category : #'host space - accessing' }
BlRustWindowingHostSpace >> id [
	^ window id
]

{ #category : #initialization }
BlRustWindowingHostSpace >> initialize [
	super initialize.

	mousePosition := FensterPhysicalPosition new.
	scaleFactor := nil.
	eventFetcher := BlHostEventFetcher hostSpace: self.
	modifiers := BlKeyModifiers new.
	keyBuffer := Set new
]

{ #category : #'event - handling' }
BlRustWindowingHostSpace >> keyboardKeyTable [
	^ BlGlutinKeyboardKeyTable default
]

{ #category : #'host space - geometry' }
BlRustWindowingHostSpace >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."
	<return: #FensterLogicalSize>

	^ self physicalSize asLogical: self scaleFactor
]

{ #category : #'host space - rendering' }
BlRustWindowingHostSpace >> makeCurrent [
	"When displaying visual content on the screen very often a window framebuffer must be marked as a current"
	
	window makeCurrent
]

{ #category : #'host space - testing' }
BlRustWindowingHostSpace >> needsRebuild [
	"Return true if window should be recreated after user saved and quit pharo"
	<return: #Boolean>
	
	^ window isValid not
]

{ #category : #'host space - geometry' }
BlRustWindowingHostSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."
	<return: #FensterPhysicalSize>
	| anExtent |
	
	anExtent := window innerExtent.
	^ FensterPhysicalSize width: anExtent x height: anExtent y
]

{ #category : #'host space - geometry' }
BlRustWindowingHostSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>
	
	^ window position
]

{ #category : #'host space - geometry' }
BlRustWindowingHostSpace >> position: aPoint [
	"Change window's position to a given point in screen coordinates"
	
	window position: aPoint

]

{ #category : #'event - handling' }
BlRustWindowingHostSpace >> releasePressedKey: aKeyboardKey [
	| anEvent |

	keyBuffer
		remove: aKeyboardKey
		ifAbsent: [ ^ self ].
	
	anEvent := BlKeyUpEvent new
		key: aKeyboardKey;
		scanCode: 0;
		modifiers: modifiers;
		timestamp: self space time now.

	self enqueueEvent: anEvent
]

{ #category : #'event - handling' }
BlRustWindowingHostSpace >> releasePressedKeys [

	"Take all registered key down events from the buffer and send them as key up events to release keys"
	keyBuffer
		collect: [ :eachKey |
			BlKeyUpEvent new
				key: eachKey;
				scanCode: 0;
				modifiers: modifiers;
				timestamp: self space time now ]
		thenDo: [ :eachKeyUp | self enqueueEvent: eachKeyUp ].
	
	keyBuffer removeAll
]

{ #category : #'host space - rendering' }
BlRustWindowingHostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	Glutin critical: [ self renderer render: self ]
]

{ #category : #'host space - geometry' }
BlRustWindowingHostSpace >> scaleFactor [
	"Return a scaling dpi factor from logical to physical coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Number>

	^ scaleFactor ifNil: [ scaleFactor := self computeWindowScaleFactor: window scaleFactor ]
]

{ #category : #private }
BlRustWindowingHostSpace >> scaleFactorChangedTo: aScaleFactor physicalSize: aFensterPhysicalSize [
	| aBlocEvent |

	scaleFactor := self computeWindowScaleFactor: aScaleFactor.

	aBlocEvent := BlSpaceScaleFactorChangedEvent new
		scaleFactor: scaleFactor;
		timestamp: DateAndTime now;
		yourself.

	self enqueueEvent: aBlocEvent.

	aBlocEvent := BlSpaceResizedEvent new
		extent: (aFensterPhysicalSize asLogical: scaleFactor) asPoint;
		timestamp: DateAndTime now;
		yourself.

	self enqueueEvent: aBlocEvent.
	self universe ifNotNil: [ :aUniverse | aUniverse pulse ]
]

{ #category : #'host space - displaying' }
BlRustWindowingHostSpace >> show [
	"Window appears when created, show is redundant"
]

{ #category : #'window - properties' }
BlRustWindowingHostSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ window title
]

{ #category : #'window - properties' }
BlRustWindowingHostSpace >> title: aString [
	"Change window's title"

	window title: aString
]

{ #category : #'host space - displaying' }
BlRustWindowingHostSpace >> toFront [
	self window focusWindow
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitCharacterReceivedEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := BlTextInputEvent new
		text: anEvent text;
		timestamp: self space time now;
		modifiers: modifiers.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitCursorEnteredEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := BlSpaceMouseEnterEvent new
		timestamp: self space time now;
		yourself.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitCursorLeftEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := BlSpaceMouseLeaveEvent new
		timestamp: self space time now;
		yourself.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitCursorMovedEvent: anEvent [
	| aBlocEvent aNewCursorPosition aDelta |

	aNewCursorPosition := FensterPhysicalPosition x: anEvent x y: anEvent y.

	aDelta := aNewCursorPosition - mousePosition.

	mousePosition := aNewCursorPosition.

	aBlocEvent := BlMouseMoveEvent new
		position: (mousePosition asLogical: self scaleFactor) asPoint;
		screenPosition: window position + mousePosition asPoint;
		delta: (aDelta asLogical: self scaleFactor) asPoint;
		modifiers: modifiers;
		timestamp: self space time now;
		yourself.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitKeyboardInputEvent: anEvent [
	| aState |

	aState := anEvent state.

	aState = WinitEventInputElementState Unknown
		ifTrue: [ ^ self ].
		
	aState = WinitEventInputElementState Pressed
		ifTrue: [ ^ self handleKeyPressed: anEvent ].
	
	aState = WinitEventInputElementState Released
		ifTrue: [ ^ self handleKeyReleased: anEvent ]
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitMainEventsCleared: anEvent [
	"| aBlocEvent |	

	aBlocEvent := BlSpaceWakeUpEvent new
		timestamp: self space time now;
		yourself.
		
	self enqueueEvent: aBlocEvent"
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitModifiersChanged: anEvent [
	| newModifiers oldModifiers |
	
	newModifiers := self convertKeyModifiers: anEvent.
	oldModifiers := modifiers.

	"Meta is no longer pressed"
	(oldModifiers isCmd and: [ newModifiers isCmd not ])
		ifTrue: [
			self releasePressedKey: BlKeyboardKey metaLeft.
			self releasePressedKey: BlKeyboardKey metaRight ].

	"Shift is no longer pressed"
	(oldModifiers isShift and: [ newModifiers isShift not ])
		ifTrue: [
			self releasePressedKey: BlKeyboardKey shiftLeft.
			self releasePressedKey: BlKeyboardKey shiftRight ].

	"Control is no longer pressed"
	(oldModifiers isCtrl and: [ newModifiers isCtrl not ])
		ifTrue: [
			self releasePressedKey: BlKeyboardKey controlLeft.
			self releasePressedKey: BlKeyboardKey controlRight ].

	"Alt is no longer pressed"
	(oldModifiers isAlt and: [ newModifiers isAlt not ])
		ifTrue: [
			self releasePressedKey: BlKeyboardKey altLeft.
			self releasePressedKey: BlKeyboardKey altRight ].

	modifiers := newModifiers
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitMouseInputEvent: anEvent [
	| aState aBlocEvent |

	aState := anEvent state.
	
	aState = WinitEventInputElementState Unknown
		ifTrue: [ ^ self ].

	aBlocEvent := aState = WinitEventInputElementState Pressed
		ifTrue: [ BlMouseDownEvent new ]
		ifFalse: [BlMouseUpEvent new ].

	aBlocEvent
		position: (mousePosition asLogical: self scaleFactor) asPoint;
		screenPosition: window position + mousePosition asPoint;
		button: (self convertButton: anEvent button);
		modifiers: modifiers;
		timestamp: self space time now.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitMouseWheelEvent: anEvent [
	| aBlocEvent aDelta aDeltaPoint aScrollDistance |
		
	aDelta := anEvent delta.
	
	aDeltaPoint := modifiers isShift
		ifTrue: [ aDelta y negated @ aDelta x ]
		ifFalse: [ aDelta x @ aDelta y ].
	
	aScrollDistance := aDelta type = WinitEventMouseScrollDeltaType PixelDelta
		ifTrue: [ aDeltaPoint / self scaleFactor ]
		ifFalse: [ aDelta type = WinitEventMouseScrollDeltaType LineDelta
			ifTrue: [ aDeltaPoint * (GlutinLibrary mouseWheelScrollSpeed) * self scaleFactor ]
			ifFalse: [ 0@0 ] ].

	aScrollDistance isZero
		ifTrue: [ ^ self ].

	aBlocEvent := BlMouseWheelEvent new
		isTouch: false;
		phase: anEvent phase;
		vector: (BlVector x: aScrollDistance x y: aScrollDistance y);
		position: (mousePosition asLogical: self scaleFactor) asPoint;
		screenPosition: window position + mousePosition asPoint;
		modifiers: modifiers;
		timestamp: self space time now.
		
	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitTouchEndedEvent: anEvent [
	| aBlocEvent |

	mousePosition := FensterPhysicalPosition x: anEvent x y: anEvent y.

	aBlocEvent := BlMouseUpEvent new.
	aBlocEvent
		position: (mousePosition asLogical: self scaleFactor) asPoint;
		screenPosition: window position + mousePosition asPoint;
		button: BlMouseButton primary;
		modifiers: modifiers;
		timestamp: self space time now.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitTouchEvent: anEvent [
	| aPhase |

	aPhase := anEvent phase.
	
	aPhase = WinitEventTouchPhase Unknown
		ifTrue: [ ^ self ].

	aPhase = WinitEventTouchPhase Started
		ifTrue: [ ^ self visitTouchStartedEvent: anEvent ].
		
	aPhase = WinitEventTouchPhase Moved
		ifTrue: [ ^ self visitTouchMovedEvent: anEvent ].

	aPhase = WinitEventTouchPhase Ended 
		ifTrue: [ ^ self visitTouchEndedEvent: anEvent ].
		
	aPhase = WinitEventTouchPhase Cancelled 
		ifTrue: [ ^ self visitTouchEndedEvent: anEvent ]
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitTouchMovedEvent: anEvent [
	| aBlocEvent aNewPosition aDelta aScrollDistance |
		
	aNewPosition := FensterPhysicalPosition x: anEvent x y: anEvent y.	
	aDelta := aNewPosition - mousePosition.
	aDelta := FensterPhysicalPosition x: aDelta x negated y: aDelta y.
	aScrollDistance := aDelta asLogical: self scaleFactor.
	mousePosition := aNewPosition.

	aScrollDistance isZero
		ifTrue: [ ^ self ].

	aBlocEvent := BlMouseWheelEvent new
		isTouch: false;
		vector: (BlVector x: aScrollDistance x y: aScrollDistance y);
		position: (mousePosition asLogical: self scaleFactor) asPoint;
		screenPosition: window position + mousePosition asPoint;
		modifiers: modifiers;
		timestamp: self space time now.
		
	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitTouchStartedEvent: anEvent [
	| aBlocEvent |

	mousePosition := FensterPhysicalPosition x: anEvent x y: anEvent y.

	aBlocEvent := BlMouseDownEvent new.
	aBlocEvent
		position: (mousePosition asLogical: self scaleFactor) asPoint;
		screenPosition: window position + mousePosition asPoint;
		button: BlMouseButton primary;
		modifiers: modifiers;
		timestamp: self space time now.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitUserEvent: anEvent [
	
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitWindowCloseRequest: anEvent [
	| aBlocEvent |

	aBlocEvent := BlSpaceHostCloseRequest new
		timestamp: self space time now;
		yourself.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitWindowDestroyed: anEvent [
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitWindowFocusedEvent: anEvent [
	| aBlocEvent |
	
	self releasePressedKeys.

	aBlocEvent := anEvent is_focused
		ifTrue: [ BlSpaceFocusInEvent new ]
		ifFalse: [ BlSpaceFocusOutEvent new ].

	aBlocEvent
		timestamp: self space time now;
		yourself.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitWindowMovedEvent: anEvent [
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitWindowRedrawRequested: anEvent [
	| aBlocEvent |

	aBlocEvent := BlSpaceRedrawRequestedEvent new
		timestamp: DateAndTime now;
		yourself.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitWindowResizedEvent: anEvent [
	| aBlocEvent |
	window resize: anEvent width @ anEvent height.

	aBlocEvent := BlSpaceResizedEvent new
		extent: ((FensterPhysicalSize width: anEvent width height: anEvent height) asLogical: self scaleFactor) asPoint;
		timestamp: DateAndTime now;
		yourself.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlRustWindowingHostSpace >> visitWindowScaleFactorChangedEvent: anEvent [
	window resize: anEvent width @ anEvent height.

	self
		scaleFactorChangedTo: anEvent scale_factor
		physicalSize: (FensterPhysicalSize width: anEvent width height: anEvent height)
]

{ #category : #accessing }
BlRustWindowingHostSpace >> window [
	<return: #GlutinWindowedContext>

	^ window
]

{ #category : #accessing }
BlRustWindowingHostSpace >> window: aGlutinWindowedContext [
	window := aGlutinWindowedContext
]

{ #category : #'host space - geometry' }
BlRustWindowingHostSpace >> windowExtent: anExtent [
	window innerExtent: ((FensterLogicalSize width: anExtent x height: anExtent y) asPhysical: self scaleFactor) asPoint
]

{ #category : #private }
BlRustWindowingHostSpace >> zoomFactorChanged [
	self
		scaleFactorChangedTo: window scaleFactor
		physicalSize: self physicalSize
]

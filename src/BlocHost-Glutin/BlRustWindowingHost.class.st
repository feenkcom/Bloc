Class {
	#name : #BlRustWindowingHost,
	#superclass : #BlHost,
	#classInstVars : [
		'HostSpaceRegistry',
		'PulseLoop',
		'EventsSensor',
		'HostSpaceRegistryMutex',
		'UserInterruptEventHandler'
	],
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #private }
BlRustWindowingHost class >> critical: aBlock [
	^ HostSpaceRegistryMutex critical: aBlock
]

{ #category : #'api - ui process' }
BlRustWindowingHost class >> forceResumeOfUIProcess: aProcess [
	PulseLoop forceStartOfUIProcess: aProcess
]

{ #category : #'api - ui process' }
BlRustWindowingHost class >> forceStartNewUIProcess [
	PulseLoop forceStartNewUIProcess
]

{ #category : #'private - windows' }
BlRustWindowingHost class >> hostForWindow: aWindow do: aBlock [
	| aHost |
	
	aHost := HostSpaceRegistryMutex critical: [
		self spaceRegistry
			at: aWindow id
			ifAbsent: [ nil ] ].
	
	aHost ifNotNil: aBlock
]

{ #category : #initialization }
BlRustWindowingHost class >> initialize [
	PulseLoop := BlHostPulseLoop forHost: self.
	EventsSensor := BlGlutinWindowEventsSensor forHost: self.
	UserInterruptEventHandler := GlutinUserInterruptHandler new uiProcessBlock: [
		| process |
		process := nil.
		self uiProcessDo: [ :aUIProcess | process := aUIProcess ].
		process ].
	HostSpaceRegistryMutex := Mutex new
]

{ #category : #'api - lifecycle' }
BlRustWindowingHost class >> isRunning [
	<return: #Boolean>

	^ PulseLoop isRunning
]

{ #category : #private }
BlRustWindowingHost class >> spaceRegistry [
	^ HostSpaceRegistry ifNil: [ HostSpaceRegistry := WeakValueDictionary new ]
]

{ #category : #'api - lifecycle' }
BlRustWindowingHost class >> start [
	PulseLoop start.

	RustWindowingEventFetcher default
		addEventHandler: UserInterruptEventHandler;
		addEventHandler: EventsSensor.
	RustWindowingEventFetcher install
]

{ #category : #'api - lifecycle' }
BlRustWindowingHost class >> stop [
	RustWindowingEventFetcher default
		removeEventHandler: UserInterruptEventHandler;
		removeEventHandler: EventsSensor.
	PulseLoop stop
]

{ #category : #'api - ui process' }
BlRustWindowingHost class >> uiProcessDo: aBlock [
	PulseLoop loopProcess ifNotNil: aBlock
]

{ #category : #'host - api' }
BlRustWindowingHost >> createHostSpaceFor: aSpace [
	"Create and assign a new oswindow host space for given bloc space"
	| aHostSpace |

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host!' ].
	
	aHostSpace := self createWindowSpaceFor: aSpace.

	aSpace hostSpace: aHostSpace
]

{ #category : #private }
BlRustWindowingHost >> createWindowSpaceFor: aSpace [
	"Note, that I use given space only to find out what window properties to use for created window.
	I do not create any strong or weak references to provided space"
	| aHostSpace  windowBuilder windowedContext eventLoop |

	eventLoop := RustWindowingEventFetcher default eventLoop.

	windowBuilder := eventLoop windowBuilder
		title: aSpace title;
		extent: aSpace extent;
		withDecorations: aSpace borderless not;
		withTransparency: aSpace borderless;
		withResizable: aSpace resizable;
		withMaximized: aSpace maximized;
		withFullSize: aSpace fullsize.
	
	windowedContext := eventLoop createWindow: windowBuilder.
	aSpace knowsPosition
		ifTrue: [ windowedContext position: aSpace position ].
	
	aHostSpace := BlGlutinHostSpace new.
	aHostSpace window: windowedContext.
	
	aHostSpace universe: self universe.
	aHostSpace host: self.
	aHostSpace space: aSpace.
	aHostSpace withSpartaRenderer.
	
	self registerHostSpace: aHostSpace.

	^ aHostSpace
]

{ #category : #'host - api' }
BlRustWindowingHost >> destroyHostSpaceFor: aSpace [
	"Destroys host space window of a given space.
	Note: in most cases under 'destroy host space' we mean 'close host window' and unregister it"

	self destroyWindowSpaceFor: aSpace.

	aSpace hostSpace
		close;
		detachSpace;
		detachHost;
		detachUniverse.

	aSpace detachHostSpace
]

{ #category : #private }
BlRustWindowingHost >> destroyWindowSpaceFor: aSpace [
	self unregisterHostSpace: aSpace hostSpace
]

{ #category : #'host - testing' }
BlRustWindowingHost >> isStillAvailable [
	"Let's assume that a space is opened with me as a host.
	I return true if I am still available host for the current system.
	For example if a space is opened in a native window with a headless VM
	and then reopened with a headfull VM all those spaces should be re-opened
	with a different host, for example morphic"
	<return: #Boolean>

	^ self class isSupported
]

{ #category : #initialize }
BlRustWindowingHost >> registerHostSpace: aHostSpace [
	self class critical: [ self spaceRegistry at: aHostSpace window id put: aHostSpace ]
]

{ #category : #private }
BlRustWindowingHost >> spaceRegistry [
	^ self class spaceRegistry
]

{ #category : #initialize }
BlRustWindowingHost >> unregisterHostSpace: aHostSpace [
	self class critical: [ self spaceRegistry
		removeKey: aHostSpace window id
		ifAbsent: [  ] ]
]

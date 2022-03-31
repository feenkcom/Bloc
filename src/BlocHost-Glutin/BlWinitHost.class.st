Class {
	#name : #BlWinitHost,
	#superclass : #BlHost,
	#classVars : [
		'EventsSensor',
		'HostSpaceRegistry',
		'HostSpaceRegistryMutex',
		'PulseLoop',
		'UserInterruptEventHandler'
	],
	#classInstVars : [
		'hdpiRenderer'
	],
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #'api - ui process' }
BlWinitHost class >> forceResumeOfUIProcess: aProcess [
	PulseLoop forceStartOfUIProcess: aProcess
]

{ #category : #'api - ui process' }
BlWinitHost class >> forceStartNewUIProcess [
	PulseLoop forceStartNewUIProcess
]

{ #category : #accessing }
BlWinitHost class >> hdpiRenderer [
	^ hdpiRenderer ifNil: [ false ]
]

{ #category : #accessing }
BlWinitHost class >> hdpiRenderer: aBoolean [
	hdpiRenderer := aBoolean
]

{ #category : #'private - windows' }
BlWinitHost class >> hostForWindow: aWindow do: aBlock [
	| aHost |
	
	aHost := HostSpaceRegistryMutex critical: [
		self spaceRegistry
			at: aWindow id
			ifAbsent: [ nil ] ].
	
	aHost ifNotNil: aBlock
]

{ #category : #'class initialization' }
BlWinitHost class >> initialize [
	PulseLoop := BlHostPulseLoop forHost: self.
	EventsSensor := BlGlutinWindowEventsSensor new.
	UserInterruptEventHandler := GlutinUserInterruptHandler new uiProcessBlock: [
		| process |
		process := nil.
		self uiProcessDo: [ :aUIProcess | process := aUIProcess ].
		process ].
	HostSpaceRegistryMutex := Mutex new
]

{ #category : #'api - lifecycle' }
BlWinitHost class >> isRunning [
	<return: #Boolean>

	^ PulseLoop isRunning
]

{ #category : #'driver selection' }
BlWinitHost class >> isSupported [
	^ Glutin isSupported and: [ OSPlatform current isMacOS ]
]

{ #category : #'driver selection' }
BlWinitHost class >> label [
	"Return a host name that we can refer to. May be used for settings"
	<return: #String>

	^ 'Glutin'
]

{ #category : #preferences }
BlWinitHost class >> preferencesOn: aBuilder [
	<systemsettings>
			
	(aBuilder setting: #hdpiRenderer)
		parent: #Bloc;
		order: 10;
		target: self;
		label: 'Glutin - HDPI';
		description: 'Enable HDPI Morphic Renderer';
		default: [ true ]
]

{ #category : #'driver selection' }
BlWinitHost class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	Lower value - more likely host becomes a default"
	<return: #Number>
	
	^ 1
]

{ #category : #private }
BlWinitHost class >> spaceRegistry [
	^ HostSpaceRegistry ifNil: [ HostSpaceRegistry := WeakValueDictionary new ]
]

{ #category : #'api - lifecycle' }
BlWinitHost class >> start [
	PulseLoop start.

	RustWindowingEventFetcher default
		addEventHandler: UserInterruptEventHandler;
		addEventHandler: EventsSensor.
	RustWindowingEventFetcher install
]

{ #category : #'api - lifecycle' }
BlWinitHost class >> stop [
	RustWindowingEventFetcher default
		removeEventHandler: UserInterruptEventHandler;
		removeEventHandler: EventsSensor.
	PulseLoop stop
]

{ #category : #'api - ui process' }
BlWinitHost class >> uiProcessDo: aBlock [
	PulseLoop loopProcess ifNotNil: aBlock
]

{ #category : #'host - api' }
BlWinitHost >> createHostSpaceFor: aSpace [
	"Create and assign a new oswindow host space for given bloc space"
	| aHostSpace |

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host!' ].
	
	aHostSpace := self createWindowSpaceFor: aSpace.

	aSpace hostSpace: aHostSpace
]

{ #category : #private }
BlWinitHost >> createWindowSpaceFor: aSpace [
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
BlWinitHost >> destroyHostSpaceFor: aSpace [
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
BlWinitHost >> destroyWindowSpaceFor: aSpace [
	self unregisterHostSpace: aSpace hostSpace
]

{ #category : #'host - testing' }
BlWinitHost >> isStillAvailable [
	"Let's assume that a space is opened with me as a host.
	I return true if I am still available host for the current system.
	For example if a space is opened in a native window with a headless VM
	and then reopened with a headfull VM all those spaces should be re-opened
	with a different host, for example morphic"
	<return: #Boolean>

	^ self class isSupported
]

{ #category : #initialize }
BlWinitHost >> registerHostSpace: aHostSpace [
	HostSpaceRegistryMutex critical: [ self spaceRegistry at: aHostSpace window id put: aHostSpace ]
]

{ #category : #private }
BlWinitHost >> spaceRegistry [
	^ self class spaceRegistry
]

{ #category : #'host - testing' }
BlWinitHost >> supportsMetalSurface [
	"Return true if this host can work with Metal surface, false otherwise"
	<return: #Boolean>
	
	^ OSPlatform current isMacOS
]

{ #category : #'host - testing' }
BlWinitHost >> supportsOpenGLSurface [
	"Return true if this host can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ Smalltalk vm isRunningInWorkerThread not
]

{ #category : #initialize }
BlWinitHost >> unregisterHostSpace: aHostSpace [
	HostSpaceRegistryMutex critical: [ self spaceRegistry
		removeKey: aHostSpace window id
		ifAbsent: [  ] ]
]

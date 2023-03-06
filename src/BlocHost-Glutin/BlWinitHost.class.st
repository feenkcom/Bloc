Class {
	#name : #BlWinitHost,
	#superclass : #BlRustWindowingHost,
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #initialization }
BlWinitHost class >> initialize [
	super initialize
]

{ #category : #'driver selection' }
BlWinitHost class >> isSupported [
	^ Winit isSupported and: [ RustWindowingEventFetcher default eventLoop isWinit ]
]

{ #category : #'driver selection' }
BlWinitHost class >> label [
	"Return a host name that we can refer to. May be used for settings"
	<return: #String>

	^ 'Winit'
]

{ #category : #'driver selection' }
BlWinitHost class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	Lower value - more likely host becomes a default"
	<return: #Number>
	
	^ 1
]

{ #category : #'host - testing' }
BlWinitHost >> supportsAndroidSurface [
	"Return true if this host can work with Android surface, false otherwise"
	<return: #Boolean>
	
	^ OSPlatform current isAndroid
]

{ #category : #'host - testing' }
BlWinitHost >> supportsDirect3DSurface [
	"Return true if this host can work with Direct3D surface, false otherwise"
	<return: #Boolean>
	
	^ OSPlatform current isWindows
]

{ #category : #'host - testing' }
BlWinitHost >> supportsMetalSurface [
	"Return true if this host can work with Metal surface, false otherwise"
	<return: #Boolean>
	
	^ OSPlatform current isMacOS
]

{ #category : #'host - testing' }
BlWinitHost >> supportsWaylandSurface [
	"Return true if this host can work with Wayland surface, false otherwise"
	<return: #Boolean>
	
	^ OSPlatform current isLinux and: [
		RustWindowingEventFetcher default eventLoopType = WinitEventLoopType Wayland ]
]

{ #category : #'host - testing' }
BlWinitHost >> supportsXlibSurface [
	"Return true if this host can work with Xlib surface, false otherwise"
	<return: #Boolean>
	
	^ OSPlatform current isLinux and: [
		RustWindowingEventFetcher default eventLoopType = WinitEventLoopType X11 ]
]

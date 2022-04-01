Class {
	#name : #BlGlutinHost,
	#superclass : #BlRustWindowingHost,
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #initialization }
BlGlutinHost class >> initialize [
	super initialize
]

{ #category : #testing }
BlGlutinHost class >> isSupported [
	^ Glutin isSupported and: [ RustWindowingEventFetcher default eventLoop isGlutin ]
]

{ #category : #accessing }
BlGlutinHost class >> label [
	"Return a host name that we can refer to. May be used for settings"
	<return: #String>

	^ 'Glutin'
]

{ #category : #accessing }
BlGlutinHost class >> priority [
	^ 2
]

{ #category : #'host space - testing' }
BlGlutinHost >> supportsOpenGLSurface [
	"Return true if this host can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ Smalltalk vm isRunningInWorkerThread not
]

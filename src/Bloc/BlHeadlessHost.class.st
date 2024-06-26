"
I am a fallback host that is chosen if there are no other available and supported hosts.

"
Class {
	#name : #BlHeadlessHost,
	#superclass : #BlHost,
	#instVars : [
		'isRunning'
	],
	#classVars : [
		'PulseLoop'
	],
	#category : 'Bloc-Universe - Host Headless'
}

{ #category : #'class initialization' }
BlHeadlessHost class >> initialize [
	PulseLoop := BlHostPulseLoop forHost: self
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> isRunning [
	^ PulseLoop isRunning
]

{ #category : #'driver selection' }
BlHeadlessHost class >> label [
	^ 'Headless'
]

{ #category : #'driver selection' }
BlHeadlessHost class >> priority [
	"Infinite priority means that I am selected only if there are no other available hosts"
	<return: #Number>
	
	^ Float infinity
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> start [
	PulseLoop start
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> stop [
	PulseLoop stop
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"
	
	PulseLoop loopProcess ifNotNil: aBlock
]

{ #category : #'host - api' }
BlHeadlessHost >> createHostSpaceFor: aSpace [	
	| aHostSpace |
	
	aHostSpace := BlHeadlessHostSpace new.
	aHostSpace universe: self universe.
	aHostSpace host: self.
	aHostSpace space: aSpace.
	aHostSpace withSpartaRenderer.

	aSpace hostSpace: aHostSpace
]

{ #category : #'host - api' }
BlHeadlessHost >> destroyHostSpaceFor: aSpace [
	aSpace hostSpace
		close;
		detachSpace;
		detachHost;
		detachUniverse.

	aSpace detachHostSpace
]

{ #category : #'host - testing' }
BlHeadlessHost >> supportsBufferSurface [
	<return: #Boolean>
	
	^ true
]

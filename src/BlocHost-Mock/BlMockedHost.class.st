"
I am a mocked host that looks like real but does not create any windows

"
Class {
	#name : #BlMockedHost,
	#superclass : #BlHost,
	#classVars : [
		'isRunning'
	],
	#category : #'BlocHost-Mock-Host'
}

{ #category : #initialization }
BlMockedHost class >> initialize [
	isRunning := false
]

{ #category : #'api - lifecycle' }
BlMockedHost class >> isRunning [
	"Return true if host is initialized and running"
	<return: #Boolean>

	^ isRunning
]

{ #category : #accessing }
BlMockedHost class >> label [
	^ 'Mocked'
]

{ #category : #'api - lifecycle' }
BlMockedHost class >> start [
	isRunning := true
]

{ #category : #'api - lifecycle' }
BlMockedHost class >> stop [
	isRunning := false
]

{ #category : #'host - api' }
BlMockedHost >> createHostSpaceFor: aSpace [
	| aHostSpace |

	aHostSpace := BlMockedHostSpace new.
	aHostSpace host: self.
	aHostSpace space: aSpace.

	aSpace hostSpace: aHostSpace
]

{ #category : #'host - api' }
BlMockedHost >> destroyHostSpaceFor: aSpace [
	"Destroys host space window of a given space.
	Note: in most cases under 'destroy host space' we mean 'close host window' and unregister it"
	
	aSpace detachHostSpace
]

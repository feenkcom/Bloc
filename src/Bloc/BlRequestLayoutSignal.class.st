Class {
	#name : #BlRequestLayoutSignal,
	#superclass : #ContextStackSignal,
	#category : 'Bloc-Layouts-Support'
}

{ #category : #testing }
BlRequestLayoutSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	Excluding these signals makes a good starting point for application specific logging, or logging unexpected signals"

	^ true.
]

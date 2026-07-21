Class {
	#name : #BlParallelUniverseSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'universeId'
	],
	#category : 'Bloc-Universe - Parallel'
}

{ #category : #testing }
BlParallelUniverseSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

{ #category : #testing }
BlParallelUniverseSignal class >> isAbstract [
	^ self = BlParallelUniverseSignal
]

{ #category : #accessing }
BlParallelUniverseSignal class >> isRepeatable [
	"Return true if this signal is expected to be emitted regularly"
	<return: #Boolean>

	^ false
]

{ #category : #accessing }
BlParallelUniverseSignal class >> label [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlParallelUniverseSignal class >> nextSignals [
	"Return a collection of possible signals after this one"
	^ #()
]

{ #category : #accessing }
BlParallelUniverseSignal >> universeId [
	^ universeId
]

{ #category : #accessing }
BlParallelUniverseSignal >> universeId: aNumber [
	universeId := aNumber
]

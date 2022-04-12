Class {
	#name : #BlSpaceDetachedSignal,
	#superclass : #BlSpaceSignal,
	#instVars : [
		'universeId'
	],
	#category : #'Bloc-Space - Support'
}

{ #category : #printing }
BlSpaceDetachedSignal >> printOneLineContentsOn: aStream [
	aStream
		nextPutAll: 'Detached ';
		print: self space;
		nextPutAll: ' from: ';
		print: self universe
]

{ #category : #accessing }
BlSpaceDetachedSignal >> universe [
	^ BlParallelUniverse
		universeWithId: universeId
		do: [ :aUniverse | aUniverse ]
]

{ #category : #accessing }
BlSpaceDetachedSignal >> universe: aUniverse [
	universeId := aUniverse id
]

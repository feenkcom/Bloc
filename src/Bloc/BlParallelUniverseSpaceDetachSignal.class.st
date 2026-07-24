"
Is sent when a space is about to be detached from a universe
"
Class {
	#name : #BlParallelUniverseSpaceDetachSignal,
	#superclass : #BlParallelUniverseSpaceSignal,
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseSpaceDetachSignal class >> label [
	^ 'Detach space'
]

{ #category : #accessing }
BlParallelUniverseSpaceDetachSignal class >> nextSignals [
	^ {  }
]

{ #category : #printing }
BlParallelUniverseSpaceDetachSignal >> printOneLineContentsOn: aStream [
	aStream
		nextPutAll: 'Requested to detach ';
		nextPutAll: self space printString;
		nextPutAll: ' from ';
		nextPutAll: self universe printString
]

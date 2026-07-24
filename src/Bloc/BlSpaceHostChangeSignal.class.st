Class {
	#name : #BlSpaceHostChangeSignal,
	#superclass : #BlSpaceSignal,
	#instVars : [
		'oldHost',
		'newHost'
	],
	#category : #'Bloc-Space - Support'
}

{ #category : #accessing }
BlSpaceHostChangeSignal >> newHost [

	^ newHost
]

{ #category : #accessing }
BlSpaceHostChangeSignal >> newHost: anObject [

	newHost := anObject
]

{ #category : #accessing }
BlSpaceHostChangeSignal >> oldHost [

	^ oldHost
]

{ #category : #accessing }
BlSpaceHostChangeSignal >> oldHost: anObject [

	oldHost := anObject
]

{ #category : #printing }
BlSpaceHostChangeSignal >> printOneLineContentsOn: aStream [
	aStream
		nextPutAll: 'Requested to change the host of ';
		nextPutAll: self space printString;
		nextPutAll: ' from: ';
		nextPutAll: oldHost printString;
		nextPutAll: ' to: ';
		nextPutAll: newHost printString
]

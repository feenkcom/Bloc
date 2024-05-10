"
I represent a global element elevation given in Space coordinate system.

"
Class {
	#name : #BlGlobalElevation,
	#superclass : #BlElevation,
	#classInstVars : [
		'zero'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #cleanup }
BlGlobalElevation class >> cleanUp [
	super cleanUp.
	
	zero := nil
]

{ #category : #'instance creation' }
BlGlobalElevation class >> zero [
	<return: #BlGlobalElevation>

	^ zero ifNil: [ zero := self elevation: 0 ]
]

{ #category : #printing }
BlGlobalElevation >> printOn: aStream [
	aStream
		print: self elevation;
		nextPutAll: ' global elevation'
]

{ #category : #accessing }
BlGlobalElevation >> relatedTo: aNumber [
	"Global elevation is constant"
	<return: #Number>

	^ self elevation
]

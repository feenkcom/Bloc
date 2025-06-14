Class {
	#name : #BlElementBackgroundProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'background'
	],
	#category : #'Bloc-Core-Properties'
}

{ #category : #comparing }
BlElementBackgroundProperty >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ background = anObject background
]

{ #category : #'api - property' }
BlElementBackgroundProperty >> applyOnElement: anElement [
	anElement background: self background
]

{ #category : #accessing }
BlElementBackgroundProperty >> background [
	^ background
]

{ #category : #accessing }
BlElementBackgroundProperty >> background: aBackground [
	self
		assert: [ aBackground isNotNil ]
		description: [ 'Background must not be nil' ].

	background := aBackground
]

{ #category : #'api - property' }
BlElementBackgroundProperty >> cleanUpOnElement: anElement [
	anElement background: BlElementVisuals defaultBackground
]

{ #category : #comparing }
BlElementBackgroundProperty >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ background hash
]

{ #category : #printing }
BlElementBackgroundProperty >> printOn: aStream [
	aStream
		nextPutAll: 'Background - ';
		print: self background
]

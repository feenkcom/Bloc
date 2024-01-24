Class {
	#name : #BlElementLayoutVerticalResizerProperty,
	#superclass : #BlElementLayoutResizerProperty,
	#classVars : [
		'FitContent',
		'MatchParent'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #accessing }
BlElementLayoutVerticalResizerProperty class >> fitContent [
	^ FitContent
]

{ #category : #accessing }
BlElementLayoutVerticalResizerProperty class >> initialize [
	FitContent := self new fitContent.
	MatchParent := self new matchParent
]

{ #category : #accessing }
BlElementLayoutVerticalResizerProperty class >> matchParent [
	^ MatchParent
]

{ #category : #'api - property' }
BlElementLayoutVerticalResizerProperty >> applyOnElement: anElement [
	anElement constraints vertical resizer = self resizer
		ifTrue: [ ^ self ].

	anElement constraintsDo: [ :c | c vertical resizer: self resizer ]
]

{ #category : #accessing }
BlElementLayoutVerticalResizerProperty >> printOn: aStream [
	aStream
		nextPutAll: 'Vertical resizer - ';
		print: self resizer
]

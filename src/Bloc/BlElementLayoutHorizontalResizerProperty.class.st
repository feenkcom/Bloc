Class {
	#name : #BlElementLayoutHorizontalResizerProperty,
	#superclass : #BlElementLayoutResizerProperty,
	#classVars : [
		'FitContent',
		'MatchParent'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #accessing }
BlElementLayoutHorizontalResizerProperty class >> fitContent [
	^ FitContent
]

{ #category : #accessing }
BlElementLayoutHorizontalResizerProperty class >> initialize [
	FitContent := self new fitContent.
	MatchParent := self new matchParent
]

{ #category : #accessing }
BlElementLayoutHorizontalResizerProperty class >> matchParent [
	^ MatchParent
]

{ #category : #'api - property' }
BlElementLayoutHorizontalResizerProperty >> applyOnElement: anElement [
	anElement constraints horizontal resizer = self resizer
		ifTrue: [ ^ self ].

	anElement constraintsDo: [ :c | c horizontal resizer: self resizer ]
]

{ #category : #accessing }
BlElementLayoutHorizontalResizerProperty >> printOn: aStream [
	aStream
		nextPutAll: 'Vertical resizer - ';
		print: self resizer
]

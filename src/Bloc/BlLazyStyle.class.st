Class {
	#name : #BlLazyStyle,
	#superclass : #BlAbstractStyle,
	#instVars : [
		'styleComputation',
		'cachedStyle'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #'api - property' }
BlLazyStyle >> applyOnElement: anElement [
	cachedStyle
		ifNil: [
			cachedStyle := BlElementStyle new.
			styleComputation value: cachedStyle  ].
		
	cachedStyle applyOnElement: anElement
]

{ #category : #'api - property' }
BlLazyStyle >> cleanUpOnElement: anElement [
	cachedStyle ifNil: [ ^ self ].
	cachedStyle cleanUpOnElement: anElement
]

{ #category : #'pieces - computation' }
BlLazyStyle >> clearCache [
	cachedStyle := nil
]

{ #category : #accessing }
BlLazyStyle >> properties [
	^ cachedStyle ifNotNil: #properties ifNil: [ BlElementCurrentProperties new ]
]

{ #category : #accessing }
BlLazyStyle >> styleComputation: anObject [
	styleComputation := anObject
]

Class {
	#name : #BlElementLayoutConstraintsProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'constraintsBlock'
	],
	#category : #'Bloc-Core-Properties'
}

{ #category : #'api - property' }
BlElementLayoutConstraintsProperty >> applyOnElement: anElement [
	anElement constraintsDo: constraintsBlock
]

{ #category : #accessing }
BlElementLayoutConstraintsProperty >> constraintsBlock: anObject [
	constraintsBlock := anObject
]

{ #category : #accessing }
BlElementLayoutConstraintsProperty >> type [
	^ { self class . constraintsBlock }
]

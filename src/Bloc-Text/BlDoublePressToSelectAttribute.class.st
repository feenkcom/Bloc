Class {
	#name : #BlDoublePressToSelectAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'trimLeadingAndTrailingWhitespace'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #initialization }
BlDoublePressToSelectAttribute >> initialize [
	super initialize.
	
	trimLeadingAndTrailingWhitespace := true
]

{ #category : #accessing }
BlDoublePressToSelectAttribute >> trimLeadingAndTrailingWhitespace [
	^ trimLeadingAndTrailingWhitespace
]

{ #category : #accessing }
BlDoublePressToSelectAttribute >> trimLeadingAndTrailingWhitespace: anObject [
	trimLeadingAndTrailingWhitespace := anObject
]

{ #category : #comparing }
BlDoublePressToSelectAttribute >> type [
	^ self
]

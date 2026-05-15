Class {
	#name : #BlDoublePressToSelectAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'trimLeadingAndTrailingWhitespace',
		'onlyAtIntervalBoundaries'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #initialization }
BlDoublePressToSelectAttribute >> initialize [
	super initialize.
	
	trimLeadingAndTrailingWhitespace := true.
	onlyAtIntervalBoundaries := false
]

{ #category : #accessing }
BlDoublePressToSelectAttribute >> onlyAtIntervalBoundaries [
	^ onlyAtIntervalBoundaries
]

{ #category : #accessing }
BlDoublePressToSelectAttribute >> onlyAtIntervalBoundaries: anObject [
	onlyAtIntervalBoundaries := anObject
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

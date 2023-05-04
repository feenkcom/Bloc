Class {
	#name : #BlAbstractStyle,
	#superclass : #Object,
	#instVars : [
		'state'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #'api - property' }
BlAbstractStyle >> applyOnElement: anElement [
	self subclassResponsibility
]

{ #category : #'api - property' }
BlAbstractStyle >> cleanUpOnElement: anElement [
	self subclassResponsibility
]

{ #category : #accessing }
BlAbstractStyle >> priority [
	^ self state priority
]

{ #category : #accessing }
BlAbstractStyle >> properties [
	<return: #BlElementProperties>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlAbstractStyle >> state [
	<return: #BlElementState>

	^ state
]

{ #category : #private }
BlAbstractStyle >> state: aBlElementState [
	state := aBlElementState
]

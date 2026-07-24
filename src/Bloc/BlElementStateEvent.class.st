Class {
	#name : #BlElementStateEvent,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Core-State'
}

{ #category : #accessing }
BlElementStateEvent >> element [
	^ element
]

{ #category : #accessing }
BlElementStateEvent >> element: anObject [
	element := anObject
]

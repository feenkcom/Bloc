Class {
	#name : #BlElementStateEvent,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : 'Bloc-Basic-State'
}

{ #category : #accessing }
BlElementStateEvent >> element [
	^ element
]

{ #category : #accessing }
BlElementStateEvent >> element: anObject [
	element := anObject
]

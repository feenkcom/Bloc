Class {
	#name : #BlSpaceEvent,
	#superclass : #BlEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #testing }
BlSpaceEvent >> isSpaceEvent [
	^ true
]

{ #category : #sending }
BlSpaceEvent >> sendTo: anObject [
	anObject spaceEvent: self
]

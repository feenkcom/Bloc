Class {
	#name : #BlSpaceHostCloseRequest,
	#superclass : #BlSpaceEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #sending }
BlSpaceHostCloseRequest >> sendTo: anObject [
	anObject spaceHostCloseRequest: self
]

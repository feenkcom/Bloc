Class {
	#name : #BlMouseDoublePressEvent,
	#superclass : #BlMouseEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlMouseDoublePressEvent >> sendTo: anObject [
	anObject mouseDoublePressEvent: self
]

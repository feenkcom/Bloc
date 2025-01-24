Class {
	#name : #BlSteppedLayoutAllToBottomMark,
	#superclass : #BlSteppedLayoutMark,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #visiting }
BlSteppedLayoutAllToBottomMark >> acceptVisitor: aVisitor [
	^ aVisitor visitSteppedLayoutAllToBottomMark: self
]

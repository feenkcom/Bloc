Class {
	#name : #BlSteppedLayoutUndefinedMark,
	#superclass : #BlSteppedLayoutMark,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #visiting }
BlSteppedLayoutUndefinedMark >> acceptVisitor: aVisitor [
	^ aVisitor visitSteppedLayoutUndefinedMark: self
]

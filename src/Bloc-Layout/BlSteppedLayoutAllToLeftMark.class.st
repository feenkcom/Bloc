Class {
	#name : #BlSteppedLayoutAllToLeftMark,
	#superclass : #BlSteppedLayoutMark,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #visiting }
BlSteppedLayoutAllToLeftMark >> acceptVisitor: aVisitor [
	^ aVisitor visitSteppedLayoutAllToLeftMark: self
]

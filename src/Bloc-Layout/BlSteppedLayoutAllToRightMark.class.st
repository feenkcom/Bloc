Class {
	#name : #BlSteppedLayoutAllToRightMark,
	#superclass : #BlSteppedLayoutMark,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #visiting }
BlSteppedLayoutAllToRightMark >> acceptVisitor: aVisitor [
	^ aVisitor visitSteppedLayoutAllToRightMark: self
]

Class {
	#name : #BlSteppedLayoutUpRightMark,
	#superclass : #BlSteppedLayoutMark,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #visiting }
BlSteppedLayoutUpRightMark >> acceptVisitor: aVisitor [
	^ aVisitor visitSteppedLayoutUpRightMark: self
]

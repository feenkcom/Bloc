Class {
	#name : #BlSteppedLayoutBottomRightMark,
	#superclass : #BlSteppedLayoutMark,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #visiting }
BlSteppedLayoutBottomRightMark >> acceptVisitor: aVisitor [
	^ aVisitor visitSteppedLayoutBottomRightMark: self
]

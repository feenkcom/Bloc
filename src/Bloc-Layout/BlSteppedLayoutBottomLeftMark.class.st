Class {
	#name : #BlSteppedLayoutBottomLeftMark,
	#superclass : #BlSteppedLayoutMark,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #visiting }
BlSteppedLayoutBottomLeftMark >> acceptVisitor: aVisitor [
	^ aVisitor visitSteppedLayoutBottomLeftMark: self
]

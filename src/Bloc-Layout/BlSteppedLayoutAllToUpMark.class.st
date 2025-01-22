Class {
	#name : #BlSteppedLayoutAllToUpMark,
	#superclass : #BlSteppedLayoutMark,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #visiting }
BlSteppedLayoutAllToUpMark >> acceptVisitor: aVisitor [
	^ aVisitor visitSteppedLayoutAllToUpMark: self
]

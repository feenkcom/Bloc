Class {
	#name : #BlSteppedLayoutUpLeftMark,
	#superclass : #BlSteppedLayoutMark,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #visiting }
BlSteppedLayoutUpLeftMark >> acceptVisitor: aVisitor [
	^ aVisitor visitSteppedLayoutUpLeftMark: self
]

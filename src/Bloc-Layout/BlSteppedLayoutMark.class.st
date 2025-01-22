Class {
	#name : #BlSteppedLayoutMark,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #factory }
BlSteppedLayoutMark class >> allToBottom [
	^ BlSteppedLayoutAllToBottomMark instance
]

{ #category : #factory }
BlSteppedLayoutMark class >> allToLeft [
	^ BlSteppedLayoutAllToLeftMark instance
]

{ #category : #factory }
BlSteppedLayoutMark class >> allToRight [
	^ BlSteppedLayoutAllToRightMark instance
]

{ #category : #factory }
BlSteppedLayoutMark class >> allToUp [
	^ BlSteppedLayoutAllToUpMark instance
]

{ #category : #factory }
BlSteppedLayoutMark class >> bottomLeft [
	^ BlSteppedLayoutBottomLeftMark instance
]

{ #category : #factory }
BlSteppedLayoutMark class >> bottomRight [
	^ BlSteppedLayoutBottomRightMark instance
]

{ #category : #cleanup }
BlSteppedLayoutMark class >> cleanUp [
	instance := nil
]

{ #category : #accessing }
BlSteppedLayoutMark class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #factory }
BlSteppedLayoutMark class >> undefined [
	^ BlSteppedLayoutUndefinedMark instance
]

{ #category : #factory }
BlSteppedLayoutMark class >> upLeft [
	^ BlSteppedLayoutUpLeftMark instance
]

{ #category : #factory }
BlSteppedLayoutMark class >> upRight [
	^ BlSteppedLayoutUpRightMark instance
]

{ #category : #visiting }
BlSteppedLayoutMark >> acceptVisitor: aVisitor [
	^ aVisitor visitSteppedLayoutMark: self
]

{ #category : #printing }
BlSteppedLayoutMark >> gtDisplayOn: aStream [
	| someParts |
	someParts := self class name piecesCutWhereCamelCase allButFirst: 3.
	someParts
		ifEmpty: [ super gtDisplayOn: aStream.
			^ self ].

	someParts
		withIndexDo: [ :aPart :anIndex | 
			anIndex = 1
				ifTrue: [ aStream nextPutAll: aPart asLowercase ]
				ifFalse: [ aStream nextPutAll: aPart ] ]
]

Class {
	#name : #BlElementLayoutAlignmentProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'alignment'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #comparing }
BlElementLayoutAlignmentProperty >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ alignment = anObject alignment
]

{ #category : #accessing }
BlElementLayoutAlignmentProperty >> alignment [
	^ alignment
]

{ #category : #accessing }
BlElementLayoutAlignmentProperty >> alignment: anObject [
	alignment := anObject
]

{ #category : #comparing }
BlElementLayoutAlignmentProperty >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ alignment hash
]

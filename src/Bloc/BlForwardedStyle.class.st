Class {
	#name : #BlForwardedStyle,
	#superclass : #BlAbstractStyle,
	#instVars : [
		'targetObject',
		'style'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #comparing }
BlForwardedStyle >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ targetObject = anObject targetObject
		and: [ state = anObject state and: [ style = anObject style ] ]
]

{ #category : #'api - property' }
BlForwardedStyle >> applyOnElement: anElement [
	(targetObject asBlocResolvedElementsFrom: anElement) asCollection
		do: [ :eachTargetObject | style applyOnElement: eachTargetObject ]
]

{ #category : #'api - property' }
BlForwardedStyle >> cleanUpOnElement: anElement [
	(targetObject asBlocResolvedElementsFrom: anElement) asCollection
		do: [ :eachTargetObject | style cleanUpOnElement: eachTargetObject ]
]

{ #category : #comparing }
BlForwardedStyle >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ targetObject hash bitXor: (state hash bitXor: style hash)
]

{ #category : #accessing }
BlForwardedStyle >> style [
	^ style
]

{ #category : #accessing }
BlForwardedStyle >> style: anObject [
	style := anObject
]

{ #category : #accessing }
BlForwardedStyle >> targetObject [
	^ targetObject
]

{ #category : #accessing }
BlForwardedStyle >> targetObject: anObject [
	targetObject := anObject
]

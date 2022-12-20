Class {
	#name : #BlElementNotFocusableSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #'focus requesting' }
BlElementNotFocusableSignal >> element [
	^ element
]

{ #category : #'focus requesting' }
BlElementNotFocusableSignal >> element: anElement [
	element := anElement
]

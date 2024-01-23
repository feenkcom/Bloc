Class {
	#name : #BlFocusTransferEvent,
	#superclass : #BlBaseFocusEvent,
	#instVars : [
		'focusedElement',
		'previouslyFocusedElement'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlFocusTransferEvent >> focusedElement [
	^ focusedElement
]

{ #category : #accessing }
BlFocusTransferEvent >> focusedElement: anElement [
	focusedElement := anElement
]

{ #category : #testing }
BlFocusTransferEvent >> isFocusTransfer [
	^ true
]

{ #category : #accessing }
BlFocusTransferEvent >> previouslyFocusedElement [
	^ previouslyFocusedElement
]

{ #category : #accessing }
BlFocusTransferEvent >> previouslyFocusedElement: anElement [
	previouslyFocusedElement := anElement
]

{ #category : #sending }
BlFocusTransferEvent >> sendTo: anObject [
	anObject focusTransferEvent: self
]

Class {
	#name : #BlTextHighlightAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'paint',
		'id'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #testing }
BlTextHighlightAttribute class >> isDeprecated [
	"Use 
	- BlTextUnderlayAttribute for static cases (in styler), or 
	- BrTextHighlight for dynamic cases (e.g., highlighting as users move a cursor)
	instead."

	^ true
]

{ #category : #accessing }
BlTextHighlightAttribute class >> paint: aPaint [
	^ self new
		paint: aPaint;
		yourself
]

{ #category : #accessing }
BlTextHighlightAttribute >> applyOnFontAndStyleBuilder: aBlTextStyleBuilder [
	aBlTextStyleBuilder background: self paint
]

{ #category : #comparing }
BlTextHighlightAttribute >> equals: anAnotherAttribute [
	^ self paint = anAnotherAttribute paint
]

{ #category : #comparing }
BlTextHighlightAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self paint hash
]

{ #category : #accessing }
BlTextHighlightAttribute >> id [
	^ id
]

{ #category : #accessing }
BlTextHighlightAttribute >> id: anObject [
	id := anObject
]

{ #category : #initialization }
BlTextHighlightAttribute >> initialize [
	super initialize.
	id := ''
]

{ #category : #accessing }
BlTextHighlightAttribute >> paint [
	^ paint
]

{ #category : #accessing }
BlTextHighlightAttribute >> paint: aPaint [
	self
		assert: [ paint isNil ]
		description: [ 'I am immutable and can not be modified' ].

	paint := aPaint
]

{ #category : #printing }
BlTextHighlightAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'text-highlight: ';
		nextPutAll: self paint printString
]

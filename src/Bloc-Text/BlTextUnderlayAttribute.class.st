Class {
	#name : #BlTextUnderlayAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'paint'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BlTextUnderlayAttribute class >> paint: aPaint [
	^ self new
		paint: aPaint;
		yourself
]

{ #category : #accessing }
BlTextUnderlayAttribute >> applyOnFontAndStyleBuilder: aBlTextStyleBuilder [
	aBlTextStyleBuilder background: self paint
]

{ #category : #comparing }
BlTextUnderlayAttribute >> equals: anAnotherAttribute [
	^ self paint = anAnotherAttribute paint
]

{ #category : #comparing }
BlTextUnderlayAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self paint hash
]

{ #category : #accessing }
BlTextUnderlayAttribute >> paint [
	^ paint
]

{ #category : #accessing }
BlTextUnderlayAttribute >> paint: aPaint [
	self
		assert: [ paint isNil ]
		description: [ 'I am immutable and can not be modified' ].

	paint := aPaint
]

{ #category : #printing }
BlTextUnderlayAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'text-underlay: ';
		nextPutAll: self paint printString
]

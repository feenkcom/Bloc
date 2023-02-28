Class {
	#name : #BrDropdownContentStencil,
	#superclass : #BrStencil,
	#instVars : [
		'contentStencil',
		'decorator'
	],
	#category : #'Bloc-Basic-Stencil'
}

{ #category : #accessing }
BrDropdownContentStencil >> contentStencil: aValuable [
	contentStencil := aValuable
]

{ #category : #accessing }
BrDropdownContentStencil >> create [
	^ contentStencil value: decorator
]

{ #category : #accessing }
BrDropdownContentStencil >> decorator: aValuable [
	decorator := aValuable
]

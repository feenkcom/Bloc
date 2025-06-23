Class {
	#name : #BlTextDecorationStyleExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Examples-Model'
}

{ #category : #examples }
BlTextDecorationStyleExamples >> dashed [
	<gtExample>
	<return: #BlTextDecorationDashedStyle>
	| aStyle |
	aStyle := BlTextDecorationStyle dashed.

	self assert: aStyle class equals: BlTextDecorationDashedStyle.
	self assert: aStyle class label equals: 'Dashed'.
	self assert: aStyle class constructor equals: #dashed.
	self assert: aStyle class isAbstract not.
	self assert: aStyle equals: aStyle class new.
	self assert: aStyle hash equals: aStyle class hash.
	self assert: aStyle printString equals: aStyle class label.
	self assert: (Smalltalk compiler evaluate: aStyle storeString) equals: aStyle.

	^ aStyle
]

{ #category : #examples }
BlTextDecorationStyleExamples >> dotted [
	<gtExample>
	<return: #BlTextDecorationDottedStyle>
	| aStyle |
	aStyle := BlTextDecorationStyle dotted.

	self assert: aStyle class equals: BlTextDecorationDottedStyle.
	self assert: aStyle class label equals: 'Dotted'.
	self assert: aStyle class constructor equals: #dotted.
	self assert: aStyle class isAbstract not.
	self assert: aStyle equals: aStyle class new.
	self assert: aStyle hash equals: aStyle class hash.
	self assert: aStyle printString equals: aStyle class label.
	self assert: (Smalltalk compiler evaluate: aStyle storeString) equals: aStyle.

	^ aStyle
]

{ #category : #examples }
BlTextDecorationStyleExamples >> double [
	<gtExample>
	<return: #BlTextDecorationDoubleStyle>
	| aStyle |
	aStyle := BlTextDecorationStyle double.

	self assert: aStyle class equals: BlTextDecorationDoubleStyle.
	self assert: aStyle class label equals: 'Double'.
	self assert: aStyle class constructor equals: #double.
	self assert: aStyle class isAbstract not.
	self assert: aStyle equals: aStyle class new.
	self assert: aStyle hash equals: aStyle class hash.
	self assert: aStyle printString equals: aStyle class label.
	self assert: (Smalltalk compiler evaluate: aStyle storeString) equals: aStyle.

	^ aStyle
]

{ #category : #examples }
BlTextDecorationStyleExamples >> solid [
	<gtExample>
	<return: #BlTextDecorationSolidStyle>
	| aStyle |
	aStyle := BlTextDecorationStyle solid.

	self assert: aStyle class equals: BlTextDecorationSolidStyle.
	self assert: aStyle class label equals: 'Solid'.
	self assert: aStyle class constructor equals: #solid.
	self assert: aStyle class isAbstract not.
	self assert: aStyle equals: aStyle class new.
	self assert: aStyle hash equals: aStyle class hash.
	self assert: aStyle printString equals: aStyle class label.
	self assert: (Smalltalk compiler evaluate: aStyle storeString) equals: aStyle.

	^ aStyle
]

{ #category : #examples }
BlTextDecorationStyleExamples >> wavy [
	<gtExample>
	<return: #BlTextDecorationWavyStyle>
	| aStyle |
	aStyle := BlTextDecorationStyle wavy.

	self assert: aStyle class equals: BlTextDecorationWavyStyle.
	self assert: aStyle class label equals: 'Wavy'.
	self assert: aStyle class constructor equals: #wavy.
	self assert: aStyle class isAbstract not.
	self assert: aStyle equals: aStyle class new.
	self assert: aStyle hash equals: aStyle class hash.
	self assert: aStyle printString equals: aStyle class label.
	self assert: (Smalltalk compiler evaluate: aStyle storeString) equals: aStyle.

	^ aStyle
]

"
I am a concrete type of BlPaint that is just represented as a Color.

Color paint is transparent then and only then when underlying color's alpha channel is 0

"
Class {
	#name : #BlColorPaint,
	#superclass : #BlPaint,
	#instVars : [
		'color'
	],
	#category : #'Bloc-Paint'
}

{ #category : #'instance creation' }
BlColorPaint class >> color: aColor [
	^ self new color: aColor
]

{ #category : #'instance creation' }
BlColorPaint class >> transparent [
	"Return an instance of a paint with transparent color"
	<return: #BlColorPaint>
	
	^ BlTransparentPaint uniqueInstance
]

{ #category : #comparing }
BlColorPaint >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject color = self color
]

{ #category : #'as yet unclassified' }
BlColorPaint >> blocResolveForTheme: aTheme [
	<return: #BlPaint>

	^ (color blocResolveForTheme: aTheme) asBlPaint
]

{ #category : #accessing }
BlColorPaint >> color [
	"Return paint's underlying color.
	color can not be nil"
	<return: #Color>
	
	self
		assert: [ color isNotNil ]
		description: [ 'Color can not be nil' ].
	
	^ color
]

{ #category : #accessing }
BlColorPaint >> color: aColor [
	"Initialize me with a given Color"
	self
		assert: [ color isNil ]
		description: [ 'Color paint is immutable!' ].

	color := aColor
]

{ #category : #comparing }
BlColorPaint >> hash [
	^ self color hash
]

{ #category : #testing }
BlColorPaint >> isOpaque [
	"Color paint is opaque when underlying color is opaque
	@see BlPaint>>#isOpaque"
	<return: #Boolean>

	^ color isOpaque
]

{ #category : #testing }
BlColorPaint >> isTransparent [
	"Color paint is transparent when underlying color is transparent
	@see BlPaint>>#isTransparent"
	<return: #Boolean>

	^ color isTransparent
]

{ #category : #geometry }
BlColorPaint >> matchExtent: anExtent [
	"do nothing for color paint"
]

{ #category : #printing }
BlColorPaint >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' color: ';
		print: color.
]

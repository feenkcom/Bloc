"
# Background

I represent a background of the {{gtClass:BlElement}}. 
**I am immutable and can not be changed once created.** To modify the background, create a new instance and set it by sending {{gtMethod:BlElement>>#background:}}

## Types of background

There are multiple pre-built types of background:
 - paint background {{gtClass:BlPaintBackground}} which allows users to use any {{gtClass:BlPaint}} as a background
 - image background {{gtClass:BlImageBackground}} to use a bitmap {{gtClass:Form}}
 - composite background {{gtClass:BlCompositeBackground}} letting users to compose different types of background into one more complex background
 - transparent background {{gtClass:BlTransparentBackground}} as a special type of background that 

Background can be instantiated and composed directly or with the help of `BlBackgroundBuilder`.
See `BlBackgroundBuilder` for the related examples.

"
Class {
	#name : #BlBackground,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'opacity'
	],
	#category : #'Bloc-Core-Background'
}

{ #category : #builder }
BlBackground class >> builder [
	^ BlCompositeBackgroundBuilder new
]

{ #category : #'instance creation' }
BlBackground class >> image: aForm [
	<return: #BlBackground>
	
	^ BlImageBackground image: aForm
]

{ #category : #'instance creation' }
BlBackground class >> paint: aColorOrBlPaint [
	<return: #BlBackground>

	^ BlPaintBackground paint: aColorOrBlPaint
]

{ #category : #'instance creation' }
BlBackground class >> transparent [
	"Return a completely transparent background"
	<return: #BlBackground>
	
	^ BlTransparentBackground uniqueInstance
]

{ #category : #converting }
BlBackground >> asBlBackground [
	^ self
]

{ #category : #'as yet unclassified' }
BlBackground >> blocResolveForTheme: aTheme [
	^ self
]

{ #category : #initialization }
BlBackground >> defaultOpacity [
	"By default background is completely opaque"
	<return: #Number>

	^ 1.0
]

{ #category : #testing }
BlBackground >> isOpaque [
	"Return true if the whole background is opaque"
	<return: #Boolean>
	
	^ false
]

{ #category : #testing }
BlBackground >> isTransparent [
	"Return true if background is transparent and should not be rendered, false otherwise"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #geometry }
BlBackground >> matchExtent: anExtent [
	"Resize background to match given extent.
	Used to adapt image or gradient backgrounds to the element's extent"

	self subclassResponsibility
]

{ #category : #accessing }
BlBackground >> opacity [
	<return: #Number>

	^ opacity ifNil: [ self defaultOpacity ]
]

{ #category : #accessing }
BlBackground >> opacity: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Opacity must not be nil' ].
	self
		assert: [ aNumber between: 0.0 and: 1.0 ]
		description: [ 'Opacity value must be within interval [0..1]' ].

	opacity isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].

	self opacity = aNumber
		ifTrue: [ ^ self ].

	opacity := aNumber
]

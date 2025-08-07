Class {
	#name : #BlThemeableColor,
	#superclass : #Object,
	#instVars : [
		'color',
		'colorComputation',
		'theme',
		'themeableColorComputation',
		'themeGeneration'
	],
	#category : #'Bloc-Paint'
}

{ #category : #'instance creation' }
BlThemeableColor class >> color: aColorComputation source: aColorSource forTheme: aTheme [
	"Color computation is block that accepts a theme as an argument and returns an object that can be used as a color.
	[ :aTheme | aTheme label defaultTextColor ]"

	^ self new
		initializeColor: aColorComputation
		source: aColorSource
		forTheme: aTheme
		yourself
]

{ #category : #accessing }
BlThemeableColor >> alpha [
	^ color alpha
]

{ #category : #converting }
BlThemeableColor >> asBlBackground [
	^ BlBackground paint: self
]

{ #category : #converting }
BlThemeableColor >> asBlBorder [
	^ BlBorder paint: self
]

{ #category : #converting }
BlThemeableColor >> asBlPaint [
	^ BlColorPaint color: self
]

{ #category : #converting }
BlThemeableColor >> blocResolveColorForTheme: aTheme [
	<return: #Color>

	^ (aTheme = theme and: [ aTheme generation = self themeGeneration ])
		ifTrue: [ color ]
		ifFalse: [ (themeableColorComputation value: aTheme) blocResolveColorForTheme: aTheme ]
]

{ #category : #converting }
BlThemeableColor >> blocResolveForTheme: aTheme [
	<return: #BlThemeableColor>

	^ (aTheme = theme and: [ aTheme generation = self themeGeneration ])
		ifTrue: [ self ]
		ifFalse: [ themeableColorComputation value: aTheme ]
]

{ #category : #accessing }
BlThemeableColor >> blue [
	^ color blue
]

{ #category : #accessing }
BlThemeableColor >> green [
	^ color green
]

{ #category : #thumbnail }
BlThemeableColor >> iconOrThumbnailOfSize: aNumberOrPoint [
	"Answer an appropiate form to represent the receiver"

	^ color iconOrThumbnailOfSize: aNumberOrPoint
]

{ #category : #initialization }
BlThemeableColor >> initializeColor: aColorComputation source: aColorSource forTheme: aTheme [
	self
		assert: [ color isNil ]
		description: [ 'Color must not be initialized' ].

	self
		privateSetColor: (aColorComputation value: aTheme)
		computation: aColorComputation
		source: aColorSource
		forTheme: aTheme
]

{ #category : #testing }
BlThemeableColor >> isColor [
	^ true
]

{ #category : #testing }
BlThemeableColor >> isTransparent [
	^ color isTransparent
]

{ #category : #'pixels handling' }
BlThemeableColor >> pixelValueForDepth: d [
	^ color pixelValueForDepth: d
]

{ #category : #private }
BlThemeableColor >> privateAlpha [
	^ color privateAlpha
]

{ #category : #private }
BlThemeableColor >> privateRGB [
	^ color privateRGB
]

{ #category : #private }
BlThemeableColor >> privateSetColor: aColor [
	color := aColor
]

{ #category : #initialization }
BlThemeableColor >> privateSetColor: aColor computation: aColorComputation source: aColorSource forTheme: aTheme [
	self
		assert: [ color isNil ]
		description: [ 'Color must not be initialized' ].

	colorComputation := aColorComputation.
	color := aColor.
	theme := aTheme.
	themeGeneration := aTheme generation.
	themeableColorComputation := aColorSource.
]

{ #category : #accessing }
BlThemeableColor >> red [
	^ color red
]

{ #category : #dispatching }
BlThemeableColor >> spartaStrokePath: aPath with: aStrokePainter [
	color spartaStrokePath: aPath with: aStrokePainter
]

{ #category : #accessing }
BlThemeableColor >> theme [
	^ theme
]

{ #category : #accessing }
BlThemeableColor >> themeGeneration [
	^ themeGeneration ifNil: [ themeGeneration := 0 ]
]

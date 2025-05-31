Class {
	#name : #BlThemeableColor,
	#superclass : #Object,
	#instVars : [
		'color',
		'colorComputation',
		'theme',
		'themeableColorComputation'
	],
	#category : #'Bloc-Paint'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
BlThemeableColor >> asBlBackground [
	^ BlBackground paint: self
]

{ #category : #'as yet unclassified' }
BlThemeableColor >> asBlBorder [
	^ BlBorder paint: self
]

{ #category : #'as yet unclassified' }
BlThemeableColor >> asBlPaint [
	^ BlColorPaint color: self
]

{ #category : #'as yet unclassified' }
BlThemeableColor >> asSpartaPaintOn: aSpartaCanvas [
	^ aSpartaCanvas paint color: color
]

{ #category : #'as yet unclassified' }
BlThemeableColor >> asStrokePaintOn: aCanvas [
	^ aCanvas surface createStrokePaintFor: color
]

{ #category : #'as yet unclassified' }
BlThemeableColor >> blocResolveColorForTheme: aTheme [
	<return: #Color>

	^ aTheme = theme
		ifTrue: [ color ]
		ifFalse: [ (themeableColorComputation value: aTheme) blocResolveColorForTheme: aTheme ]
]

{ #category : #accessing }
BlThemeableColor >> blue [
	^ color blue
]

{ #category : #accessing }
BlThemeableColor >> green [
	^ color green
]

{ #category : #initialization }
BlThemeableColor >> initializeColor: aColorComputation source: aColorSource forTheme: aTheme [
	self
		assert: [ color isNil ]
		description: [ 'Color must not be initialized' ].

	colorComputation := aColorComputation.
	color := aColorComputation value: aTheme.
	theme := aTheme.
	themeableColorComputation := aColorSource.
]

{ #category : #testing }
BlThemeableColor >> isColor [
	^ true
]

{ #category : #'as yet unclassified' }
BlThemeableColor >> isTransparent [
	^ color isTransparent
]

{ #category : #'as yet unclassified' }
BlThemeableColor >> privateAlpha [
	^ color privateAlpha
]

{ #category : #'as yet unclassified' }
BlThemeableColor >> privateRGB [
	^ color privateRGB
]

{ #category : #accessing }
BlThemeableColor >> red [
	^ color red
]

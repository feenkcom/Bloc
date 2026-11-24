Class {
	#name : #BlSubTheme,
	#superclass : #Object,
	#instVars : [
		'theme',
		'constants'
	],
	#category : #'Bloc-Core-Theme'
}

{ #category : #'as yet unclassified' }
BlSubTheme class >> theme: aTheme [
	^ self basicNew
		theme: aTheme;
		initializeConstants;
		initialize;
		yourself
]

{ #category : #'as yet unclassified' }
BlSubTheme >> background: aBlock source: aSourceBlock [
	^ BlThemeableBackground
		background: aBlock
		source: aSourceBlock
		forTheme: self theme
]

{ #category : #'as yet unclassified' }
BlSubTheme >> color: aConstantName [
]

{ #category : #'as yet unclassified' }
BlSubTheme >> color: aConstantName in: aThemeName [
]

{ #category : #'as yet unclassified' }
BlSubTheme >> color: aBlock source: aSourceBlock [
	^ BlThemeableColor
		color: aBlock
		source: aSourceBlock
		forTheme: self theme
]

{ #category : #'as yet unclassified' }
BlSubTheme >> constantAt: aName [
	^ constants at: aName
]

{ #category : #'as yet unclassified' }
BlSubTheme >> constantAt: aName put: aValue [
	constants at: aName put: aValue
]

{ #category : #'as yet unclassified' }
BlSubTheme >> initializeConstants [
	constants := OrderedDictionary new
]

{ #category : #'as yet unclassified' }
BlSubTheme >> initializeThemeable [
]

{ #category : #initialization }
BlSubTheme >> refreshThemeable [
	| previousConstants |
	previousConstants := constants.
	self initializeConstants.
	previousConstants ifNotNil: [ constants addAll: previousConstants ].
	self initializeThemeable
]

{ #category : #'as yet unclassified' }
BlSubTheme >> theme [
	^ theme
]

{ #category : #'as yet unclassified' }
BlSubTheme >> theme: aTheme [
	theme := aTheme
]

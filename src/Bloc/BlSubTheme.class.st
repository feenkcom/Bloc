Class {
	#name : #BlSubTheme,
	#superclass : #Object,
	#instVars : [
		'theme'
	],
	#category : #'Bloc-Core-Theme'
}

{ #category : #'as yet unclassified' }
BlSubTheme class >> theme: aTheme [
	^ self basicNew
		theme: aTheme;
		initializeColors;
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
BlSubTheme >> color: aBlock source: aSourceBlock [
	^ BlThemeableColor
		color: aBlock
		source: aSourceBlock
		forTheme: self theme
]

{ #category : #'as yet unclassified' }
BlSubTheme >> initializeColors [
]

{ #category : #'as yet unclassified' }
BlSubTheme >> initializeTheme [
]

{ #category : #'as yet unclassified' }
BlSubTheme >> theme [
	^ theme
]

{ #category : #'as yet unclassified' }
BlSubTheme >> theme: aTheme [
	theme := aTheme
]

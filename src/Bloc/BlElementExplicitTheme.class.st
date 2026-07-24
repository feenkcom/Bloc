Class {
	#name : #BlElementExplicitTheme,
	#superclass : #BlElementTheme,
	#category : #'Bloc-Core-Theme'
}

{ #category : #converting }
BlElementExplicitTheme >> asInheritedTheme [
	^ BlElementInheritedTheme new theme: theme
]

{ #category : #testing }
BlElementExplicitTheme >> isExplicit [
	^ true
]

Class {
	#name : #BlElementTheme,
	#superclass : #Object,
	#instVars : [
		'theme'
	],
	#category : #'Bloc-Core-Theme'
}

{ #category : #converting }
BlElementTheme >> asInheritedTheme [
	^ self subclassResponsibility
]

{ #category : #testing }
BlElementTheme >> isExplicit [
	^ false
]

{ #category : #accessing }
BlElementTheme >> theme [
	^ theme
]

{ #category : #accessing }
BlElementTheme >> theme: aTheme [
	self
		assert: [ theme isNil ]
		description: [ 'A theme can not be re-assigned' ].

	theme := aTheme
]

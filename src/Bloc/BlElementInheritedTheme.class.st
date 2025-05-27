Class {
	#name : #BlElementInheritedTheme,
	#superclass : #BlElementTheme,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Core-Theme'
}

{ #category : #accessing }
BlElementInheritedTheme class >> default [
	^ uniqueInstance ifNil: [ uniqueInstance := self new theme: BlTheme default ]
]

{ #category : #converting }
BlElementInheritedTheme >> asInheritedTheme [
	^ self
]

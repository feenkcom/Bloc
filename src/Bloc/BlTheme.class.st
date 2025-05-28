Class {
	#name : #BlTheme,
	#superclass : #Object,
	#classInstVars : [
		'default'
	],
	#category : #'Bloc-Core-Theme'
}

{ #category : #testing }
BlTheme class >> canBeDefault [
	^ false
]

{ #category : #initialization }
BlTheme class >> default [
	^ default ifNil: [ default := self pickDefaultTheme ]
]

{ #category : #initialization }
BlTheme class >> default: aTheme [
	default := aTheme
]

{ #category : #accessing }
BlTheme class >> pickDefaultTheme [
	^ self allSubclasses
		detect: [ :each | each canBeDefault ]
		ifFound: [ :each | each new ]
		ifNone: [ self new ]
]

{ #category : #initialization }
BlTheme class >> resetDefault [
	default := nil
]

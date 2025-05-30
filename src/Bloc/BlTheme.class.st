Class {
	#name : #BlTheme,
	#superclass : #Object,
	#instVars : [
		'id',
		'announcer'
	],
	#classVars : [
		'UniqueIdGenerator',
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

{ #category : #'as yet unclassified' }
BlTheme class >> initialize [
	UniqueIdGenerator := BlUniqueIdGenerator new.
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

{ #category : #'as yet unclassified' }
BlTheme >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
BlTheme >> id [
	^ id ifNil: [ id := UniqueIdGenerator generateUniqueId ] 
]

{ #category : #'as yet unclassified' }
BlTheme >> initialize [
	super initialize.
	
	id := UniqueIdGenerator generateUniqueId.
	announcer := Announcer new
]

{ #category : #'as yet unclassified' }
BlTheme >> notifyThemeModified [
	self announcer announce: (BlThemeModified new theme: self)
]

{ #category : #'as yet unclassified' }
BlTheme >> onThemeModified [
]

{ #category : #'as yet unclassified' }
BlTheme >> themeModified [
	self onThemeModified.
	self notifyThemeModified
]

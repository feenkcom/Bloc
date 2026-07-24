Class {
	#name : #BlDynamicShortcut,
	#superclass : #BlBasicShortcut,
	#instVars : [
		'shortcutId',
		'registry'
	],
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #accessing }
BlDynamicShortcut >> combination [
	^ shortcutId
		 ifNil: [ combination ]
		 ifNotNil: [ :anId | self registry combinationFor: anId ]
]

{ #category : #accessing }
BlDynamicShortcut >> combinationForMacOS [
	^ shortcutId
		 ifNil: [ combination ]
		 ifNotNil: [ :anId | self registry combinationForMacOSFor: anId ]
]

{ #category : #accessing }
BlDynamicShortcut >> combinationForUnix [
	^ shortcutId
		 ifNil: [ combination ]
		 ifNotNil: [ :anId | self registry combinationForUnixFor: anId ]
]

{ #category : #accessing }
BlDynamicShortcut >> combinationForWindows [
	^ shortcutId
		 ifNil: [ combination ]
		 ifNotNil: [ :anId | self registry combinationForWindowsFor: anId ]
]

{ #category : #accessing }
BlDynamicShortcut >> registry [
	^ registry 
]

{ #category : #accessing }
BlDynamicShortcut >> shortcutId [
	^ shortcutId
]

{ #category : #accessing }
BlDynamicShortcut >> shortcutId: anId inRegistry: aRegistry [
	shortcutId := anId.
	registry := aRegistry.
]

Class {
	#name : #BlShortcutIds,
	#superclass : #Object,
	#instVars : [
		'extraShortcutIdsByIdentifier'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #'instance creation' }
BlShortcutIds class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlShortcutIds class >> default [
	^self uniqueInstance
]

{ #category : #'instance creation' }
BlShortcutIds class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]

{ #category : #accessing }
BlShortcutIds >> extraShortcutIdsByIdentifier [
	^ extraShortcutIdsByIdentifier
]

{ #category : #initialization }
BlShortcutIds >> initialize [
	super initialize.
	
	extraShortcutIdsByIdentifier := Dictionary new
]

{ #category : #accessing }
BlShortcutIds >> shortcutIdForIdentifier: aSymbol [
	^ extraShortcutIdsByIdentifier 
		at: aSymbol 
		ifAbsentPut: [ BlShortcutId identifier: aSymbol ]
]

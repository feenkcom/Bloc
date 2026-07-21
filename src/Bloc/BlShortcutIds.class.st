Class {
	#name : #BlShortcutIds,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #accessing }
BlShortcutIds class >> default [
	^self uniqueInstance
]

{ #category : #'instance creation' }
BlShortcutIds class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]

Class {
	#name : #BlDevScripterKeyboardStep,
	#superclass : #BlDevScripterStep,
	#instVars : [
		'key',
		'modifiers'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #initialization }
BlDevScripterKeyboardStep >> initialize [
	super initialize.
	
	modifiers := BlKeyModifiers new
]

{ #category : #accessing }
BlDevScripterKeyboardStep >> key [
	<return: #BlKeyboardKey>

	^ key
]

{ #category : #accessing }
BlDevScripterKeyboardStep >> key: aBlKeyboardKey [
	key := aBlKeyboardKey
]

{ #category : #accessing }
BlDevScripterKeyboardStep >> modifiers [
	<return: #BlKeyModifiers>
	^ modifiers
]

{ #category : #accessing }
BlDevScripterKeyboardStep >> modifiers: anObject [
	modifiers := anObject
]

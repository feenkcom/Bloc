"
I am the abstract superclass for low-level keyboard event steps.

My subclasses simulate individual keyboard events at the lowest level: key down, key up, and key press. Each holds a `key` (a {{gtClass:BlKeyboardKey}}) and optional `modifiers` (a {{gtClass:BlKeyModifiers}}).

Use my subclasses when you need precise control over keyboard event sequences. For higher-level interactions, prefer {{gtClass:BlDevScripterShortcutStep}} (fires a shortcut event) or {{gtClass:BlDevScripterTypeTextStep}} (types a string).

## Subclasses

- {{gtClass:BlDevScripterKeyDownStep}} — simulates key down via {{gtMethod:BlSpace class>>#simulateKeyDownOn:key:modifiers:}}
- {{gtClass:BlDevScripterKeyUpStep}} — simulates key up via {{gtMethod:BlSpace class>>#simulateKeyUpOn:key:modifiers:}}
- {{gtClass:BlDevScripterKeyPressStep}} — simulates key press (full down+up cycle)

"
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

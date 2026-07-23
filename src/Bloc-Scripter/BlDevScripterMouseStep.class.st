"
I am the abstract superclass for low-level mouse event steps.

My subclasses simulate individual mouse events: button press, button release, and cursor movement. Each holds optional `modifiers` (a {{gtClass:BlKeyModifiers}}).

Use my subclasses when you need precise control over mouse event sequences (e.g., drag-and-drop). For higher-level interactions, prefer {{gtClass:BlDevScripterClickStep}} (fires complete click sequence) or {{gtClass:BlDevScripterMouseMoveOverStep}} (moves mouse to an element).

## Subclasses

- {{gtClass:BlDevScripterMouseDownStep}} — simulates mouse button press via {{gtMethod:BlSpace class>>#simulateMouseDownOn:at:}}
- {{gtClass:BlDevScripterMouseUpStep}} — simulates mouse button release via {{gtMethod:BlSpace class>>#simulateMouseUpOn:at:}}
- {{gtClass:BlDevScripterMouseMoveStep}} — simulates mouse movement via {{gtMethod:BlSpace class>>#simulateMouseMoveOn:from:to:}}
"
Class {
	#name : #BlDevScripterMouseStep,
	#superclass : #BlDevScripterStep,
	#instVars : [
		'modifiers'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseStep >> initialize [
	super initialize.
	
	modifiers := BlKeyModifiers new
]

{ #category : #accessing }
BlDevScripterMouseStep >> modifiers [
	^ modifiers
]

{ #category : #accessing }
BlDevScripterMouseStep >> modifiers: anObject [
	modifiers := anObject
]

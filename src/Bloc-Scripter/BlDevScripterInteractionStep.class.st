"
I am the abstract superclass for high-level UI interaction steps.

My subclasses simulate common user interactions like clicking, typing, and firing events. Each interaction targets a specific element (inherited from {{gtClass:BlDevScripterTargetedStep}}) and initializes with `onSelf` as the default target.

## Subclasses

Several key subclasses:

- {{gtClass:BlDevScripterClickStep}} — single click
- {{gtClass:BlDevScripterDoubleClickStep}} — double click
- {{gtClass:BlDevScripterSecondaryClickStep}} — right-click / context menu
- {{gtClass:BlDevScripterTypeTextStep}} — text input
- {{gtClass:BlDevScripterFireEventStep}} — fire arbitrary events
- {{gtClass:BlDevScripterRequestFocusStep}} — request focus on target
- {{gtClass:BlDevScripterShortcutStep}} — keyboard shortcuts
- {{gtClass:BlDevScripterMouseMoveOverStep}} — hover over element
- {{gtClass:BlDevScripterMouseWheelStep}} — scroll wheel
- {{gtClass:BlDevScripterWaitStep}} — wait for async conditions

"
Class {
	#name : #BlDevScripterInteractionStep,
	#superclass : #BlDevScripterTargetedStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #initialization }
BlDevScripterInteractionStep >> initialize [
	super initialize.
	
	self onSelf
]

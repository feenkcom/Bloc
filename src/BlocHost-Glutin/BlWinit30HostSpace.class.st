Class {
	#name : #BlWinit30HostSpace,
	#superclass : #BlRustWindowingHostSpace,
	#instVars : [
		'winitModifiers'
	],
	#classVars : [
		'KeyboardInputModifiersToIgnore'
	],
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #'class initialization' }
BlWinit30HostSpace class >> initialize [
	KeyboardInputModifiersToIgnore := {
		Winit30KeyboardKey leftShift.
		Winit30KeyboardKey rightShift.
		Winit30KeyboardKey leftKey: Winit30NamedKey ControlKey.
		Winit30KeyboardKey rightKey: Winit30NamedKey ControlKey.
		Winit30KeyboardKey leftKey: Winit30NamedKey AltKey.
		Winit30KeyboardKey rightKey: Winit30NamedKey AltKey.
		Winit30KeyboardKey leftKey: Winit30NamedKey SuperKey.
		Winit30KeyboardKey rightKey: Winit30NamedKey SuperKey.
	} asSet
]

{ #category : #'event - handling' }
BlWinit30HostSpace >> convertKeyFromEvent: anEvent [
	<return: #BlKeyboardKey>
	
	anEvent keyType = Winit30KeyType UnknownType
		ifTrue: [ ^ BlKeyboardKey unknown: anEvent scanCode ].
		
	^ self keyboardKeyTable keyFromVirtualCode: anEvent key
]

{ #category : #'as yet unclassified' }
BlWinit30HostSpace >> initialize [
	super initialize.
	
	winitModifiers := Winit30WindowEventModifiersChanged new.
]

{ #category : #'event - handling' }
BlWinit30HostSpace >> keyboardKeyTable [
	^ BlWinit30KeyboardKeyTable default
]

{ #category : #'event - visiting' }
BlWinit30HostSpace >> visitKeyboardInputEvent: anEvent [
	
	"we handle modifiers keys using modifier changed events"
	(KeyboardInputModifiersToIgnore includes: anEvent key)
		ifTrue: [ ^ self ].

	super visitKeyboardInputEvent: anEvent
]

{ #category : #'as yet unclassified' }
BlWinit30HostSpace >> visitModifiersChanged: anEvent [
	| newModifiers |
	
	newModifiers := self convertKeyModifiers: anEvent.
	(anEvent leftShift isNewlyPressed: winitModifiers leftShift)
		ifTrue: [
			self
				enqueueKeyPressed: (self keyboardKeyTable keyFromVirtualCode: Winit30KeyboardKey leftShift)
				modifiers: newModifiers ].
	
	(anEvent rightShift isNewlyPressed: winitModifiers rightShift)
		ifTrue: [
			self
				enqueueKeyPressed: (self keyboardKeyTable keyFromVirtualCode: Winit30KeyboardKey rightShift)
				modifiers: newModifiers ].
				
	(anEvent leftCtrl isNewlyPressed: winitModifiers leftCtrl)
		ifTrue: [
			self
				enqueueKeyPressed: (self keyboardKeyTable keyFromVirtualCode: Winit30KeyboardKey leftCtrl)
				modifiers: newModifiers ].
	
	(anEvent rightCtrl isNewlyPressed: winitModifiers rightCtrl)
		ifTrue: [
			self
				enqueueKeyPressed: (self keyboardKeyTable keyFromVirtualCode: Winit30KeyboardKey rightCtrl)
				modifiers: newModifiers ].
				
	(anEvent leftAlt isNewlyPressed: winitModifiers leftAlt)
		ifTrue: [
			self
				enqueueKeyPressed: (self keyboardKeyTable keyFromVirtualCode: Winit30KeyboardKey leftAlt)
				modifiers: newModifiers ].
	
	(anEvent rightAlt isNewlyPressed: winitModifiers rightAlt)
		ifTrue: [
			self
				enqueueKeyPressed: (self keyboardKeyTable keyFromVirtualCode: Winit30KeyboardKey rightAlt)
				modifiers: newModifiers ].
				
	(anEvent leftLogo isNewlyPressed: winitModifiers leftLogo)
		ifTrue: [
			self
				enqueueKeyPressed: (self keyboardKeyTable keyFromVirtualCode: Winit30KeyboardKey leftSuper)
				modifiers: newModifiers ].
	
	(anEvent rightLogo isNewlyPressed: winitModifiers rightLogo)
		ifTrue: [
			self
				enqueueKeyPressed: (self keyboardKeyTable keyFromVirtualCode: Winit30KeyboardKey rightSuper)
				modifiers: newModifiers ].
	
	winitModifiers := anEvent copy.

	super visitModifiersChanged: anEvent
]

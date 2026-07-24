"
I am the keymap registry category for space shortcuts. I hold the default key combinations for space-level shortcuts like zoom in/out, screenshot, etc.

Core shortcuts are registered in initializeBasicCombinations. Shortcuts from other packages (GToolkit-World) are added via extension methods with the <gtKeymapRegistration> pragma.
"
Class {
	#name : #BlSpaceKeymapRegistry,
	#superclass : #BlShortcutKeymapRegistryCategory,
	#category : #'Bloc-Space - Task Queue'
}

{ #category : #accessing }
BlSpaceKeymapRegistry class >> registryLabel [
	^ 'Space'
]

{ #category : #initialization }
BlSpaceKeymapRegistry >> initializeBasicCombinations [
	super initializeBasicCombinations.
	
	self 
		initializeShortcut: BlSpaceShortcutIds default zoomInShortcutId 
		with: (BlKeyCombination builder primary equal build).
	self 
		initializeShortcut: BlSpaceShortcutIds default zoomOutShortcutId 
		with: (BlKeyCombination builder primary minus build).
	self 
		initializeShortcut: BlSpaceShortcutIds default zoomNormalShortcutId 
		with: ((BlKeyCombination builder primary key: BlKeyboardKey zero) build).
	self 
		initializeShortcut: BlSpaceShortcutIds default takeScreenshotShortcutId 
		with: BlKeyCombination primaryShiftP
]

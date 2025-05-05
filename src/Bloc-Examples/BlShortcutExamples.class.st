Class {
	#name : #BlShortcutExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #examples }
BlShortcutExamples >> shortcutWithEnter [
	<gtExample>
	<return: #BlBasicShortcut>
	| aShortcut |
	aShortcut := BlBasicShortcut new combination: BlKeyCombination enter.

	self
		assert: (aShortcut matches: (BlKeyboardBuffer withPressedKeys: {BlKeyboardKey return})).
	self
		assert: (aShortcut
				matches: (BlKeyboardBuffer withPressedKeys: {BlKeyboardKey numpadEnter})).
	self
		assert: (aShortcut matches: (BlKeyboardBuffer withPressedKeys: {BlKeyboardKey escape}))
				not.
	self
		assert: (aShortcut
				matches: (BlKeyboardBuffer
						withPressedKeys: {BlKeyboardKey return.
								BlKeyboardKey escape})) not.

	^ aShortcut
]

{ #category : #examples }
BlShortcutExamples >> shortcutWithPrimaryA [
	<gtExample>
	<return: #BlBasicShortcut>
	| aShortcut |
	aShortcut := BlBasicShortcut new combination: BlKeyCombination primaryA.

	self
		assert: (aShortcut
				matches: (BlKeyboardBuffer
						withPressedKeys: {BlKeyboardKey primaryLeft.
								BlKeyboardKey a})).

	self
		assert: (aShortcut
				matches: (BlKeyboardBuffer
						withPressedKeys: {OSPlatform current primaryLeftKey.
								BlKeyboardKey a})).

	self
		assert: (aShortcut
				matches: (BlKeyboardBuffer
						withPressedKeys: {BlKeyboardKey primaryRight.
								BlKeyboardKey a})).

	self
		assert: (aShortcut
				matches: (BlKeyboardBuffer
						withPressedKeys: {OSPlatform current primaryRightKey.
								BlKeyboardKey a})).	"Quite cool: pressing both primary left and right, does not trigger the shortcut,
	because it detected 3 pressed keys, while the combination should contain only two"
	self
		assert: (aShortcut
				matches: (BlKeyboardBuffer
						withPressedKeys: {BlKeyboardKey primaryRight.
								BlKeyboardKey primaryLeft.
								BlKeyboardKey a})) not.

	self assert: (aShortcut matches: (BlKeyboardBuffer withPressedKeys: {})) not.
	self
		assert: (aShortcut matches: (BlKeyboardBuffer withPressedKeys: {BlKeyboardKey a})) not.
	self
		assert: (aShortcut matches: (BlKeyboardBuffer withPressedKeys: {BlKeyboardKey b})) not.

	^ aShortcut
]

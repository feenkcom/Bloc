"
I demonstrate how to use {{gtClass:BlDevScripterShortcutStep}} to simulate keyboard shortcuts.

A shortcut step fires a {{gtClass:BlShortcutEvent}} with the specified key combination. The shortcut must be registered on the target element or one of its ancestors to be handled.

## Example

{{gtExample:BlScripterShortcutStepUsageExamples>>#triggerShortcut|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlScripterShortcutStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #examples }
BlScripterShortcutStepUsageExamples >> triggerEscapeShortcut [
	"Demonstrates firing the Escape key shortcut.
	Escape is commonly used to cancel operations or close dialogs."
	<gtExample>
	| aScripter container element escaped |
	escaped := false.
	element := BlElement new
			id: #testElement;
			size: 100 @ 100;
			addShortcut: (BlShortcutWithAction new
					combination: (BlSingleKeyCombination key: BlKeyboardKey escape);
					action: [ escaped := true ]).
	container := BrFrame new
			matchParent;
			addChild: element.
	aScripter := self scripter.
	aScripter element: container.
	aScripter substep: 'Press Escape'
		do: [ :aStep |
			aStep shortcut
				label: 'Press Escape';
				combination: (BlSingleKeyCombination key: BlKeyboardKey escape);
				id: #testElement;
				play ].
	aScripter doStep: [ :s |
		s
			label: 'Assert escape was triggered';
			block: [ self assert: escaped ] ].
	^ aScripter
]

{ #category : #examples }
BlScripterShortcutStepUsageExamples >> triggerShortcut [
	"Demonstrates firing a keyboard shortcut on a target element.
	The shortcut must be registered on the element or its ancestors."
	<gtExample>
	| aScripter container element shortcutFired |
	shortcutFired := false.
	element := BlElement new
			id: #testElement;
			size: 100 @ 100;
			addShortcut: (BlShortcutWithAction new
					combination: BlKeyCombination primaryA;
					action: [ shortcutFired := true ]).
	container := BrFrame new
			matchParent;
			addChild: element.
	aScripter := self scripter.
	aScripter element: container.
	aScripter shortcutStep: [ :s |
		s
			label: 'Fire Ctrl+A';
			combination: BlKeyCombination primaryA;
			id: #testElement ].
	aScripter doStep: [ :s |
		s
			label: 'Assert shortcut was fired';
			block: [ self assert: shortcutFired ] ].
	^ aScripter
]

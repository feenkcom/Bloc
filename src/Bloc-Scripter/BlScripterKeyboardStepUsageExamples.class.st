"
I demonstrate how to use {{gtClass:BlDevScripterKeyboardStep}} and its subclasses for low-level keyboard events.

These steps simulate individual key press/release cycles: {{gtClass:BlDevScripterKeyDownStep}}, {{gtClass:BlDevScripterKeyUpStep}}, and {{gtClass:BlDevScripterKeyPressStep}}. Use these when you need fine-grained control over keyboard events. For higher-level keyboard interactions, prefer {{gtClass:BlDevScripterShortcutStep}} or {{gtClass:BlDevScripterTypeTextStep}}.

## Example

{{gtExample:BlScripterKeyboardStepUsageExamples>>#keyDownAndUp|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlScripterKeyboardStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #examples }
BlScripterKeyboardStepUsageExamples >> keyDownAndUp [
	"Demonstrates low-level keyboard events: keyDown followed by keyUp.
	These simulate individual key press/release cycles."
	<gtExample>
	| aScripter container element keyDownReceived keyUpReceived |
	keyDownReceived := false.
	keyUpReceived := false.
	element := BlElement new
			id: #testElement;
			size: 100 @ 100;
			background: Color blue;
			focusability: BlFocusability after;
			addEventHandlerOn: BlKeyDownEvent do: [ :e | keyDownReceived := true ];
			addEventHandlerOn: BlKeyUpEvent do: [ :e | keyUpReceived := true ].
	container := BrFrame new
			matchParent;
			addChild: element.
	aScripter := self scripter.
	aScripter element: container.
	aScripter substep: 'Focus then key down and up'
		do: [ :aStep |
			aStep requestFocus
				label: 'Focus the element';
				id: #testElement;
				play.
			(aStep keyDown: BlKeyboardKey return) play.
			(aStep keyUp: BlKeyboardKey return) play ].
	aScripter doStep: [ :s |
		s
			label: 'Assert key down and up were received';
			block: [
				self assert: keyDownReceived.
				self assert: keyUpReceived ] ].
	^ aScripter
]

{ #category : #examples }
BlScripterKeyboardStepUsageExamples >> keyPressWithModifiers [
	"Demonstrates a key press with modifiers.
	Useful for simulating keyboard shortcuts at a lower level than shortcut step."
	<gtExample>
	| aScripter container element |
	element := BlElement new
			id: #testElement;
			size: 100 @ 100.
	container := BrFrame new
			matchParent;
			addChild: element.
	aScripter := self scripter.
	aScripter element: container.
	aScripter keyPressStep: [ :s |
		s
			label: 'Press key A';
			key: BlKeyboardKey a ].
	^ aScripter
]

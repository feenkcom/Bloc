"
I fire a {{gtClass:BlShortcutEvent}} with a specified key combination on the target element.

The shortcut must be registered (via {{gtMethod:BlElement>>#addShortcut:}}) on the target or one of its ancestors to be handled. Configure the combination via {{gtMethod:BlDevScripterShortcutStep>>#combination:}}. I build a {{gtClass:BlKeyboardBuffer}} from the combination keys and fire the event.

## Usage Examples

- {{gtClass:BlScripterShortcutStepUsageExamples}} — canonical usage patterns
- {{gtClass:BlShortcutForwardingHandlerExamples}} — shortcut forwarding between elements
- {{gtClass:BrEditorSearchTextWithScripterExamples}} — opening search dialogs with Ctrl+F
- {{gtClass:BlKeyboardProcessorExamples}} — repeated shortcut firing

## Example

{{gtExample:BlScripterShortcutStepUsageExamples>>#triggerShortcut|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlDevScripterShortcutStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'combination'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterShortcutStep >> combination [
	^ combination
]

{ #category : #accessing }
BlDevScripterShortcutStep >> combination: anObject [
	combination := anObject
]

{ #category : #actions }
BlDevScripterShortcutStep >> playOn: aScripter [
	| aTarget aBuffer anEvent |
	aTarget := self target findTargetStartingInScripter: aScripter.
	
	aBuffer := BlKeyboardBuffer new.
	combination asBufferKeys do: [ :eachKeyboardKey | aBuffer add: (BlKeyDownEvent new key: eachKeyboardKey) ].

	anEvent := BlShortcutEvent new
		buffer: aBuffer.

	BlEvent fireEvent: anEvent target: aTarget.

	aScripter pulse
]

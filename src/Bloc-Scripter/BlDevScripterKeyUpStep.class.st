"
I simulate a key up event on the scripter element.

I call {{gtMethod:BlSpace class>>#simulateKeyUpOn:key:modifiers:}} to fire a {{gtClass:BlKeyUpEvent}} with the configured key and modifiers.

## Usage Examples

- {{gtClass:BlScripterKeyboardStepUsageExamples}} — canonical keyDown/keyUp pattern

## Example

{{gtExample:BlScripterKeyboardStepUsageExamples>>#keyDownAndUp|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlDevScripterKeyUpStep,
	#superclass : #BlDevScripterKeyboardStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyUpStep >> defaultLabel [
	^ 'Key up'
]

{ #category : #actions }
BlDevScripterKeyUpStep >> playOn: aScripter [
	BlSpace simulateKeyUpOn: aScripter element key: self key modifiers: self modifiers.
	aScripter pulse
]

"
I simulate a key down event on the scripter element.

I call {{gtMethod:BlSpace class>>#simulateKeyDownOn:key:modifiers:}} to fire a {{gtClass:BlKeyDownEvent}} with the configured key and modifiers.

## Usage Examples

- {{gtClass:BlScripterKeyboardStepUsageExamples}} — canonical keyDown/keyUp pattern
- {{gtClass:BlKeyboardProcessorExamples}} — keyboard processor with repeated shortcuts

## Example

{{gtExample:BlScripterKeyboardStepUsageExamples>>#keyDownAndUp|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlDevScripterKeyDownStep,
	#superclass : #BlDevScripterKeyboardStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyDownStep >> defaultLabel [
	^ 'Key down'
]

{ #category : #actions }
BlDevScripterKeyDownStep >> playOn: aScripter [
	BlSpace simulateKeyDownOn: aScripter element key: self key modifiers: self modifiers.
	aScripter pulse
]

"
I simulate a key press (full key down + key up cycle) on the scripter element.

I call {{gtMethod:BlSpace class>>#simulateKeyDownOn:key:modifiers:}} followed by {{gtMethod:BlSpace class>>#simulateKeyUpOn:key:modifiers:}} to fire both {{gtClass:BlKeyDownEvent}} and {{gtClass:BlKeyUpEvent}} in sequence.

## Usage Examples

- {{gtClass:BlScripterKeyboardStepUsageExamples}} — canonical key press pattern

## Example

{{gtExample:BlScripterKeyboardStepUsageExamples>>#keyPressWithModifiers|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlDevScripterKeyPressStep,
	#superclass : #BlDevScripterKeyboardStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyPressStep >> defaultLabel [
	^ self key
		ifNotNil: [ :aKey | 'Key press: {1}' format: {aKey name} ]
		ifNil: [ 'Key press' ]
]

{ #category : #actions }
BlDevScripterKeyPressStep >> playOn: aScripter [
	BlSpace simulateKeyDownOn: aScripter element key: self key modifiers: self modifiers.
	BlSpace simulateKeyUpOn: aScripter element key: self key modifiers: self modifiers.
	aScripter pulse
]

"
I request keyboard focus on the target element.

Use me before typing text — the target must have focus to receive {{gtClass:BlTextInputEvent}}. I call {{gtMethod:BlElement>>#requestFocus}} on the target element found by the targeting system.

## Usage Examples

- {{gtClass:BlScripterRequestFocusStepUsageExamples}} — canonical usage patterns
- {{gtClass:BlFocusProcessorExamples}} — detailed focus event lifecycle with scripter
- {{gtClass:BrEditorWithScripterExamples}} — requesting focus before typing in editors

## Example

{{gtExample:BlScripterRequestFocusStepUsageExamples>>#requestFocusOnElement|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlDevScripterRequestFocusStep,
	#superclass : #BlDevScripterInteractionStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterRequestFocusStep >> defaultLabel [
	^ 'Focus'
]

{ #category : #actions }
BlDevScripterRequestFocusStep >> playOn: aScripter [
	(self target findTargetStartingInScripter: aScripter) requestFocus.
	aScripter pulse
]

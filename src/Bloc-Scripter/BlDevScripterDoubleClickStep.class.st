"
I fire two rapid click sequences on the target element to simulate a double-click.

In text editors, a double-click typically selects the word under the cursor. In lists, it may trigger item activation.

## Usage Examples

- {{gtClass:BlScripterDoubleClickStepUsageExamples}} — canonical usage patterns

## Example

{{gtExample:BlScripterDoubleClickStepUsageExamples>>#doubleClickToSelectWord|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlDevScripterDoubleClickStep,
	#superclass : #BlDevScripterInteractionStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterDoubleClickStep >> defaultLabel [
	^ 'Double Click'
]

{ #category : #actions }
BlDevScripterDoubleClickStep >> playOn: aScripter [
	BlSpace simulateClickOn: (self target findTargetStartingInScripter: aScripter).
	BlSpace simulateClickOn: (self target findTargetStartingInScripter: aScripter).
	aScripter pulse
]

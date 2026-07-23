"
I demonstrate how to use {{gtClass:BlDevScripterTypeTextStep}} to simulate typing text.

A type text step sends a {{gtClass:BlTextInputEvent}} with the specified string to the target element. The target must have focus to receive the event. All characters must be printable.

## Example

{{gtExample:BlScripterTypeTextStepUsageExamples>>#typeTextAndAssertContent|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlScripterTypeTextStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #examples }
BlScripterTypeTextStepUsageExamples >> typeTextAndAssertContent [
	"Demonstrates typing text then verifying the editor content.
	Shows the pattern: type action followed by value assertion."
	<gtExample>
	| aScripter |
	aScripter := self typeTextInEditor.
	aScripter assertStep: 
			[:s |
			s
				label: 'Assert editor has typed text';
				value: [:anEditor | anEditor text asString] equals: ['Hello world'];
				id: #testEditor].
	^aScripter
]

{ #category : #examples }
BlScripterTypeTextStepUsageExamples >> typeTextInEditor [
	"Demonstrates typing text into an editor.
	The editor must have focus for type events to be received."
	<gtExample>
	| aScripter |
	aScripter := self scripterWithEditor.
	aScripter substep: 'Focus and type'
		do: 
			[:aStep |
			(aStep requestFocus)
				label: 'Focus the editor';
				id: #testEditor;
				play.
			(aStep type: 'Hello world')
				label: 'Type text';
				play].
	^aScripter
]

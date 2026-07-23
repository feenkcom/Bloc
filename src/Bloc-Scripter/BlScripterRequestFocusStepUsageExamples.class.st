"
I demonstrate how to use {{gtClass:BlDevScripterRequestFocusStep}} to request keyboard focus on a target element.

A request focus step calls {{gtMethod:BlElement>>#requestFocus}} on the target. This is necessary before typing text, since the target must have focus to receive {{gtClass:BlTextInputEvent}}.

## Example

{{gtExample:BlScripterRequestFocusStepUsageExamples>>#requestFocusOnElement|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlScripterRequestFocusStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #examples }
BlScripterRequestFocusStepUsageExamples >> requestFocusOnElement [
	"Demonstrates requesting focus on an element.
	After requesting focus, the element receives keyboard events."
	<gtExample>
	| aScripter container element |
	element := BlElement new
			id: #focusTarget;
			size: 100 @ 100;
			background: Color blue;
			focusability: BlFocusability after;
			addEventHandlerOn: BlFocusInEvent do: [ :e |
				e currentTarget background: Color green ].
	container := BrFrame new
			matchParent;
			addChild: element.
	aScripter := self scripter.
	aScripter element: container.
	aScripter requestFocus
		label: 'Focus the target element';
		id: #focusTarget;
		play.
	aScripter assertStep: [ :s |
		s
			label: 'Assert element received focus';
			value: [ :el | el background paint color ]
				equals: [ Color green ];
			id: #focusTarget ].
	^ aScripter
]

{ #category : #examples }
BlScripterRequestFocusStepUsageExamples >> requestFocusThenType [
	"Demonstrates the pattern: request focus, then type text.
	Focus must be requested before typing into an editor."
	<gtExample>
	| aScripter |
	aScripter := self scripterWithEditor.
	aScripter substep: 'Focus then type'
		do: [ :aStep |
			aStep requestFocus
				label: 'Focus the editor';
				id: #testEditor;
				play.
			(aStep type: 'focused')
				label: 'Type into focused editor';
				play ].
	aScripter assertStep: [ :s |
		s
			label: 'Assert editor has typed text';
			value: [ :anEditor | anEditor text asString ] equals: [ 'focused' ];
			id: #testEditor ].
	^ aScripter
]

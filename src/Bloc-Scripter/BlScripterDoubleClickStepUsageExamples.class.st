"
I demonstrate how to use {{gtClass:BlDevScripterDoubleClickStep}} to simulate double-click interactions.

A double-click step fires two rapid click sequences on the target element. In text editors, this typically selects the word under the cursor.

## Example

{{gtExample:BlScripterDoubleClickStepUsageExamples>>#doubleClickOnButton|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlScripterDoubleClickStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #examples }
BlScripterDoubleClickStepUsageExamples >> doubleClickOnButton [
	"Demonstrates double-clicking an element.
	Uses the doubleClick step which fires two rapid click events."
	<gtExample>
	| aScripter |
	aScripter := self scripterWithButton.
	aScripter doubleClickStep: [ :s |
		s
			label: 'Double-click test button';
			id: #testButton ].
	^ aScripter
]

{ #category : #examples }
BlScripterDoubleClickStepUsageExamples >> doubleClickToSelectWord [
	"Demonstrates double-clicking in an editor to select a word.
	Double-click in text editors typically selects the word under cursor."
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: self elementWithEditor.
	aScripter doubleClickStep: [ :s |
		s
			label: 'Double-click in editor';
			id: #testEditor ].
	aScripter assertStep: [ :s |
		s
			label: 'Assert a word was selected';
			value: [ :anEditor | anEditor editor selectedText asString ]
				equals: [ 'world' ];
			id: #testEditor ].
	^ aScripter
]

{ #category : #utility }
BlScripterDoubleClickStepUsageExamples >> elementWithEditor [
	"Creates a frame containing an editor with sample text"
	<gtExample>
	| editor |
	editor := BrEditor new
			id: #testEditor;
			aptitude: BrGlamorousEditorAptitude;
			text: 'hello world'.
	^ BrFrame new
			matchParent;
			addChild: editor
]

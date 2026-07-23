"
I am the root class for scripter step usage examples.

My subclasses demonstrate how to use specific {{gtClass:BlDevScripterStep}} types. Each subclass focuses on one step category and provides example methods showing canonical patterns.

To find examples for a specific step type, browse my subclasses.

I use the trait {{gtClass:TBlDevScripterExamples}} to provide standard scripter factory methods.
"
Class {
	#name : #BlScripterStepUsageExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #'examples - elements' }
BlScripterStepUsageExamples >> elementWithButton [
	"Creates a simple element with a button that tracks clicks"
	<gtExample>
	| container button clickCount |
	clickCount := 0.
	button := (BrButton new)
				id: #testButton;
				label: 'Click me';
				action: [clickCount := clickCount + 1];
				aptitude: BrGlamorousButtonWithLabelAptitude.
	container := (BrFrame new)
				id: #container;
				matchParent;
				addChild: button.
	^container
]

{ #category : #'examples - elements' }
BlScripterStepUsageExamples >> elementWithEditor [
	"Creates an element with a text editor for typing examples"
	<gtExample>
	| editor |
	editor := (BrEditor new)
				id: #testEditor;
				aptitude: BrGlamorousEditorAptitude;
				text: ''.
	^(BrFrame new)
		id: #container;
		matchParent;
		addChild: editor
]

{ #category : #'examples - scripter' }
BlScripterStepUsageExamples >> scripterWithButton [
	"Creates a scripter initialized with a button element"
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: self elementWithButton.
	^aScripter
]

{ #category : #'examples - scripter' }
BlScripterStepUsageExamples >> scripterWithEditor [
	"Creates a scripter initialized with an editor element"
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: self elementWithEditor.
	^aScripter
]

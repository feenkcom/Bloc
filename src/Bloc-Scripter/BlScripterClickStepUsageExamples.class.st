"
I demonstrate how to use {{gtClass:BlDevScripterClickStep}} to simulate click interactions.

A click step fires {{gtClass:BlMouseDownEvent}}, {{gtClass:BlMouseUpEvent}}, and {{gtClass:BlClickEvent}} on the target element.

## Examples

{{gtExample:BlScripterClickStepUsageExamples>>#clickOnButton|previewExpanded=true|previewHeight=300}}
{{gtExample:BlScripterClickStepUsageExamples>>#clickWithModifiers|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlScripterClickStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #examples }
BlScripterClickStepUsageExamples >> clickOnButton [
	"Demonstrates clicking a button by element ID.
	Uses clickStep: which auto-plays the step."
	<gtExample>
	| aScripter |
	aScripter := self scripterWithButton.
	aScripter clickStep: 
			[:s |
			s
				label: 'Click the test button';
				id: #testButton].
	^aScripter
]

{ #category : #examples }
BlScripterClickStepUsageExamples >> clickOnButtonAndAssert [
	"Demonstrates clicking and then asserting the UI changed.
	Shows the pattern: action step followed by assertion step."
	<gtExample>
	| aScripter |
	aScripter := self clickOnButton.
	aScripter assertStep: 
			[:s |
			s
				label: 'Assert button still exists';
				exists;
				id: #testButton].
	^aScripter
]

{ #category : #examples }
BlScripterClickStepUsageExamples >> clickOnButtonAndAssertWithExplicitPlay [
	"Demonstrates clicking and then asserting the UI changed.
	Shows the pattern: action step followed by assertion step 
	with explicit play actions"
	<gtExample>
	| aScripter |
	aScripter := self scripterWithButton.
	
	aScripter click
			label: 'Click the test button';
			id: #testButton;
			play.
	aScripter assert
			label: 'Assert button still exists';
			exists;
			id: #testButton;
			play.
				
	^aScripter
]

{ #category : #examples }
BlScripterClickStepUsageExamples >> clickOnButtonAndAssertWithImplicitPlay [
	"Demonstrates clicking and then asserting the UI changed.
	Shows the pattern: action step followed by assertion step 
	with implicit play actions in the step creation method"
	<gtExample>
	| aScripter |
	aScripter := self scripterWithButton.
	
	aScripter clickStep: 
			[:s |
			s
				label: 'Click the test button';
				id: #testButton].
	aScripter assertStep: 
			[:s |
			s
				label: 'Assert button still exists';
				exists;
				id: #testButton].
				
	^aScripter
]

{ #category : #examples }
BlScripterClickStepUsageExamples >> clickOnChildByIndex [
	"Demonstrates clicking a child element by its index.
	Uses onChildAt: for positional targeting."
	<gtExample>
	| aScripter |
	aScripter := self scripterWithButton.
	aScripter clickStep: 
			[:s |
			s
				label: 'Click first child of root';
				onChildAt: 1].
	^aScripter
]

{ #category : #examples }
BlScripterClickStepUsageExamples >> clickWithModifiers [
	"Demonstrates clicking with keyboard modifiers (e.g., Ctrl+Click).
	Modifiers are set via modifiers: on the step."
	<gtExample>
	| aScripter |
	aScripter := self scripterWithButton.
	aScripter clickStep: [ :s |
		s
			label: 'Ctrl+Click the button';
			modifiers: BlKeyModifiers ctrl;
			id: #testButton ].
	^ aScripter
]

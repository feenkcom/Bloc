"
I demonstrate how to use {{gtClass:BlDevScripterSetStep}} to set model, element, and key-value user data in a scripter.

The set step (accessed via {{gtMethod:TBlDevScripterActionStep>>#set|label=#selector}}) stores values into the scripter's state:
- {{gtMethod:BlDevScripterSetStep>>#model:}} — stores a model object accessible via {{gtMethod:TBlDevScripterTarget>>#onModel|label=#selector}}
- {{gtMethod:BlDevScripterSetStep>>#element:}} — sets the scripter's root element (optionally from the model)
- {{gtMethod:BlDevScripterSetStep>>#key:value:}} — stores arbitrary key-value pairs in scripter user data

## Examples

{{gtExample:BlScripterSetStepUsageExamples>>#setModelAndAssert|previewExpanded=true|previewHeight=300}}
{{gtExample:BlScripterSetStepUsageExamples>>#setKeyValueAndAssert|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlScripterSetStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #examples }
BlScripterSetStepUsageExamples >> setKeyValueAndAssert [
	"Demonstrates storing a key-value pair in scripter user data.
	Uses set step with key:value: to capture element state after an action."
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: (BrFrame new
		matchParent;
		addChild: (BrButton new
			id: #testButton;
			label: 'Click me';
			aptitude: BrGlamorousButtonWithLabelAptitude;
			action: [ :btn | btn label: 'Clicked' ])).
	aScripter clickStep: [ :s |
		s
			label: 'Click the button';
			id: #testButton ].
	aScripter set
		label: 'Store button label in user data';
		key: [ #buttonLabel ] value: [ :aButton | aButton label asString ];
		id: #testButton;
		play.
	aScripter assertStep: [ :s |
		s
			label: 'Assert stored user data equals Clicked';
			value: [ :el | aScripter userData at: #buttonLabel ] equals: [ 'Clicked' ];
			id: #testButton ].
	^ aScripter
]

{ #category : #examples }
BlScripterSetStepUsageExamples >> setModelAndAssert [
	"Demonstrates setting a model and building the UI from it.
	The model is stored via set step with model: and accessed via onModel targeting.
	Clicking the button updates the model; assertions verify model state."
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter substep: 'Initialize Model and UI' do: [ :aStep |
		aStep set
			label: 'Initialize Model';
			model: [ ValueHolder new contents: 0 ];
			play.
		aStep set
			label: 'Initialize UI';
			element: [ :aModel |
				BrFrame new
					matchParent;
					addChild: (BrButton new
						id: #testButton;
						label: 'Click me';
						aptitude: BrGlamorousButtonWithLabelAptitude;
						action: [ aModel contents: aModel contents + 1 ]) ];
			onModel;
			play ].
	aScripter clickStep: [ :s |
		s
			label: 'Click the button';
			id: #testButton ].
	aScripter clickStep: [ :s |
		s
			label: 'Click the button again';
			id: #testButton ].
	aScripter assertStep: [ :s |
		s
			label: 'Assert model counter is 2';
			value: [ :aModel | aModel contents ] equals: [ 2 ];
			onModel ].
	^ aScripter
]

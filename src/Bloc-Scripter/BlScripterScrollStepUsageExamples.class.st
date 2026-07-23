"
I demonstrate how to use {{gtClass:BlDevScripterMouseWheelStep}} to simulate scroll wheel events.

A mouse wheel step fires a {{gtClass:BlMouseWheelEvent}} with a configured direction and amount on the target element. Configure direction via {{gtMethod:BlDevScripterMouseWheelStep>>#upBy:}}, {{gtMethod:BlDevScripterMouseWheelStep>>#downBy:}}, {{gtMethod:BlDevScripterMouseWheelStep>>#leftBy:}}, or {{gtMethod:BlDevScripterMouseWheelStep>>#rightBy:}}.

## Example

{{gtExample:BlScripterScrollStepUsageExamples>>#scrollDownInList|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlScripterScrollStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #examples }
BlScripterScrollStepUsageExamples >> scrollDownInList [
	"Demonstrates scrolling down in a list using the mouse wheel.
	The mouseWheel step fires a BlMouseWheelEvent with the configured direction."
	<gtExample>
	| aScripter list container |
	list := BrSimpleList new
			id: #testList;
			matchParent;
			items: (1 to: 100) asArray;
			stencil: [ :each |
				BrLabel new
					aptitude: BrGlamorousLabelAptitude;
					text: each asString ].
	container := BrFrame new
			id: #container;
			matchParent;
			addChild: list.
	aScripter := self scripter.
	aScripter element: container.

	aScripter mouseWheel
		label: 'Scroll down by 5';
		downBy: 5;
		// #testList;
		play.
		
	^ aScripter
]

{ #category : #examples }
BlScripterScrollStepUsageExamples >> scrollUpInList [
	"Demonstrates scrolling up after having scrolled down.
	Shows composing examples: builds on scrollDownInList."
	<gtExample>
	| aScripter  |
	aScripter := self scrollDownInList.
	
	aScripter mouseWheel
		label: 'Scroll up by 5';
		upBy: 5;
		// #testList;
		play.
	^ aScripter
]

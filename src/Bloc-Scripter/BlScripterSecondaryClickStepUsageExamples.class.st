"
I demonstrate how to use {{gtClass:BlDevScripterSecondaryClickStep}} to simulate secondary (right) click interactions.

A secondary click step fires {{gtClass:BlMouseDownEvent}}, {{gtClass:BlMouseUpEvent}}, and a click event with the secondary mouse button on the target element. This is typically used to trigger context menus.

## Examples

{{gtExample:BlScripterSecondaryClickStepUsageExamples>>#secondaryClickOnButton|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlScripterSecondaryClickStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #examples }
BlScripterSecondaryClickStepUsageExamples >> secondaryClickOnButton [
	"Demonstrates secondary-clicking (right-clicking) a button.
	Uses secondaryClickStep: which fires a right-click event on the target."
	<gtExample>
	| aScripter contextMenuOpened |
	contextMenuOpened := false.
	aScripter := self scripter.
	aScripter element: (BrFrame new
		matchParent;
		addChild: (BrButton new
			id: #testButton;
			label: 'Right-click me';
			aptitude: BrGlamorousButtonWithLabelAptitude;
			addEventHandlerOn: BlMouseDownEvent
			do: [ :evt | 
				evt button = BlMouseButton secondary
					ifTrue: [ contextMenuOpened := true ] ])).
					
	aScripter secondaryClickStep: [ :s |
		s
			label: 'Secondary-click the button';
			id: #testButton ].
	aScripter assertStep: [ :s |
		s
			label: 'Assert context menu handler was triggered';
			value: [ :btn | contextMenuOpened ] equals: [ true ];
			id: #testButton ].
			
	^ aScripter
]

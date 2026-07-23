"
I demonstrate how to use {{gtClass:BlDevScripterMouseStep}} and its subclasses for low-level mouse events.

These steps simulate individual mouse actions: {{gtClass:BlDevScripterMouseDownStep}}, {{gtClass:BlDevScripterMouseUpStep}}, and {{gtClass:BlDevScripterMouseMoveStep}}. They are the building blocks of click interactions but give more control over timing and position. For higher-level interactions, prefer {{gtClass:BlDevScripterClickStep}} or {{gtClass:BlDevScripterMouseMoveOverStep}}.

## Example

{{gtExample:BlScripterMouseStepUsageExamples>>#mouseDownAndUp|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlScripterMouseStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #examples }
BlScripterMouseStepUsageExamples >> mouseDownAndUp [
	"Demonstrates low-level mouse events: mouseDown followed by mouseUp.
	These are the building blocks of click but give more control over timing and position."
	<gtExample>
	| aScripter container element |
	element := (BlElement new)
				id: #testElement;
				size: 100 @ 100;
				background: Color blue.
	container := (BrFrame new)
				matchParent;
				addChild: element.
	aScripter := self scripter.
	aScripter element: container.
	aScripter substep: 'Mouse down then up'
		do: 
			[:aStep |
			(aStep mouseDown)
				label: 'Press mouse button';
				play.
			(aStep mouseUp)
				label: 'Release mouse button';
				play].
	^aScripter
]

{ #category : #examples }
BlScripterMouseStepUsageExamples >> mouseMoveOver [
	"Demonstrates moving the mouse over a target element.
	This triggers mouse enter/over events on the target."
	<gtExample>
	| aScripter container element |
	element := BlElement new
			id: #testElement;
			size: 100 @ 100;
			background: Color blue.
	container := BrFrame new
			matchParent;
			addChild: element.
	aScripter := self scripter.
	aScripter element: container.
	aScripter mouseMoveOverStep: [ :s |
		s
			label: 'Hover over element';
			id: #testElement ].
	^ aScripter
]

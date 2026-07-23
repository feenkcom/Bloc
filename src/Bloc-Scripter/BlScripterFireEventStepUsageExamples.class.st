"
I demonstrate how to use {{gtClass:BlDevScripterFireEventStep}} to fire arbitrary events on target elements.

A fire event step can send any {{gtClass:BlEvent}} subclass to a target. Use it when there is no dedicated step class for the event you need. Convenience methods like {{gtMethod:BlDevScripterFireEventStep>>#mouseEnter}}, {{gtMethod:BlDevScripterFireEventStep>>#mouseLeave}}, {{gtMethod:BlDevScripterFireEventStep>>#mouseOver}}, {{gtMethod:BlDevScripterFireEventStep>>#mouseOut}} configure common event types.

## Example

{{gtExample:BlScripterFireEventStepUsageExamples>>#fireCustomEvent|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlScripterFireEventStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #examples }
BlScripterFireEventStepUsageExamples >> fireCustomEvent [
	"Demonstrates firing a custom event on a target element.
	Useful for simulating events that don't have dedicated step classes."
	<gtExample>
	| aScripter container element |
	element := BlElement new
			id: #testElement;
			size: 100 @ 100;
			addEventHandlerOn: BlMouseEnterEvent do: [ :e |
				e currentTarget background: Color green ].
	container := BrFrame new
			matchParent;
			addChild: element.
	aScripter := self scripter.
	aScripter element: container.
	aScripter fire
		label: 'Fire mouse enter';
		mouseEnter;
		id: #testElement;
		play.
	aScripter assertStep: [ :s |
		s
			label: 'Assert background changed to green';
			value: [ :el | el background paint color ]
				equals: [ Color green ];
			id: #testElement ].
	^ aScripter
]

{ #category : #examples }
BlScripterFireEventStepUsageExamples >> fireMouseLeaveEvent [
	"Demonstrates firing a mouse leave event.
	Useful for testing hover-out behavior."
	<gtExample>
	| aScripter container element |
	element := BlElement new
			id: #testElement;
			size: 100 @ 100.
	container := BrFrame new
			matchParent;
			addChild: element.
	aScripter := self scripter.
	aScripter element: container.
	aScripter fire
		label: 'Fire mouse leave';
		mouseLeave;
		id: #testElement;
		play.
	^ aScripter
]

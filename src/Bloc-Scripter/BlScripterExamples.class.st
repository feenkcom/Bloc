"
I exemplify {{gtClass:BlDevScripter}}.

"
Class {
	#name : #BlScripterExamples,
	#superclass : #Object,
	#instVars : [
		'elementExamples'
	],
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #'examples - scripter' }
BlScripterExamples >> basicScripter [
	<gtExample>
	<return: #BlScripter>
	| aScript |
	aScript := BlScripter new.
	self assert: aScript events class equals: BlDevScripterEvents.
	self assert: aScript events isEmpty.
	^ aScript
]

{ #category : #'examples - click check' }
BlScripterExamples >> clickCheck [
	<gtExample>
	<return: #BlScripter>
	| anElement aScript |
	anElement := BlScripterElementExamples new containerWithRectangle.
	aScript := self basicScripter element: anElement.

	aScript clickStep: [ :s | s onChildAt: 1 ].

	aScript check clickStep: [ :s | s onChildAt: 1 ].

	^ aScript
]

{ #category : #'examples - documentation' }
BlScripterExamples >> clickOnRectangleElement [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterWithElement.
	aScripter clickStep: [ :s | s id: #'rectangle-element' ].

	^ aScripter
]

{ #category : #'examples - element' }
BlScripterExamples >> containerWithRectangle [
	<gtExample>
	<return: #BlElement>
	^ elementExamples containerWithRectangle
]

{ #category : #examples }
BlScripterExamples >> exampleClickButton [
	"Demonstrates the full scripter pattern: create, set element, act, assert."
	<gtExample>
	| aScripter |
	aScripter := BlScripter new.
	aScripter element: (BrFrame new
		matchParent;
		addChild: (BlElement new
			id: #myButton;
			size: 50 @ 50;
			addEventHandlerOn: BlClickEvent do: [ :e |
				e currentTarget background: Color green ])).
	aScripter clickStep: [ :s | s id: #myButton ].
	aScripter assertStep: [ :s |
		s
			label: 'Assert background is green';
			satisfies: [ :el | el background paint color = Color green ];
			id: #myButton ].
	^ aScripter
]

{ #category : #'examples - click check' }
BlScripterExamples >> failingClickCheck [
	<gtExample>
	<return: #BlScripter>
	| anElement aScripter aScriptFailed |
	anElement := BlScripterElementExamples new containerWithRectangle.

	aScripter := self basicScripter element: anElement.

	aScripter clickStep: [ :s | s onChildAt: 1 ].

	aScriptFailed := false.
	[ aScripter check click play ]
		on: AssertionFailure
		do: [ :anException | aScriptFailed := true ].

	self assert: aScriptFailed description: 'The script must fail'.

	^ aScripter
]

{ #category : #initialization }
BlScripterExamples >> initialize [
	super initialize.
	elementExamples := BlScripterElementExamples new.
]

{ #category : #'examples - documentation' }
BlScripterExamples >> newScripter [
	<gtExample>
	<return: #BlScripter>
	^ BlScripter new
]

{ #category : #'examples - documentation' }
BlScripterExamples >> scripterWithElement [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self newScripter.
	aScripter element: self containerWithRectangle.
	^ aScripter
]

{ #category : #examples }
BlScripterExamples >> scripterWithModel [
	"Demonstrates setting a model on scripter and asserting on it."
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self newScripter.
	aScripter model: 42.
	aScripter element: self containerWithRectangle.
	aScripter assertStep: [ :s |
		s
			label: 'Assert model is 42';
			value: [ :aModel | aModel ] equals: [ 42 ];
			onModel ].
	^ aScripter
]

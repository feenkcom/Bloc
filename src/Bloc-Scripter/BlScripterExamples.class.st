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
	| aScript |
	aScript := BlScripter new.
	self assert: aScript events class equals: BlDevScripterEvents.
	self assert: aScript events isEmpty.
	^ aScript
]

{ #category : #'examples - click check' }
BlScripterExamples >> clickCheck [
	<gtExample>
	| anElement aScript |
	anElement := BlScripterElementExamples new containerWithRectangle.
	aScript := self basicScripter element: anElement.

	aScript
		clickStep: [ :s | 
			s
				onChildAt: 1 ].

	aScript check
		clickStep: [ :s | 
			s
				onChildAt: 1 ].

	^ aScript
]

{ #category : #'examples - documentation' }
BlScripterExamples >> clickOnRectangleElement [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement.
	aScripter
		clickStep: [ :s | 
			s
				id: #'rectangle-element' ].

	^ aScripter
]

{ #category : #'examples - element' }
BlScripterExamples >> containerWithRectangle [
	<gtExample>

	^ elementExamples containerWithRectangle
]

{ #category : #'examples - click check' }
BlScripterExamples >> failingClickCheck [
	<gtExample>
	| anElement aScripter aScriptFailed |
	anElement := BlScripterElementExamples new containerWithRectangle.

	aScripter := self basicScripter element: anElement.

	aScripter
		clickStep: [ :s | 
			s
				onChildAt: 1 ].

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

	^ BlScripter new
]

{ #category : #'examples - documentation' }
BlScripterExamples >> scripterWithElement [
	<gtExample>
	| aScripter |

	aScripter := self newScripter.
	aScripter element: self containerWithRectangle.

	^ aScripter
]

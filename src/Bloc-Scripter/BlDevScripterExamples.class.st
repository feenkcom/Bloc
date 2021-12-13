"
I exemplify {{gtClass:BlDevScripter}}.

"
Class {
	#name : #BlDevScripterExamples,
	#superclass : #Object,
	#instVars : [
		'elementExamples'
	],
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #'examples - scripter' }
BlDevScripterExamples >> basicScripter [
	<gtExample>
	| aScript |
	aScript := BlDevScripter new.
	self assert: aScript events class equals: BlDevScripterEvents.
	self assert: aScript events isEmpty.
	^ aScript
]

{ #category : #'examples - click check' }
BlDevScripterExamples >> clickCheck [
	<gtExample>
	| anElement aScript |

	anElement := BlDevElementExamples new containerWithRectangle.
	aScript := self basicScripter element: anElement.

	aScript click
		onChildAt: 1;
		play.

	aScript check click
		onChildAt: 1;
		play.

	^ aScript
]

{ #category : #'examples - documentation' }
BlDevScripterExamples >> clickOnRectangleElement [
	<gtExample>
	| aScripter |
	
	aScripter := self scripterWithElement.
	aScripter click
		id: #'rectangle-element';
		play.

	^ aScripter
]

{ #category : #'examples - element' }
BlDevScripterExamples >> containerWithRectangle [
	<gtExample>

	^ elementExamples containerWithRectangle
]

{ #category : #'examples - click check' }
BlDevScripterExamples >> failingClickCheck [
	<gtExample>
	| anElement aScripter aScriptFailed |

	anElement := BlDevElementExamples new containerWithRectangle.

	aScripter := self basicScripter element: anElement.

	aScripter click onChildAt: 1; play.

	aScriptFailed := false.
	[ aScripter check click play ] 
		on: AssertionFailure 
		do: [ :anException | aScriptFailed := true ].

	self assert: aScriptFailed description: 'The script must fail'.

	^ aScripter
]

{ #category : #initialization }
BlDevScripterExamples >> initialize [
	super initialize.
	elementExamples := BlDevElementExamples new.
]

{ #category : #'examples - documentation' }
BlDevScripterExamples >> newScripter [
	<gtExample>

	^ BlDevScripter new
]

{ #category : #'examples - documentation' }
BlDevScripterExamples >> scripterWithElement [
	<gtExample>
	| aScripter |

	aScripter := self newScripter.
	aScripter element: self containerWithRectangle.

	^ aScripter
]

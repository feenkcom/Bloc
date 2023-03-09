Class {
	#name : #BlScripterElementExamples,
	#superclass : #Object,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #'examples - element' }
BlScripterElementExamples >> container [
	<gtExample>
	| anElement |
	anElement := self element.
	anElement
		layout: BlFrameLayout new;
		size: 200@200;
		background: Color white;
		border: (BlBorder paint: Color blue width: 2).
	^ anElement
]

{ #category : #'examples - element' }
BlScripterElementExamples >> containerWithRectangle [
	<gtExample>
	| anElement |
	anElement := self container.
	anElement
		addChild: self rectangle.
	^ anElement
]

{ #category : #'examples - element' }
BlScripterElementExamples >> element [
	<gtExample>
	^ BlElement new
]

{ #category : #'examples - element' }
BlScripterElementExamples >> rectangle [
	<gtExample>
	| anElement |
	anElement := self element.
	anElement
		size: 100@100;
		id: #'rectangle-element';
		background: Color gray;
		border: (BlBorder paint: Color black width: 2);
		constraintsDo: [ :c | 
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	^ anElement
]

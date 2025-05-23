"
I am a collection of event dispatcher examples

"
Class {
	#name : #BlEventDispatcherExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-EventHandling'
}

{ #category : #examples }
BlEventDispatcherExamples >> directDispatcher [
	<gtExample>
	<return: #BlDirectEventDispatcher>
	^ BlDirectEventDispatcher on: BlElement new
]

{ #category : #examples }
BlEventDispatcherExamples >> directDispatcherWithMouseDownFilter [
	<gtExample>
	<return: #BlDirectEventDispatcher>
	| aDispatcher |
	aDispatcher := self directDispatcher.
	aDispatcher addEventFilter: (BlEventFilter on: BlMouseDownEvent).

	^ aDispatcher
]

{ #category : #examples }
BlEventDispatcherExamples >> directDispatcherWithMouseDownFilterAndHandler [
	<gtExample>
	<return: #BlDirectEventDispatcher>
	| aDispatcher mouseDownHandled |
	aDispatcher := self directDispatcherWithMouseDownFilter.

	mouseDownHandled := false.

	aDispatcher
		addEventHandler: (BlEventHandler on: BlMouseDownEvent do: [ mouseDownHandled := true ]).
	aDispatcher dispatchEvent: BlMouseDownEvent primary.

	self assert: mouseDownHandled not.

	^ aDispatcher
]

{ #category : #examples }
BlEventDispatcherExamples >> directDispatcherWithMouseDownFilterAndHandlerWithMouseUpHandler [
	<gtExample>
	<return: #BlDirectEventDispatcher>
	| aDispatcher mouseUpHandled |
	aDispatcher := self directDispatcherWithMouseDownFilterAndHandler.

	mouseUpHandled := false.

	aDispatcher
		addEventHandler: (BlEventHandler on: BlMouseUpEvent do: [ mouseUpHandled := true ]).
	aDispatcher dispatchEvent: BlMouseUpEvent primary.

	self assert: mouseUpHandled.

	^ aDispatcher
]

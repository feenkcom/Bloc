"
This class contains tests

"
Class {
	#name : #BlKeyboardProcessorExamples,
	#superclass : #Object,
	#instVars : [
		'processor',
		'space'
	],
	#category : #'Bloc-Tests-Universe'
}

{ #category : #tests }
BlKeyboardProcessorExamples >> processKeyDown [
	<gtExample>
	| eventA |

	eventA := BlKeyDownEvent new.
	eventA key: BlKeyboardKey a.
	space := BlSpace new.
	processor := BlKeyboardProcessor new.
	processor space: space.
	processor processKeyDown: eventA.
	self assert: processor keystrokesAllowed.
	self assert: (processor buffer hasEvent: BlKeyboardKey a).
	^ processor
]

{ #category : #tests }
BlKeyboardProcessorExamples >> repeatedShortcuts [
	<gtExample>
	<noTest>
	<return: #BlScripter>
	| blue scripter |
	blue := BlExampleEventsCountingElement new background: Color blue.
	blue beFocusable.
	blue requestFocus.
	scripter := BlScripter new element: blue.
	scripter space time: BlTime simulated.

	scripter space dispatchEvent: (BlKeyDownEvent new key: BlKeyboardKey v).

	scripter space time
		wait: BlKeyboardProcessor shortcutRepeatDelay - 1 milliseconds.
	scripter pulse.
	self
		assert: (blue uiEventsClasses allButFirst: 2)
		equals: {BlKeyDownEvent.
				BlShortcutEvent}.

	scripter space time wait: 1 second.
	scripter pulse.
	self
		assert: (blue uiEventsClasses allButFirst: 2)
		equals: {BlKeyDownEvent.
				BlShortcutEvent.
				BlShortcutEvent}.

	scripter space time wait: BlKeyboardProcessor shortcutRepeatInterval.
	self
		assert: (blue uiEventsClasses allButFirst: 2)
		equals: {BlKeyDownEvent.
				BlShortcutEvent.
				BlShortcutEvent.
				BlShortcutEvent}.

	^ scripter
]

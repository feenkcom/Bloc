Class {
	#name : #BlMouseProcessorClickExamples,
	#superclass : #BlMouseProcessorExamples,
	#category : #'Bloc-Examples-Event'
}

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> click [
	<gtExample>
	| aScripter |
	aScripter := self mouseEnter.

	aScripter
		substeps: 'Click'
		do: [ :aStep | 
			aStep mouseDown.
			aStep mouseUp.
			aStep play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check last click event is not nil';
						satisfies: [ :aMouseProcessor | aMouseProcessor lastClickEvent isNotNil ];
						onMouseProcessor ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check last click event is ClickEvent';
						satisfies: [ :aMouseProcessor | aMouseProcessor lastClickEvent isKindOf: BlClickEvent ];
						onMouseProcessor ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check last click event has correct target';
						satisfies: [ :aMouseProcessor | aMouseProcessor lastClickEvent target = aScripter element ];
						onMouseProcessor ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check element was clicked';
						satisfies: [ :anElement | anElement clickCount = 1 ];
						onSelf ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> doubleClickButTargetIsReplacedAfterFirstClick [
	<gtExample>
	| container blue red scripter |

	blue := BlExampleEventsCountingElement new
		size: 80@80;
		relocate: 20@20;
		background: (Color blue alpha: 0.7).
			
	red := BlExampleEventsCountingElement new
		size: 80@80;
		relocate: 20@20;
		background: (Color red alpha: 0.7).

	container := BlElement new
		size: 120@120;
		addChild: blue.

	blue
		when: BlClickEvent
		do: [ container replaceChild: blue with: red ].

	scripter := BlScripter new
		element: container.

	scripter space time: BlTime simulated.
		
	scripter space dispatchEvent: (BlMouseDownEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).

	scripter space time wait: Bloc doubleClickDelay / 4.
		
	scripter space dispatchEvent: (BlMouseUpEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).

	scripter play.

	scripter space time wait: Bloc doubleClickDelay / 4.
		
	scripter space dispatchEvent: (BlMouseDownEvent primary
		position: red bounds inSpace center;
		timestamp: scripter space time now).

	scripter space time wait: Bloc doubleClickDelay / 4.
		
	scripter space dispatchEvent: (BlMouseUpEvent primary
		position: red bounds inSpace center;
		timestamp: scripter space time now).
	
	self assert:  blue uiEventsClasses equals:  {
		BlMouseDownEvent.
		BlMouseUpEvent.
		BlClickEvent.
	}.
	
	self assert:  red uiEventsClasses equals:  {
		BlMouseDownEvent.
		BlMouseDoublePressEvent.
		BlMouseUpEvent.
		BlClickEvent.
		BlDoubleClickEvent.
	}.

	^ scripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> doubleClickOutsideOfTimeDelay [
	<gtExample>
	| blue scripter |

	blue := BlExampleEventsCountingElement new
			size: 80@80;
			relocate: 20@20;
			background: (Color blue alpha: 0.7).

	scripter := BlScripter new
		element: blue.
		
	scripter space time: BlTime simulated.
		
	scripter space dispatchEvent: (BlMouseDownEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).

	scripter space time wait: Bloc doubleClickDelay / 4.
		
	scripter space dispatchEvent: (BlMouseUpEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).
		
	scripter space time wait: Bloc doubleClickDelay * 2.
		
	scripter space dispatchEvent: (BlMouseDownEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).

	scripter space time wait: Bloc doubleClickDelay / 4.
		
	scripter space dispatchEvent: (BlMouseUpEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).
	
	self assert:  blue uiEventsClasses equals:  {
		BlMouseDownEvent.
		BlMouseUpEvent.
		BlClickEvent.
		BlMouseDownEvent.
		BlMouseUpEvent.
		BlClickEvent.
	}.
		
	^ scripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> doubleClickWithinTimeDelay [
	<gtExample>
	| blue scripter |

	blue := BlExampleEventsCountingElement new
			size: 80@80;
			relocate: 20@20;
			background: (Color blue alpha: 0.7).

	scripter := BlScripter new
		element: blue.
		
	scripter space time: BlTime simulated.
		
	scripter space dispatchEvent: (BlMouseDownEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).

	scripter space time wait: Bloc doubleClickDelay / 4.
		
	scripter space dispatchEvent: (BlMouseUpEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).
		
	scripter space time wait: Bloc doubleClickDelay / 4.
		
	scripter space dispatchEvent: (BlMouseDownEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).

	scripter space time wait: Bloc doubleClickDelay / 4.
		
	scripter space dispatchEvent: (BlMouseUpEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).
	
	self assert:  blue uiEventsClasses equals:  {
		BlMouseDownEvent.
		BlMouseUpEvent.
		BlClickEvent.
		BlMouseDownEvent.
		BlMouseDoublePressEvent.
		BlMouseUpEvent.
		BlClickEvent.
		BlDoubleClickEvent.
	}.

	^ scripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> mouseDown [
	<gtExample>
	| aScripter |
	aScripter := self mouseEnter.

	aScripter
		substeps: 'Click'
		do: [ :aStep | 
			aStep
				mouseDown;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check previous mouse down event';
						value: [ :aMouseProcessor | aMouseProcessor previousMouseDownEvent target ]
							equals: [ aScripter element ];
						onMouseProcessor ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check last over target is the element';
						value: [ :aMouseProcessor | aMouseProcessor lastOverTarget ]
							equals: [ aScripter element ];
						onMouseProcessor ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check entered targets';
						value: [ :aMouseProcessor | aMouseProcessor enteredTargets ]
							equals: [ {aScripter element.
									aScripter root} ];
						onMouseProcessor ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> mouseEnter [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: self scripterElement.

	aScripter
		substeps: 'Mouse Enter'
		do: [ :aStep | 
			aStep mouseMove
				by: 30 @ 30;
				play.

			aStep mouseMove
				by: 70 @ 60;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check last over target is the element';
						value: [ :aMouseProcessor | aMouseProcessor lastOverTarget ]
							equals: [ aScripter element ];
						onMouseProcessor ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check entered targets';
						value: [ :aMouseProcessor | aMouseProcessor enteredTargets ]
							equals: [ {aScripter element.
									aScripter root} ];
						onMouseProcessor ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> scripterElement [
	<gtExample>
	
	^ BlExampleEventsCountingElement new
		size: 100@75;
		relocate: 50@50
]

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> twoQuickConsecutiveClicksOnDifferentElements [
	<gtExample>
	| container red blue scripter |
	
	container := BlElement new
		size: 220@120;
		background: (Color veryVeryLightGray alpha: 0.5);
		addChild: (red := BlExampleEventsCountingElement new
			size: 80@80;
			relocate: 20@20;
			background: (Color red alpha: 0.7);
			id: #red);
		addChild: (blue := BlExampleEventsCountingElement new
			size: 80@80;
			relocate: 120@20;
			background: (Color blue alpha: 0.7);
			id: #blue).

	scripter := BlScripter new
		element: container.
		
	scripter space time: BlTime simulated.
		
	scripter space dispatchEvent: (BlMouseDownEvent primary
		position: red bounds inSpace center;
		timestamp: scripter space time now).

	scripter space time wait: Bloc doubleClickDelay / 10.
		
	scripter space dispatchEvent: (BlMouseUpEvent primary
		position: red bounds inSpace center;
		timestamp: scripter space time now).
	
	scripter space time wait: Bloc doubleClickDelay / 10.
	
	scripter space dispatchEvent: (BlMouseDownEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).

	scripter space time wait: Bloc doubleClickDelay / 10.

	scripter space dispatchEvent: (BlMouseUpEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).

	self assert:  red uiEventsClasses equals:  {
		BlMouseDownEvent.
		BlMouseUpEvent.
		BlClickEvent.
	}.
	
	self assert:  blue uiEventsClasses equals:  {
		BlMouseDownEvent.
		BlMouseUpEvent.
		BlClickEvent.
	}.
		
	^ scripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> twoSlowConsecutiveClicksOnDifferentElements [
	<gtExample>
	| container red blue scripter |

	container := BlElement new
		size: 220@120;
		background: (Color veryVeryLightGray alpha: 0.5);
		addChild: (red := BlExampleEventsCountingElement new
			size: 80@80;
			relocate: 20@20;
			background: (Color red alpha: 0.7);
			id: #red);
		addChild: (blue := BlExampleEventsCountingElement new
			size: 80@80;
			relocate: 120@20;
			background: (Color blue alpha: 0.7);
			id: #blue).

	scripter := BlScripter new
		element: container.

	scripter space time: BlTime simulated.
		
	scripter space dispatchEvent: (BlMouseDownEvent primary
		position: red bounds inSpace center;
		timestamp: scripter space time now).

	scripter space time wait: Bloc doubleClickDelay * 2.

	scripter space dispatchEvent: (BlMouseUpEvent primary
		position: red bounds inSpace center;
		timestamp: scripter space time now).
	
	scripter space time wait: Bloc doubleClickDelay * 2.
	
	scripter space dispatchEvent: (BlMouseDownEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).

	scripter space time wait: Bloc doubleClickDelay * 2.

	scripter space dispatchEvent: (BlMouseUpEvent primary
		position: blue bounds inSpace center;
		timestamp: scripter space time now).
		
	self assert:  red uiEventsClasses equals:  {
		BlMouseDownEvent.
		BlMouseUpEvent.
		BlClickEvent.
	}.
	
	self assert:  blue uiEventsClasses equals:  {
		BlMouseDownEvent.
		BlMouseUpEvent.
		BlClickEvent.
	}.

	^ scripter
]

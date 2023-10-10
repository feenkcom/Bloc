Class {
	#name : #BlMouseProcessorEnterLeaveExamples,
	#superclass : #BlMouseProcessorExamples,
	#category : #'Bloc-Examples-Event'
}

{ #category : #'examples - scripter' }
BlMouseProcessorEnterLeaveExamples >> mouseEnter [
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
						label: 'Check mouse enter fired';
						value: [ :anElement | anElement mouseEnterCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse over fired';
						value: [ :anElement | anElement mouseOverCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse move fired';
						value: [ :anElement | anElement mouseMoveCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check entered targets';
						value: [ :aMouseProcessor | aMouseProcessor enteredTargets ]
							equals: {aScripter element.
									aScripter root};
						onMouseProcessor ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorEnterLeaveExamples >> mouseLeave [
	<gtExample>
	| aScripter |
	aScripter := self mouseEnter.

	aScripter
		substeps: 'Mouse Leave'
		do: [ :aStep | 
			aStep mouseMove
				by: 100 @ 20;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse leave fired';
						value: [ :anElement | anElement mouseLeaveCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse out fired';
						value: [ :anElement | anElement mouseOutCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse move not fired';
						value: [ :anElement | anElement mouseMoveCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check entered targets';
						value: [ :aMouseProcessor | aMouseProcessor enteredTargets ]
							equals: {aScripter root};
						onMouseProcessor ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorEnterLeaveExamples >> mouseLeaveDueToRemovalFromScene [
	<gtExample>
	| aScripter |
	aScripter := self mouseEnter.

	aScripter
		substeps: 'Remove from scene graph'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						block: [ :anElement | anElement removeFromParent ];
						onSelf ] ].

	aScripter
		substeps: 'Pulse one time to generate mouse leave events'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						block: [ :theScripter | theScripter pulse ];
						onScripter ] ].

	aScripter
		substeps: 'Check that events are fired'
		do: [ :aStep | 
			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse leave fired';
						value: [ :anElement | anElement mouseLeaveCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse out fired';
						value: [ :anElement | anElement mouseOutCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse move not fired';
						value: [ :anElement | anElement mouseMoveCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check entered targets';
						value: [ :aMouseProcessor | aMouseProcessor enteredTargets ]
							equals: {aScripter root};
						onMouseProcessor ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorEnterLeaveExamples >> scripterElement [
	<gtExample>
	
	^ BlExampleEventsCountingElement new
		size: 100@75;
		relocate: 50@50
]

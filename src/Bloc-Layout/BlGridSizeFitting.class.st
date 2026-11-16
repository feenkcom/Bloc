"
Executes the grid axis child-size fitting search. Retains candidate steps, including infeasible alternatives. Inputs are copied so the explanation survives subsequent layout passes. Feasibility is supplied by the grid constraint solver; a feasible candidate remains provisional until selected.
"
Class {
	#name : #BlGridSizeFitting,
	#superclass : #Object,
	#instVars : [
		'preferredSizes',
		'minimumSizes',
		'limited',
		'steps',
		'selectedStep',
		'result',
		'outcome',
		'feasibility',
		'availableSpace',
		'childMargins',
		'childSpans',
		'axisName'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #presentation }
BlGridSizeFitting >> asStepsFigure [
	"Virtualized list of attempt diagrams. Preserve each step's own visual styling and tooltip."

	^ BrSimpleList vertical
		matchParent;
		itemStencil: [ BrFrame new
				hMatchParent;
				vFitContent ];
		itemDataBinder: [ :container :step :index | 
			container removeChildren.
			container
				addChild: (step asElementWithMaximum: self figureMaximum selected: step == selectedStep) ];
		items: steps
]

{ #category : #presentation }
BlGridSizeFitting >> asTooltipElement [
	^ self
		tooltipElementTitled: 'Child-size fitting'
		lines: {'Outcome: ' , outcome asString.
				self explanation.
				'Rounded children can shrink; rectangles are fixed or at minimum.'.
				'Accept icon: selected result. Blue bounds: search completed.'}
]

{ #category : #accessing }
BlGridSizeFitting >> availableSpace [
	^ availableSpace
]

{ #category : #initialization }
BlGridSizeFitting >> availableSpace: aNumber margins: margins [
	availableSpace := aNumber.
	childMargins := margins copy
]

{ #category : #presentation }
BlGridSizeFitting >> capacityHeightFor: aStep [
	^ (self diagramHeightFor: aStep) - 4
]

{ #category : #presentation }
BlGridSizeFitting >> capacityTopFor: aStep [
	^ 20
]

{ #category : #accessing }
BlGridSizeFitting >> childMargins [
	^ childMargins ifNil: [ Array new: preferredSizes size withAll: 0 ]
]

{ #category : #presentation }
BlGridSizeFitting >> childOffsetAt: index in: aStep [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlGridSizeFitting >> childSpans [
	^ childSpans
]

{ #category : #accessing }
BlGridSizeFitting >> childSpans: spans axis: aSymbol [
	"Snapshot grid-line indices: start inclusive, end exclusive."

	childSpans := (spans collect: #copy) asArray.
	axisName := aSymbol
]

{ #category : #presentation }
BlGridSizeFitting >> childYAt: index [
	^ self subclassResponsibility
]

{ #category : #presentation }
BlGridSizeFitting >> decisionTextFor: aStep [
	| label |
	label := aStep == selectedStep
			ifTrue: [ 'Selected' ]
			ifFalse: [ aStep feasible ifTrue: [ 'Feasible' ] ifFalse: [ 'Infeasible' ] ].
	^ label asRopedText foreground: (self stepColorFor: aStep)
]

{ #category : #presentation }
BlGridSizeFitting >> diagramHeightFor: aStep [
	^ self subclassResponsibility
]

{ #category : #presentation }
BlGridSizeFitting >> explanation [
	^ self subclassResponsibility
]

{ #category : #presentation }
BlGridSizeFitting >> figureMaximum [
	"Keep every candidate and the capacity boundary on the same visual scale."

	^ (preferredSizes sum + self childMargins sum max: 1)
		max: (availableSpace ifNil: [ 0 ])
]

{ #category : #'gt-views' }
BlGridSizeFitting >> gtChildrenFor: aView [
	"Which children shrink and which minimum sizes constrain them?"

	<gtView>
	^ aView columnedList
		title: 'Children';
		priority: 3;
		items: [ 1 to: preferredSizes size ];
		column: 'Child' text: #yourself;
		column: 'Limited' text: [ :index | limited at: index ];
		column: 'Preferred' text: [ :index | preferredSizes at: index ];
		column: 'Minimum' text: [ :index | minimumSizes at: index ];
		column: 'Result' text: [ :index | result at: index ]
]

{ #category : #'gt-views' }
BlGridSizeFitting >> gtExplanationFor: aView [
	"What interpretation of requirements is valid for this fitting variation?"

	<gtView>
	^ aView textEditor
		title: 'Explanation';
		priority: 4;
		text: [ self explanation ]
]

{ #category : #'gt-views' }
BlGridSizeFitting >> gtStepsFigureFor: aView [
	"How does each attempt compare with capacity? Zoom to compare candidates. Sequential spans are stacked; shared spans are separate requirement lanes, not solved placements."

	<gtView>
	^ aView explicit
		title: 'Steps figure';
		priority: 1;
		stencil: [ self asStepsFigure ]
]

{ #category : #'gt-views' }
BlGridSizeFitting >> gtStepsFor: aView [
	"How do requirements evolve under this fitting model? The solver decision is independent of how requirements are presented."

	<gtView>
	^ aView columnedList
		title: 'Steps';
		priority: 2;
		items: [ self steps ];
		column: 'Phase'
			text: #phase
			width: 80;
		column: 'Scale' text: #scale;
		column: 'Lower before' text: #lower;
		column: 'Upper before' text: #upper;
		column: 'Decision'
			text: [ :step | self decisionTextFor: step ]
			width: 80;
		column: self requirementsTitle text: [ :step | self sizesTextFor: step ]
]

{ #category : #accessing }
BlGridSizeFitting >> isSequential [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlGridSizeFitting >> limited [
	^ limited
]

{ #category : #accessing }
BlGridSizeFitting >> minimumSizes [
	^ minimumSizes
]

{ #category : #accessing }
BlGridSizeFitting >> outcome [
	^ outcome
]

{ #category : #initialization }
BlGridSizeFitting >> preferred: preferred minima: minima limited: flags feasibility: aBlock [
	preferredSizes := preferred copy.
	minimumSizes := minima copy.
	limited := flags copy.
	feasibility := aBlock
]

{ #category : #accessing }
BlGridSizeFitting >> preferredSizes [
	^ preferredSizes
]

{ #category : #presentation }
BlGridSizeFitting >> requirementsExpressionFor: aStep [
	"Each child requires space over its own span. Never sum overlapping requirements or compare them with whole-axis capacity as a feasibility test."

	^ String
		streamContents: [ :stream | 
			aStep sizes
				withIndexDo: [ :size :index | 
					index > 1 ifTrue: [ stream nextPutAll: '; ' ].
					stream
						nextPutAll: 'child ';
						print: index;
						nextPutAll: ': '.
					childSpans
						ifNotNil: [ | span |
							span := childSpans at: index.
							stream
								nextPutAll: (axisName = #horizontal ifTrue: [ 'columns ' ] ifFalse: [ 'rows ' ]);
								print: span first;
								nextPutAll: '..';
								print: span second;
								nextPutAll: ' (end exclusive) >= ' ].
					stream print: size.
					(self childMargins at: index) isZero
						ifFalse: [ stream
								nextPutAll: ' + ';
								print: (self childMargins at: index);
								nextPutAll: ' margins' ] ] ]
]

{ #category : #presentation }
BlGridSizeFitting >> requirementsTitle [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlGridSizeFitting >> result [
	^ result
]

{ #category : #computation }
BlGridSizeFitting >> run [
	| lower upper middle candidate |
	steps := OrderedCollection new.
	selectedStep := nil.
	result := preferredSizes copy.
	[ (limited includes: true)
		ifFalse: [ outcome := #notLimited.
			^ self ].
	candidate := self
			testSizes: preferredSizes
			scale: 1
			lower: 0
			upper: 1
			phase: #preferred.
	candidate feasible
		ifTrue: [ selectedStep := candidate.
			outcome := #preferredFits.
			^ self ].
	candidate := self
			testSizes: (self sizesAtScale: 0)
			scale: 0
			lower: 0
			upper: 1
			phase: #minimum.
	candidate feasible
		ifFalse: [ outcome := #minimumDoesNotFit.
			^ self ].
	selectedStep := candidate.
	lower := 0.0.
	upper := 1.0.
	[ middle := (lower + upper) / 2.
	middle > lower and: [ middle < upper ] ]
		whileTrue: [ candidate := self
					testSizes: (self sizesAtScale: middle)
					scale: middle
					lower: lower
					upper: upper
					phase: #search.
			candidate feasible
				ifTrue: [ lower := middle.
					selectedStep := candidate ]
				ifFalse: [ upper := middle ] ].
	result := selectedStep sizes copy.
	outcome := #fitted ] ensure: [ feasibility := nil ].
	^ self
]

{ #category : #accessing }
BlGridSizeFitting >> selectedStep [
	^ selectedStep
]

{ #category : #private }
BlGridSizeFitting >> sizesAtScale: aScale [
	^ preferredSizes
		withIndexCollect: [ :size :index | 
			(limited at: index)
				ifTrue: [ size * aScale max: (minimumSizes at: index) ]
				ifFalse: [ size ] ]
]

{ #category : #presentation }
BlGridSizeFitting >> sizesExpressionFor: aStep [
	^ self subclassResponsibility
]

{ #category : #presentation }
BlGridSizeFitting >> sizesTextFor: aStep [
	^ (self sizesExpressionFor: aStep) asRopedText
		foreground: (self stepColorFor: aStep)
]

{ #category : #presentation }
BlGridSizeFitting >> solverDiagramFor: step maximum: maximum selected: selected [
	^ nil
]

{ #category : #presentation }
BlGridSizeFitting >> stepColorFor: aStep [
	aStep == selectedStep ifTrue: [ ^ BrAntColors blue ].
	^ aStep feasible ifTrue: [ BrAntColors green5 ] ifFalse: [ BrAntColors red5 ]
]

{ #category : #accessing }
BlGridSizeFitting >> steps [
	^ steps
]

{ #category : #private }
BlGridSizeFitting >> testSizes: sizes scale: aScale lower: low upper: high phase: aPhase [
	| step answer |
	answer := feasibility value: sizes.
	step := BlGridSizeFittingStep new
			algorithm: self;
			sizes: sizes
				scale: aScale
				lower: low
				upper: high
				phase: aPhase
				feasible: (answer isBoolean ifTrue: [ answer ] ifFalse: [ answer feasible ]).
	answer isBoolean ifFalse: [ step evaluation: answer ].
	steps add: step.
	^ step
]

{ #category : #presentation }
BlGridSizeFitting >> tooltipElementTitled: aTitle lines: lines [
	| pane |
	pane := BrVerticalPane new
			fitContent;
			padding: (BlInsets all: 12).
	pane
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: aTitle asRopedText bold;
				margin: (BlInsets bottom: 8)).
	lines
		do: [ :line | 
			pane
				addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: line;
						margin: (BlInsets bottom: 3)) ].
	^ pane
]

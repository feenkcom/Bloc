"
Executable explanations of preferred-size acceptance, shrinking, minimum-size failure and real grid integration.
"
Class {
	#name : #BlGridSizeFittingExamples,
	#superclass : #Object,
	#category : #'Bloc-Layout-Examples'
}

{ #category : #examples }
BlGridSizeFittingExamples >> candidateStep [
	<gtExample>
	| step |
	step := self shrinking steps first.
	self assert: step phase equals: #preferred.
	self assert: step feasible not.
	self assert: step scale equals: 1.
	self assert: step sizes equals: #(20 1000).
	^ step
]

{ #category : #examples }
BlGridSizeFittingExamples >> compactSpanningDiagram [
	<gtExample>
	| fitting diagram |
	fitting := self solverEvidenceForSpans.
	diagram := fitting
			solverDiagramFor: fitting selectedStep
			maximum: fitting figureMaximum
			selected: true.
	diagram forceLayout.
	self assert: diagram width equals: 760.
	self assert: diagram children first width > 0.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> conditionsFollowSpans [
	<gtExample>
	| fitting step xs |
	fitting := self solverEvidenceForSpans.
	step := fitting steps first.
	xs := step evaluation locations
			collect: [ :x | x - step evaluation locations first ].
	1
		to: step sizes size
		do: [ :index | 
			| label span right |
			label := fitting
					conditionsLabelForChild: index
					in: step
					locations: xs
					origin: 0
					factor: 1
					y: 20.
			label forceLayout.
			span := fitting childSpans at: index.
			right := (xs at: span second + 1)
					max: (xs at: span first + 1) + (step sizes at: index)
							+ (fitting childMargins at: index).
			self assert: (label position x closeTo: right + 12).
			self assert: label position y equals: 20.
			self assert: label text asString lines size equals: 1 ].
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> fittingVariations [
	<gtExample>
	| sequential spanning |
	sequential := self shrinking.
	spanning := self overlappingSpanRequirements.
	self assert: sequential class equals: BlGridSequentialSizeFitting.
	self assert: spanning class equals: BlGridSpanningSizeFitting.
	self
		assert: (sequential childOffsetAt: 2 in: sequential steps first)
		equals: 20.
	self assert: (spanning childOffsetAt: 2 in: spanning steps first) equals: 0.
	self assert: sequential explanation ~= spanning explanation.
	^ {sequential.
		spanning}
]

{ #category : #examples }
BlGridSizeFittingExamples >> gridIntegration [
	<gtExample>
	| grid fitting |
	grid := BlGridLayoutExamples new exampleCellFitContentLimitedBelowHeader.
	fitting := grid layout sizeFittingForAxis: false.
	self assert: (fitting isKindOf: BlGridSizeFitting).
	self assert: fitting steps isNotEmpty.
	self assert: fitting selectedStep feasible.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> logicalBoundsConvergence [
	<gtExample>
	| fitting |
	fitting := self shrinking.
	fitting steps allButLast do: [ :step | self assert: step searchBoundsMeet not ].
	self assert: fitting steps last searchBoundsMeet.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> marginsFigure [
	<gtExample>
	| grid fitting |
	grid := BlGridLayoutExamples new
			exampleCellFitContentLimitedWithMarginsAndPadding.
	fitting := grid layout sizeFittingForAxis: false.
	self assert: fitting isSequential.
	self assert: fitting childMargins sum > 0.
	self
		assert: fitting selectedStep attemptedSpace <= (fitting availableSpace + 0.001).
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> minimumDoesNotFit [
	<gtExample>
	| fitting |
	fitting := BlGridSequentialSizeFitting new
			preferred: #(120 1000)
				minima: #(0 10)
				limited: #(false true)
				feasibility: [ :sizes | sizes sum <= 100 ];
			run.
	self assert: fitting outcome equals: #minimumDoesNotFit.
	self assert: fitting selectedStep isNil.
	self assert: fitting result equals: #(120 1000).
	self assert: fitting steps last sizes equals: #(120 10).
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> minimumIsRespected [
	<gtExample>
	| fitting |
	fitting := BlGridSequentialSizeFitting new
			preferred: #(20 1000 1000)
				minima: #(0 60 0)
				limited: #(false true true)
				feasibility: [ :sizes | sizes sum <= 100 ];
			run.
	self assert: fitting result second equals: 60.
	self assert: (fitting result third closeTo: 20).
	fitting steps
		do: [ :step | 
			self assert: step sizes first equals: 20.
			self assert: step sizes second >= 60 ].
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> notLimited [
	<gtExample>
	| fitting |
	fitting := BlGridSequentialSizeFitting new
			preferred: #(120)
				minima: #(0)
				limited: #(false)
				feasibility: [ :sizes | self error: 'Should not solve' ];
			run.
	self assert: fitting outcome equals: #notLimited.
	self assert: fitting steps isEmpty.
	self assert: fitting result equals: #(120).
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> overlappingSpanRequirements [
	<gtExample>
	| measurement fitting expression |
	measurement := BlGridMeasurementExamples new
			spanningMeasurementWithFittingOnBothAxes.
	fitting := (measurement steps at: 2) fitting.
	self assert: fitting isSequential not.
	self assert: fitting childSpans first equals: #(0 2).
	expression := fitting sizesExpressionFor: fitting steps first.
	self assert: (expression includesSubstring: 'columns 0..2').
	self assert: (expression includesSubstring: '; child 2:').
	self assert: (expression includesSubstring: 'sum is not feasibility') not.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> preferredFits [
	<gtExample>
	| fitting |
	fitting := BlGridSequentialSizeFitting new
			preferred: #(20 30)
				minima: #(0 0)
				limited: #(false true)
				feasibility: [ :sizes | sizes sum <= 100 ];
			run.
	self assert: fitting outcome equals: #preferredFits.
	self assert: fitting steps size equals: 1.
	self assert: fitting selectedStep == fitting steps first.
	self assert: fitting result equals: #(20 30).
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> sequentialSelectedMarker [
	<gtExample>
	| fitting selected unselected row |
	fitting := self shrinking.
	selected := fitting selectedStep
			asElementWithMaximum: fitting figureMaximum
			selected: true.
	unselected := fitting steps first
			asElementWithMaximum: fitting figureMaximum
			selected: false.
	selected forceLayout.
	unselected forceLayout.
	row := selected children first.
	self assert: (row children first isKindOf: BlScalableElement).
	self
		assert: row children second position x
		equals: unselected children first children second position x.
	self assert: row children size equals: 4.
	self assert: row children last children first children isEmpty.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> sharedSpanFigure [
	<gtExample>
	| grid fitting |
	grid := BlGridLayoutExamples new exampleCellsFitContentLimitedShareRow.
	fitting := grid layout sizeFittingForAxis: false.
	self assert: fitting isSequential not.
	self assert: fitting availableSpace > 0.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> shrinking [
	<gtExample>
	| fitting |
	fitting := BlGridSequentialSizeFitting new
			preferred: #(20 1000)
			minima: #(0 0)
			limited: #(false true)
			feasibility: [ :sizes | sizes sum <= 100 ].
	fitting
		availableSpace: 100 margins: #(0 0);
		run.
	self assert: fitting outcome equals: #fitted.
	self assert: fitting result first equals: 20.
	self assert: (fitting result second closeTo: 80).
	self assert: fitting selectedStep feasible.
	self assert: fitting steps first attemptedSpace > fitting availableSpace.
	self assert: fitting selectedStep attemptedSpace <= fitting availableSpace.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> solverEvidenceForSpans [
	<gtExample>
	| fitting |
	fitting := self overlappingSpanRequirements.
	fitting steps
		do: [ :step | 
			self assert: step evaluation notNil.
			self assert: step evaluation feasible equals: step feasible.
			step feasible
				ifTrue: [ self assert: step evaluation violations isEmpty ]
				ifFalse: [ self assert: step evaluation violations isNotEmpty ] ].
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> solverOriginTranslation [
	<gtExample>
	| fitting step shifted originalLocations original shiftedDiagram |
	fitting := self solverEvidenceForSpans.
	step := fitting steps first.
	originalLocations := step evaluation locations copy.
	shifted := BlGridSizeFittingStep new
			algorithm: fitting;
			sizes: step sizes
				scale: step scale
				lower: step lower
				upper: step upper
				phase: step phase
				feasible: step feasible;
			evaluation: (BlGridFittingEvaluation new
					feasible: step feasible
					locations: (originalLocations collect: [ :x | x + 1000 ])
					constraints: step evaluation constraints).
	original := fitting
			solverDiagramFor: step
			maximum: fitting figureMaximum
			selected: false.
	shiftedDiagram := fitting
			solverDiagramFor: shifted
			maximum: fitting figureMaximum
			selected: false.
	original forceLayout.
	shiftedDiagram forceLayout.
	self
		assert: original children first position x
		equals: original children second position x.
	original children
		withIndexDo: [ :left :index | 
			| right |
			right := shiftedDiagram children at: index.
			self assert: (left position closeTo: right position).
			self assert: (left extent closeTo: right extent) ].
	self assert: step evaluation locations equals: originalLocations.
	self assert: step evaluation violations equals: shifted evaluation violations.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> spanningCapacityLabel [
	<gtExample>
	| fitting diagram label background |
	fitting := self solverEvidenceForSpans.
	diagram := fitting
			solverDiagramFor: fitting steps first
			maximum: fitting figureMaximum
			selected: false.
	diagram forceLayout.
	background := diagram children first.
	label := diagram children last.
	self assert: label text asString equals: fitting availableSpace printString.
	self
		assert: (label position x + (label width / 2)
				closeTo: background position x + (background width / 2)).
	self assert: label position y >= 0.
	self assert: label position y + label height <= diagram height.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> spanningMarginRequirements [
	<gtExample>
	| measurement fitting step covered |
	measurement := BlGridMeasurementExamples new measurementWithStaggeredSpans.
	fitting := (measurement steps at: 4) fitting.
	self assert: fitting childMargins sum > 0.
	step := fitting steps first.
	covered := OrderedCollection new.
	1
		to: step sizes size
		do: [ :index | covered addAll: (fitting constraintsForChild: index in: step) ].
	covered addAll: (fitting remainingConstraintsFor: step).
	self
		assert: (step evaluation constraints allSatisfy: [ :triple | covered includes: triple ]).
	self
		assert: (fitting
				solverDiagramFor: step
				maximum: fitting figureMaximum
				selected: false) notNil.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> spanningRulerCapacityAlignment [
	<gtExample>
	| fitting |
	fitting := self solverEvidenceForSpans.
	fitting steps
		do: [ :step | 
			| diagram ruler background track |
			diagram := fitting
					solverDiagramFor: step
					maximum: fitting figureMaximum
					selected: false.
			ruler := step searchBoundsElement.
			diagram forceLayout.
			ruler forceLayout.
			background := diagram children first.
			track := ruler children first.
			self assert: track position y equals: background position y.
			self assert: track height equals: background height ].
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> spanningSelectedMarker [
	<gtExample>
	| fitting element row icon unselected |
	fitting := self solverEvidenceForSpans.
	element := fitting selectedStep
			asElementWithMaximum: fitting figureMaximum
			selected: true.
	element forceLayout.
	row := element children first.
	icon := row children first.
	self assert: (icon isKindOf: BlScalableElement).
	self assert: (icon width closeTo: 32).
	self assert: icon position x < row children second position x.
	unselected := fitting steps first
			asElementWithMaximum: fitting figureMaximum
			selected: false.
	unselected forceLayout.
	self assert: row children size equals: unselected children first children size.
	self
		assert: row children second position x
		equals: unselected children first children second position x.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> spanningSizeFitting [
	"Two columns: child 1 spans both; child 2 occupies the first; fixed child 3 occupies the second. Feasibility is max(spanning requirement, sum of single-column requirements), NOT the sum of all three. No margins or alignment offsets in this isolated example."

	<gtExample>
	| fitting |
	fitting := BlGridSpanningSizeFitting new
			preferred: #(300 200 40)
			minima: #(0 0 0)
			limited: #(true true false)
			feasibility: [ :sizes | (sizes first max: sizes second + sizes third) <= 240 ].
	fitting availableSpace: 240 margins: #(0 0 0).
	fitting childSpans: #(#(0 2) #(0 1) #(1 2)) axis: #horizontal.
	fitting run.
	self assert: fitting outcome equals: #fitted.
	self assert: fitting steps first feasible not.
	self assert: fitting selectedStep feasible.
	self assert: (fitting result first closeTo: 240).
	self assert: (fitting result second closeTo: 160).
	self assert: fitting result third equals: 40.
	self assert: fitting result sum > fitting availableSpace.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> staggeredGridLabels [
	<gtExample>
	| fitting diagram count |
	fitting := self solverEvidenceForSpans.
	diagram := fitting
			solverDiagramFor: fitting steps first
			maximum: fitting figureMaximum
			selected: false.
	diagram forceLayout.
	count := fitting steps first evaluation locations size.
	1
		to: count
		do: [ :index | 
			| label |
			label := diagram children at: 1 + (index * 2).
			self
				assert: label position y
				equals: ((index - 1) odd ifTrue: [ 0 ] ifFalse: [ 10 ]) ].
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> stepsKnowTheirAlgorithm [
	<gtExample>
	| fitting |
	fitting := self shrinking.
	fitting steps do: [ :step | self assert: step algorithm == fitting ].
	self assert: fitting selectedStep algorithm == fitting.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> trailingMarginOverflow [
	<gtExample>
	| measurement fitting step index offset |
	measurement := BlGridMeasurementExamples new measurementWithStaggeredSpans.
	fitting := (measurement steps at: 2) fitting.
	step := fitting steps at: 9.
	index := step sizes size.
	offset := fitting childOffsetAt: index in: step.
	self assert: offset + (step sizes at: index) <= fitting availableSpace.
	self
		assert: offset + (step sizes at: index) + (fitting childMargins at: index)
				> fitting availableSpace.
	self assert: (step childAt: index fitsFrom: offset) not.
	self assert: step feasible not.
	^ fitting
]

{ #category : #examples }
BlGridSizeFittingExamples >> twoLimitedChildren [
	<gtExample>
	| fitting |
	fitting := BlGridSequentialSizeFitting new
			preferred: #(20 100 200)
			minima: #(0 40 0)
			limited: #(false true true)
			feasibility: [ :sizes | sizes sum <= 100 ].
	fitting
		availableSpace: 100 margins: #(0 0 0);
		run.
	self assert: fitting result first equals: 20.
	self assert: fitting result second equals: 40.
	self assert: (fitting result third closeTo: 40).
	self assert: (fitting selectedStep isChildRigidAt: 2).
	self assert: (fitting selectedStep isChildRigidAt: 3) not.
	^ fitting
]

"
Executes one complete grid measurement in the original order. Retains stage snapshots and fitting computations, not a history of final layout placement. A later measurement replaces the implementation's latest computation.
"
Class {
	#name : #BlGridMeasurement,
	#superclass : #Object,
	#instVars : [
		'implementation',
		'element',
		'specification',
		'widthSpec',
		'heightSpec',
		'padding',
		'width',
		'height',
		'steps',
		'childSpans'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #presentation }
BlGridMeasurement >> asStagesElement [
	| list |
	list := BrSimpleList vertical
			matchParent;
			margin: (BlInsets all: 10);
			itemStencil: [ BrFrame new
					hMatchParent;
					vFitContent ];
			itemDataBinder: [ :container :step :index | 
				container
					removeChildren;
					addChild: step asStageElement ];
			items: steps.
	^ list
]

{ #category : #private }
BlGridMeasurement >> childSizesSnapshot [
	^ (element children accountedByLayout
		collect: [ :child | child measuredWidth @ child measuredHeight ]) asArray
]

{ #category : #accessing }
BlGridMeasurement >> childSpans [
	"Capture resolved spans once, before any further measurement can mutate constraints."

	^ childSpans
		ifNil: [ childSpans := (element children accountedByLayout
					collect: [ :child | 
						| columns rows |
						columns := (implementation axis: true) specOf: child.
						rows := (implementation axis: false) specOf: child.
						{columns span min.
							columns span max.
							rows span min.
							rows span max} ]) asArray ]
]

{ #category : #private }
BlGridMeasurement >> correctLimitedChildrenOnAxis: horizontal [
	| step axis |
	axis := implementation axis: horizontal.
	step := self
			record: 'Limited-child correction'
			do: [ implementation measurer
					measureLimitedChildren: element
					isHorizontal: horizontal ].
	step
		axis: axis
		locations: #()
		fitting: nil.
	step result
		ifTrue: [ axis invalidateValues.
			self measureAxis: horizontal named: 'Axis recomputation' ]
]

{ #category : #presentation }
BlGridMeasurement >> figureScale [
	| maximum |
	maximum := 1.
	steps
		do: [ :step | 
			step after
				do: [ :extent | 
					maximum := maximum
							max: extent x;
							max: extent y ].
			step locations do: [ :location | maximum := maximum max: location abs ] ].
	^ 300 / maximum
]

{ #category : #'gt-views' }
BlGridMeasurement >> gtChildEvolutionFor: aView [
	"How did each child's measured extent evolve across stages? These are snapshots, not live element sizes."

	<gtView>
	| view |
	view := aView columnedList
			title: 'Child size evolution';
			priority: 2;
			items: [ 1 to: steps last after size ];
			column: 'Child' text: #yourself.
	steps
		do: [ :step | view column: step name text: [ :index | (step after at: index) printString ] ].
	^ view
]

{ #category : #'gt-views' }
BlGridMeasurement >> gtStagesFigureFor: aView [
	"How do measured rectangles change as cell constraints become known? Each child has a separate lane, not a claimed final position. Gray is span allocation, blue changed, green unchanged; nil means axis not yet computed."

	<gtView>
	^ aView explicit
		title: 'Measurement figure';
		priority: 0;
		stencil: [ self asStagesElement ]
]

{ #category : #'gt-views' }
BlGridMeasurement >> gtStepsFor: aView [
	"What ran, in what order, and which children were remeasured? Axis results are allocations, not final placement."

	<gtView>
	^ aView columnedList
		title: 'Measurement steps';
		priority: 1;
		items: [ steps ];
		column: 'Stage' text: #name;
		column: 'Axis' text: #axisName;
		column: 'Changed children' text: [ :step | ', ' join: step changedChildren ];
		column: 'Result' text: [ :step | step result ]
]

{ #category : #initialization }
BlGridMeasurement >> implementation: anImplementation element: anElement specification: aSpecification [
	implementation := anImplementation.
	element := anElement.
	specification := aSpecification.
	steps := OrderedCollection new
]

{ #category : #private }
BlGridMeasurement >> measureAxis: horizontal named: aName [
	| axis step |
	axis := implementation axis: horizontal.
	step := self
			record: aName
			do: [ | size |
				size := axis
						measure: (horizontal ifTrue: [ widthSpec ] ifFalse: [ heightSpec ]).
				horizontal ifTrue: [ width := size ] ifFalse: [ height := size ].
				size ].
	step
		axis: axis
		locations: axis locations copy
		fitting: axis sizeFitting
]

{ #category : #accessing }
BlGridMeasurement >> measuredExtent [
	^ steps last result
]

{ #category : #accessing }
BlGridMeasurement >> padding [
	^ padding
]

{ #category : #private }
BlGridMeasurement >> prepare [
	{true.
		false}
		do: [ :horizontal | 
			(implementation axis: horizontal)
				element: element;
				layout: implementation ].
	implementation measurer layout: implementation.
	implementation invalidateStructure.
	implementation checkConsistency: element.
	implementation invalidateValues.
	padding := element insets width @ element insets height.
	widthSpec := implementation
			adjust: specification widthSpec
			by: padding x negated.
	heightSpec := implementation
			adjust: specification heightSpec
			by: padding y negated
]

{ #category : #private }
BlGridMeasurement >> record: aName do: aBlock [
	| step value |
	self childSpans.
	step := BlGridMeasurementStep new
			algorithm: self
			name: aName
			before: self childSizesSnapshot.
	steps add: step.
	value := aBlock value.
	step completeWith: self childSizesSnapshot result: value.
	^ step
]

{ #category : #computation }
BlGridMeasurement >> run [
	| firstHorizontal |
	self prepare.
	self
		record: 'Initial child measurement'
		do: [ element
				ignoreRequestLayoutDuring: [ implementation measurer
						measureChildren: element
						parentSpec: specification
						isFirstPass: true ] ].
	firstHorizontal := implementation orientation isHorizontal.
	self measureAxis: firstHorizontal named: 'First axis'.
	self
		record: 'Constrained child measurement'
		do: [ implementation measurer
				measureChildren: element
				parentSpec: widthSpec @ heightSpec
				isFirstPass: false ].
	self measureAxis: firstHorizontal not named: 'Second axis'.
	self correctLimitedChildrenOnAxis: firstHorizontal not.
	self
		record: 'Final measurement'
		do: [ element
				measuredExtent: (specification sizeFor: (width + padding x) @ (height + padding y)).
			element measuredExtent ].
	^ self
]

{ #category : #accessing }
BlGridMeasurement >> specification [
	^ specification
]

{ #category : #accessing }
BlGridMeasurement >> steps [
	^ steps
]

"
Real grid examples exposing complete measurements and asserting their stage order and snapshot relationships.
"
Class {
	#name : #BlGridMeasurementExamples,
	#superclass : #Object,
	#category : #'Bloc-Layout-Examples'
}

{ #category : #examples }
BlGridMeasurementExamples >> axisStage [
	<gtExample>
	| step |
	step := self limitedGrid steps at: 4.
	self assert: (step fitting isKindOf: BlGridSizeFitting).
	self assert: step locations isNotEmpty.
	^ step
]

{ #category : #examples }
BlGridMeasurementExamples >> limitedGrid [
	<gtExample>
	| grid measurement |
	grid := BlGridLayoutExamples new exampleCellFitContentLimitedBelowHeader.
	measurement := grid layout measurement.
	self assert: measurement steps first name equals: 'Initial child measurement'.
	self assert: measurement steps last name equals: 'Final measurement'.
	self assert: measurement measuredExtent equals: grid measuredExtent.
	self assert: (measurement steps at: 2) axisName equals: #horizontal.
	self assert: (measurement steps at: 4) axisName equals: #vertical.
	measurement steps do: [ :step | self assert: step algorithm == measurement ].
	measurement steps
		overlappingPairsDo: [ :left :right | self assert: left after equals: right before ].
	^ measurement
]

{ #category : #examples }
BlGridMeasurementExamples >> measurementWithDistinctFittings [
	<gtExample>
	| grid measurement horizontal vertical |
	grid := self sideBySideGridWithDistinctFittings.
	measurement := grid layout measurement.
	self
		assert: measurement childSpans
		equals: #(#(0 1 0 1) #(1 2 0 1) #(2 3 0 1) #(3 4 0 1)).
	horizontal := (measurement steps at: 2) fitting.
	vertical := (measurement steps at: 4) fitting.
	self assert: horizontal steps size > 2.
	self
		assert: horizontal selectedStep sizes first
		equals: horizontal preferredSizes first.
	self assert: horizontal result second < horizontal preferredSizes second.
	self assert: vertical childSpans asSet size equals: 1.
	self assert: measurement padding equals: 20 @ 20.
	self assert: measurement measuredExtent equals: grid measuredExtent.
	^ measurement
]

{ #category : #examples }
BlGridMeasurementExamples >> measurementWithStaggeredSpans [
	<gtExample>
	| measurement vertical |
	measurement := self staggeredSpansGridWithDistinctFittings layout measurement.
	vertical := (measurement steps at: 4) fitting.
	self assert: vertical steps size > 2.
	self assert: vertical limited equals: #(false true true true).
	self assert: vertical result second >= 65.
	self assert: vertical result third >= 55.
	self assert: vertical result fourth >= 35.
	^ measurement
]

{ #category : #examples }
BlGridMeasurementExamples >> progressiveAllocations [
	<gtExample>
	| measurement first second |
	measurement := self limitedGrid.
	first := measurement steps first.
	self
		assert: (first allocationForChild: 1)
		equals: {nil.
				nil}.
	second := measurement steps at: 2.
	self assert: (second allocationForChild: 1) first notNil.
	self assert: (second allocationForChild: 1) second isNil.
	self assert: ((measurement steps at: 4) allocationForChild: 1) second notNil.
	^ measurement
]

{ #category : #examples }
BlGridMeasurementExamples >> retainedSnapshots [
	<gtExample>
	| grid measurement snapshots |
	grid := BlGridLayoutExamples new exampleCellFitContentLimitedBelowHeader.
	measurement := grid layout measurement.
	snapshots := measurement steps collect: [ :step | step after copy ].
	grid children second children first size: 200 @ 30.
	grid forceLayout.
	self assert: grid layout measurement ~~ measurement.
	measurement steps
		with: snapshots
		do: [ :step :snapshot | self assert: step after equals: snapshot ].
	^ measurement
]

{ #category : #examples }
BlGridMeasurementExamples >> sharedGridCoordinates [
	<gtExample>
	| measurement stage header body top bottom |
	measurement := self spanningMeasurementWithFittingOnBothAxes.
	stage := measurement steps at: 4.
	header := stage childFigureOriginAt: 1.
	body := stage childFigureOriginAt: 2.
	top := stage childFigureOriginAt: 3.
	bottom := stage childFigureOriginAt: 4.
	self assert: header x equals: body x.
	self assert: body y equals: top y.
	self assert: top x equals: bottom x.
	self assert: top x > body x.
	self assert: bottom y > top y.
	^ measurement
]

{ #category : #examples }
BlGridMeasurementExamples >> sideBySideGridWithDistinctFittings [
	"Four columns share one row: a fixed tool strip, two oversized limited panels, and a short limited panel. Padding, cell spacing, margins and minimum widths make the additive horizontal problem nontrivial. Vertical requirements overlap rather than add."

	<gtExample>
	| grid tools primary secondary summary measurement horizontal vertical |
	grid := BlElement new
			layout: (BlGridLayout horizontal
					columnCount: 4;
					cellSpacing: 6);
			size: 480 @ 240;
			padding: (BlInsets all: 10);
			background: Color white.
	tools := BlElement new
			size: 48 @ 80;
			background: Color lightGray.
	primary := BlElement new
			layout: BlLinearLayout vertical;
			background: Color paleBlue;
			margin: (BlInsets all: 4);
			constraintsDo: [ :c | 
				c horizontal fitContentLimited.
				c vertical fitContentLimited.
				c minWidth: 150 ].
	primary
		addChildren: {BlElement new
					size: 420 @ 30;
					background: Color blue veryMuchLighter.
				BlElement new
					size: 420 @ 500;
					background: Color blue muchLighter}.
	secondary := BlElement new
			layout: BlLinearLayout vertical;
			background: Color paleGreen;
			margin: (BlInsets all: 2);
			constraintsDo: [ :c | 
				c horizontal fitContentLimited.
				c vertical fitContentLimited.
				c minWidth: 70 ].
	secondary
		addChildren: {BlElement new
					size: 300 @ 24;
					background: Color green muchLighter.
				BlElement new
					size: 300 @ 320;
					background: Color green veryMuchLighter}.
	summary := BlElement new
			layout: BlLinearLayout vertical;
			background: Color paleYellow;
			constraintsDo: [ :c | 
				c horizontal fitContentLimited.
				c vertical fitContentLimited.
				c minWidth: 40 ].
	summary addChild: (BlElement new size: 180 @ 60).
	grid
		addChildren: {tools.
				primary.
				secondary.
				summary}.
	grid forceLayout.
	measurement := grid layout measurement.
	horizontal := (measurement steps at: 2) fitting.
	vertical := (measurement steps at: 4) fitting.
	self assert: horizontal class equals: BlGridSequentialSizeFitting.
	self assert: vertical class equals: BlGridSpanningSizeFitting.
	self assert: horizontal outcome equals: #fitted.
	self assert: horizontal selectedStep feasible.
	self assert: vertical selectedStep feasible.
	self assert: horizontal limited equals: #(false true true true).
	self assert: horizontal childMargins sum > 0.
	self assert: primary width >= 150.
	self assert: secondary width >= 70.
	self assert: summary width >= 40.
	self assert: tools extent equals: 48 @ 80.
	self assert: grid extent equals: 480 @ 240.
	self assert: vertical result sum > vertical availableSpace.
	^ grid
]

{ #category : #examples }
BlGridMeasurementExamples >> spanningGridWithFittingOnBothAxes [
	"Header spans both columns. Body spans two rows next to two small fixed siblings. Both header and body have oversized content; fitting is required on both axes."

	<gtExample>
	| grid header body top bottom horizontal vertical |
	grid := BlElement new
			layout: (BlGridLayout horizontal columnCount: 2);
			size: 240 @ 160;
			background: Color white.
	header := BlElement new
			layout: BlLinearLayout horizontal;
			background: Color lightGray;
			constraintsDo: [ :c | 
				c horizontal fitContentLimited.
				c vertical exact: 20.
				c grid horizontal span: 2 ].
	header addChild: (BlElement new size: 600 @ 20).
	body := BlElement new
			layout: BlLinearLayout vertical;
			background: Color paleBlue;
			constraintsDo: [ :c | 
				c horizontal fitContentLimited.
				c vertical fitContentLimited.
				c grid vertical span: 2 ].
	body addChild: (BlElement new size: 400 @ 600).
	top := BlElement new
			size: 40 @ 30;
			background: Color paleGreen.
	bottom := BlElement new
			size: 40 @ 30;
			background: Color paleRed.
	grid
		addChildren: {header.
				body.
				top.
				bottom}.
	grid forceLayout.
	horizontal := (grid layout measurement steps at: 2) fitting.
	vertical := (grid layout measurement steps at: 4) fitting.
	self assert: horizontal outcome equals: #fitted.
	self assert: vertical outcome equals: #fitted.
	self assert: horizontal selectedStep feasible.
	self assert: vertical selectedStep feasible.
	self assert: grid extent equals: 240 @ 160.
	self assert: header width <= 240.
	self assert: body height <= 140.
	^ grid
]

{ #category : #examples }
BlGridMeasurementExamples >> spanningMeasurementWithFittingOnBothAxes [
	<gtExample>
	| grid measurement stage headerAllocation bodyAllocation sideAllocation |
	grid := self spanningGridWithFittingOnBothAxes.
	measurement := grid layout measurement.
	stage := measurement steps at: 4.
	headerAllocation := stage allocationForChild: 1.
	bodyAllocation := stage allocationForChild: 2.
	sideAllocation := stage allocationForChild: 3.
	self assert: headerAllocation first > bodyAllocation first.
	self assert: bodyAllocation second > sideAllocation second.
	self
		assert: (measurement childSpans at: 1) second - (measurement childSpans at: 1) first
		equals: 2.
	self
		assert: (measurement childSpans at: 2) fourth - (measurement childSpans at: 2) third
		equals: 2.
	^ measurement
]

{ #category : #examples }
BlGridMeasurementExamples >> staggeredSpansGridWithDistinctFittings [
	"Disjoint columns, staggered overlapping row spans. Explicit starts prevent automatic placement from relocating the spans."

	<gtExample>
	| grid children measurement horizontal vertical rowRanges |
	grid := self sideBySideGridWithDistinctFittings.
	children := grid children.
	rowRanges := #(#(0 4) #(0 2) #(1 4) #(2 3)).
	children
		withIndexDo: [ :child :index | 
			| rows columns range |
			range := rowRanges at: index.
			rows := child constraints grid vertical spec.
			rows
				setAlignment: rows alignment
				span: (BlGridLayoutInterval min: range first max: range second)
				startDefined: true
				weight: rows weight.
			columns := child constraints grid horizontal spec.
			columns
				setAlignment: columns alignment
				span: (BlGridLayoutInterval min: index - 1 max: index)
				startDefined: true
				weight: columns weight ].
	children fourth children first size: 180 @ 300.
	children second constraints minHeight: 65.
	children third constraints minHeight: 55.
	children fourth constraints minHeight: 35.
	grid
		layout: (BlGridLayout horizontal
				columnCount: 4;
				cellSpacing: 6).
	grid forceLayout.
	measurement := grid layout measurement.
	horizontal := (measurement steps at: 2) fitting.
	vertical := (measurement steps at: 4) fitting.
	self assert: horizontal class equals: BlGridSequentialSizeFitting.
	self assert: vertical class equals: BlGridSpanningSizeFitting.
	self assert: vertical outcome equals: #fitted.
	self assert: vertical childSpans equals: rowRanges.
	self assert: vertical selectedStep feasible.
	self assert: vertical selectedStep evaluation violations isEmpty.
	self assert: vertical steps first evaluation violations isNotEmpty.
	self assert: vertical selectedStep evaluation locations size equals: 5.
	^ grid
]

{ #category : #examples }
BlGridMeasurementExamples >> verticalGrid [
	<gtExample>
	| grid measurement |
	grid := BlGridLayoutExamples new
			exampleCellFitContentLimitedBelowHeaderVertical.
	measurement := grid layout measurement.
	self assert: (measurement steps at: 2) axisName equals: #vertical.
	self assert: (measurement steps at: 4) axisName equals: #horizontal.
	self assert: measurement measuredExtent equals: grid measuredExtent.
	^ measurement
]

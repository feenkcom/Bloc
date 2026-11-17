"
I show how a grid layout handles fractional sizes, as a display scale other than 1 produces (a width of 307.4 at 125 %), and why it once did not.

Fill, undefined and baseline alignments have no alignment point. {{gtMethod:BlGridFillAlignment>>#alignmentValue:viewSize:}} answers the UNDEFINED sentinel of {{gtClass:BlGridLayoutConstants}}, about -2^30:
{{gtExample:BlGridLayoutFractionalSizeExamples>>#fillAlignmentAnswersUndefinedSentinel|codeExpanded=false|previewExpanded=true|previewHeight=160}}

{{gtClass:BlGridLayoutBounds}} used to store a child's size as size - UNDEFINED and to add UNDEFINED back in {{gtMethod:BlGridLayoutBounds>>#size:}}. In integers, as in the Android GridLayout, the round trip is exact. In Floats the intermediate value is about 2^30, where a double only resolves steps of 2^-22:
{{gtExample:BlGridLayoutFractionalSizeExamples>>#sentinelMagnitudeKeepsTwentyTwoFractionBits|codeExpanded=false|previewExpanded=true|previewHeight=160}}
So the size came back changed, sometimes larger:
{{gtExample:BlGridLayoutFractionalSizeExamples>>#sentinelRoundTripRoundsUp|previewExpanded=true|previewHeight=160}}
and sometimes smaller:
{{gtExample:BlGridLayoutFractionalSizeExamples>>#sentinelRoundTripRoundsDown|codeExpanded=false|previewExpanded=true|previewHeight=160}}
Integers, halves and quarters survive, which is why the problem never showed at a display scale of 1:
{{gtExample:BlGridLayoutFractionalSizeExamples>>#sentinelRoundTripIsExactForDyadicSizes|codeExpanded=false|previewExpanded=true|previewHeight=200}}
At a display scale of 1.25 cell widths come in steps of 0.4. Of 51 such widths, 20 come back larger, 20 smaller and 11 unchanged; these are the ones that come back larger:
{{gtExample:BlGridLayoutFractionalSizeExamples>>#scaledWidthsThatRoundUp|codeExpanded=false|previewExpanded=true|previewHeight=300}}
Each width with its old round trip, the error, the direction of the rounding, and whether two columns of that width fit their grid now (each row opens that grid):
{{gtExample:BlGridLayoutFractionalSizeExamples>>#gridsOverview|codeExpanded=false|previewExpanded=true|previewShow=#gtScaledWidthsFor:|previewHeight=400}}
The error is far larger than the usual one-ulp noise and larger than Float defaultComparisonPrecision, so comparing with {{gtMethod:Float>>#closeTo:}} would not have helped.

When a size came back larger, the columns of a grid required slightly more than the grid. {{gtMethod:BlGridLayoutAxis>>#solveAndDistributeSpaceLocations:childSizes:}} then dropped the grid's maximum arc, which {{gtMethod:BlGridLayoutAxis>>#computeArcs}} never restores, and its binary search for extra width had no upper bound left: every weighted column grew by about the grid width. In a {{gtClass:GtDiffElement}} the left editor covered the whole window and the right one disappeared. Whether a width rounded up or down looked random, so while a window was resized the diff kept switching between broken and correct.

The axes of a grid show what the solver did: {{gtMethod:BlGridLayout>>#gtAxesFor:}} lists them, {{gtMethod:BlGridLayoutAxis>>#gtArcsFor:}} shows every constraint with whether it was dropped and whether the lines satisfy it, and {{gtMethod:BlGridLayoutAxis>>#gtColumnsFor:}} draws the columns against the size of the grid, with any part past the grid in red.

Three changes address this:
- {{gtMethod:BlGridLayoutBounds>>#includeElement:spec:axis:size:}} keeps the largest size of the undefined-aligned children apart, and {{gtMethod:BlGridLayoutBounds>>#size:}} answers it directly, so the sentinel no longer enters the arithmetic. An earlier version used the exact Fraction of the size; it was correct but made a layout of many fractional fill cells twice as slow.
{{gtExample:BlGridLayoutFractionalSizeExamples>>#fillBoundsKeepFractionalSize|codeExpanded=false|previewExpanded=true|previewHeight=160}}
{{gtExample:BlGridLayoutFractionalSizeExamples>>#fractionalFillColumnsFitTheirGrid|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=150}}
{{gtExample:BlGridLayoutFractionalSizeExamples>>#scaledWidthMatchParentColumnsFitTheirGrid|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=150}}
Its columns end exactly at the grid's width, and no arc is dropped:
{{gtExample:BlGridLayoutFractionalSizeExamples>>#scaledWidthColumnsAxis|codeExpanded=false|previewExpanded=true|previewShow=#gtColumnsFor:|previewHeight=200}}
{{gtExample:BlGridLayoutFractionalSizeExamples>>#scaledWidthColumnsAxis|codeExpanded=false|previewExpanded=true|previewShow=#gtArcsFor:|previewHeight=250}}
- {{gtMethod:BlGridLayoutAxis>>#hasDroppedArcs}} stops the distribution when the first solve had to drop a constraint, so a real overflow stays as small as it is:
{{gtExample:BlGridLayoutFractionalSizeExamples>>#overflowingColumnsStayBounded|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=150}}
Here the grid's maximum is dropped, and the second column ends 1 past the grid instead of near 2000 (each column grew from 200 to 998):
{{gtExample:BlGridLayoutFractionalSizeExamples>>#overflowingColumnsAxis|codeExpanded=false|previewExpanded=true|previewShow=#gtArcsFor:|previewHeight=250}}
{{gtExample:BlGridLayoutFractionalSizeExamples>>#overflowingColumnsAxis|codeExpanded=false|previewExpanded=true|previewShow=#gtColumnsFor:|previewHeight=200}}
- {{gtMethod:BlGridLayoutAxis>>#measuredChildSizes}} lets a matchParent cell require only its minimum size, not the cell width of the previous layout pass:
{{gtExample:BlGridLayoutFractionalSizeExamples>>#matchParentColumnsLaidOutNarrowerThanMeasured|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=150}}

All grids of the layout examples, with their column lines, whether an arc was dropped and whether the columns fit (each row opens the grid, whose Axes view leads to the Arcs and Columns views). The Grids and Scaled widths views are also shown in the class coder:
{{gtExample:BlGridLayoutFractionalSizeExamples>>#gridsOverview|codeExpanded=false|previewExpanded=true|previewShow=#gtGridsFor:|previewHeight=250}}

The sentinel examples document the Float arithmetic itself and pass with or without the fix. The bounds and layout examples fail without the change they cover. The original symptom, a diff at a scaled width:
{{gtExample:GtDiffElementExamples>>#diffAtScaledWidth|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=450}}
"
Class {
	#name : #BlGridLayoutFractionalSizeExamples,
	#superclass : #Object,
	#category : #'Bloc-Layout-Examples'
}

{ #category : #'gt-views' }
BlGridLayoutFractionalSizeExamples class >> gtGridsFor: aView [
	"Which grids do my layout examples build, and do their columns fit? Shown in the class coder"
	<gtClassView>
	^(aView forward)
		title: 'Grids';
		priority: 20;
		object: [self new];
		view: #gtGridsFor:
]

{ #category : #'gt-views' }
BlGridLayoutFractionalSizeExamples class >> gtScaledWidthsFor: aView [
	"Which cell widths of a display scale of 1.25 did the sentinel round trip make larger? Shown in the class coder"
	<gtClassView>
	^(aView forward)
		title: 'Scaled widths';
		priority: 21;
		object: [self new];
		view: #gtScaledWidthsFor:
]

{ #category : #'examples - bounds' }
BlGridLayoutFractionalSizeExamples >> baselineBoundsKeepFractionalSize [
	<gtExample>
	<return: #BlGridLayoutBaselineBounds>
	| bounds |
	bounds := self includeFillElementOfSize: 153.39999999999998
				in: BlGridLayoutBaselineBounds new.
	self assert: (bounds size: true) equals: 153.39999999999998.
	self assert: (bounds size: true) isFloat.
	^bounds
]

{ #category : #'examples - bounds' }
BlGridLayoutFractionalSizeExamples >> baselineBoundsKeepLargestFractionalSize [
	<gtExample>
	<return: #BlGridLayoutBaselineBounds>
	| bounds |
	bounds := BlGridLayoutBaselineBounds new.
	self includeFillElementOfSize: 100.2 in: bounds.
	self includeFillElementOfSize: 153.39999999999998 in: bounds.
	self assert: (bounds size: true) equals: 153.39999999999998.
	^bounds
]

{ #category : #'gt-views' }
BlGridLayoutFractionalSizeExamples >> droppedArcsTextOf: aGrid [
	^(aGrid layout axis: true) hasDroppedArcs
		ifTrue: ['yes' asRopedText foreground: Color red]
		ifFalse: ['no']
]

{ #category : #'examples - sentinel' }
BlGridLayoutFractionalSizeExamples >> fillAlignmentAnswersUndefinedSentinel [
	"The value that BlGridLayoutBounds subtracts from a size and later adds back"
	<gtExample>
	<return: #SmallInteger>
	| undefined |
	undefined := self undefinedAlignmentValue.
	self assert: undefined equals: -1073741823.
	self assert: undefined negated > (2 raisedTo: 29).
	^undefined
]

{ #category : #'examples - bounds' }
BlGridLayoutFractionalSizeExamples >> fillBoundsKeepFractionalSize [
	<gtExample>
	<return: #BlGridLayoutBounds>
	| bounds |
	bounds := self includeFillElementOfSize: 153.39999999999998
				in: BlGridLayoutBounds new.
	self assert: (bounds size: true) equals: 153.39999999999998.
	self assert: (bounds size: true) isFloat.
	^bounds
]

{ #category : #'examples - bounds' }
BlGridLayoutFractionalSizeExamples >> fillBoundsKeepIntegerSize [
	<gtExample>
	<return: #BlGridLayoutBounds>
	| bounds |
	bounds := self includeFillElementOfSize: 25 in: BlGridLayoutBounds new.
	self assert: (bounds size: true) equals: 25.
	self assert: (bounds size: true) isInteger.
	^bounds
]

{ #category : #'examples - bounds' }
BlGridLayoutFractionalSizeExamples >> fillBoundsKeepLargestFractionalSize [
	"A column of fill cells needs exactly its widest cell"
	<gtExample>
	<return: #BlGridLayoutBounds>
	| bounds |
	bounds := BlGridLayoutBounds new.
	self includeFillElementOfSize: 100.2 in: bounds.
	self includeFillElementOfSize: 153.39999999999998 in: bounds.
	self includeFillElementOfSize: 120.6 in: bounds.
	self assert: (bounds size: true) equals: 153.39999999999998.
	^bounds
]

{ #category : #'examples - bounds' }
BlGridLayoutFractionalSizeExamples >> fillBoundsPassInfiniteSizeThrough [
	"An infinite size, as an element constrained to exact: Float infinity is measured, comes back unchanged and does not raise during layout"
	<gtExample>
	<return: #BlGridLayoutBounds>
	| bounds |
	bounds := self includeFillElementOfSize: Float infinity
				in: BlGridLayoutBounds new.
	self assert: (bounds size: true) equals: Float infinity.
	^bounds
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> fillCellMatchingParent [
	^(BlElement new)
		background: (Color green alpha: 0.2);
		constraintsDo: 
				[:c |
				c horizontal matchParent.
				c vertical exact: 20.
				(c grid horizontal)
					weight: 1;
					specAlignment: BlGridAlignment fill];
		yourself
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> fillCellWithExactWidth: aNumber [
	^(BlElement new)
		background: (Color blue alpha: 0.2);
		constraintsDo: 
				[:c |
				c horizontal exact: aNumber.
				c vertical exact: 20.
				(c grid horizontal)
					weight: 1;
					specAlignment: BlGridAlignment fill];
		yourself
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> fillElement [
	^(BlElement new)
		constraintsDo: [:c | c grid horizontal specAlignment: BlGridAlignment fill];
		yourself
]

{ #category : #'gt-views' }
BlGridLayoutFractionalSizeExamples >> fitsTextOf: aGrid [
	| overflow |
	overflow := (aGrid layout axis: true) locations last - aGrid width.
	^overflow > 0
		ifTrue: 
			[('no, ' , overflow printString , ' past the grid') asRopedText
				foreground: Color red]
		ifFalse: ['yes']
]

{ #category : #'examples - layout' }
BlGridLayoutFractionalSizeExamples >> fractionalFillColumnsFitAtScaledWidths [
	"Column widths in steps of 0.4, as a display scale of 1.25 produces when a window is resized. Before the fix most of these widths broke, the others did not"
	<gtExample>
	<return: #Array>
	| widths |
	widths := (0 to: 400) collect: [:each | 100 + (each * 0.4)].
	widths do: 
			[:each |
			| grid first second |
			grid := self gridWithTwoColumnsOfWidth: each * 2.
			first := self fillCellWithExactWidth: each.
			second := self fillCellWithExactWidth: each.
			grid
				addChild: first;
				addChild: second.
			self relayout: grid.
			self assert: first width equals: each.
			self assert: second position x equals: each.
			self assert: second bounds inParent right equals: each * 2].
	^widths asArray
]

{ #category : #'examples - layout' }
BlGridLayoutFractionalSizeExamples >> fractionalFillColumnsFitTheirGrid [
	"Two fill columns of 100.2 in a grid of 200.4. Before the fix each column required 100.20000004768372, the solver dropped the grid's maximum and the weights spread the grid width again over every column"
	<gtExample>
	<return: #BlElement>
	| grid first second |
	grid := self gridWithTwoColumnsOfWidth: 200.4.
	first := self fillCellWithExactWidth: 100.2.
	second := self fillCellWithExactWidth: 100.2.
	grid
		addChild: first;
		addChild: second.
	self relayout: grid.
	self assert: first position equals: 0 @ 0.
	self assert: first width equals: 100.2.
	self assert: second position x equals: 100.2.
	self assert: second bounds inParent right equals: 200.4.
	^grid
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> gridExampleSelectors [
	"The examples that answer a grid element"
	^((self class methods select: 
			[:each |
			(each hasPragmaNamed: #gtExample) and: 
					[(each pragmaAt: #return:)
						ifNil: [false]
						ifNotNil: [:aPragma | aPragma arguments first = #BlElement]]])
		collect: [:each | each selector]) asSortedCollection
		asArray
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> gridWithTwoColumnsOfWidth: aNumber [
	^(BlElement new)
		layout: (BlGridLayout horizontal columnCount: 2);
		size: aNumber @ 20;
		yourself
]

{ #category : #'examples - overview' }
BlGridLayoutFractionalSizeExamples >> gridsOverview [
	"Me, to navigate the grids of my layout examples (Grids view) and the cell widths of a display scale of 1.25 (Scaled widths view)"
	<gtExample>
	<return: #BlGridLayoutFractionalSizeExamples>
	self assert: self gridExampleSelectors size equals: 4.
	self
		assert: (self scaledCellWidths
				select: [:each | (self sentinelRoundTripOf: each) > each]) size
		equals: 20.
	self scaledCellWidths do: 
			[:each |
			self
				assert: ((self twoFillColumnsOfWidth: each) layout axis: true) locations
						last
				equals: each * 2].
	^self
]

{ #category : #'gt-views' }
BlGridLayoutFractionalSizeExamples >> gtGridsFor: aView [
	"Which grids do my layout examples build, where do their column lines end, and did the solver drop an arc? Each row opens the grid, whose Axes view leads to the Arcs and Columns of its axes"
	<gtView>
	^(aView columnedList)
		title: 'Grids';
		priority: 1;
		items: 
				[self gridExampleSelectors collect: [:each | each -> (self perform: each)]];
		column: 'Example' text: [:each | each key];
		column: 'Grid width'
			text: [:each | each value width]
			width: 80;
		column: 'Column lines'
			text: [:each | (each value layout axis: true) gtLinesText];
		column: 'Dropped arcs'
			text: [:each | self droppedArcsTextOf: each value]
			width: 90;
		column: 'Columns fit'
			text: [:each | self fitsTextOf: each value]
			width: 150;
		send: [:each | each value]
]

{ #category : #'gt-views' }
BlGridLayoutFractionalSizeExamples >> gtScaledWidthsFor: aView [
	"Which cell widths of a display scale of 1.25 did the sentinel round trip make larger, and do two columns of that width fit their grid now? Each row opens the grid of that width"
	<gtView>
	^(aView columnedList)
		title: 'Scaled widths';
		priority: 2;
		items: [self scaledCellWidths];
		column: 'Cell width'
			text: [:each | each]
			width: 80;
		column: 'Old round trip' text: [:each | self sentinelRoundTripOf: each];
		column: 'Error' text: [:each | (self sentinelRoundTripOf: each) - each];
		column: 'Direction'
			text: [:each | self roundingTextOf: each]
			width: 70;
		column: 'Columns fit now'
			text: [:each | self fitsTextOf: (self twoFillColumnsOfWidth: each)]
			width: 150;
		send: [:each | self twoFillColumnsOfWidth: each]
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> horizontalAxis [
	^BlGridLayoutAxis new horizontal: true
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> include: anElement ofSize: aNumber in: aGridLayoutBounds [
	aGridLayoutBounds
		includeElement: anElement
		spec: anElement constraints grid horizontal spec
		axis: self horizontalAxis
		size: aNumber.
	^aGridLayoutBounds
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> includeFillElementOfSize: aNumber in: aGridLayoutBounds [
	^self
		include: self fillElement
		ofSize: aNumber
		in: aGridLayoutBounds
]

{ #category : #'examples - bounds' }
BlGridLayoutFractionalSizeExamples >> leadingBoundsKeepFractionalSize [
	"A leading cell has its alignment point at 0, so its size never met the sentinel"
	<gtExample>
	<return: #BlGridLayoutBounds>
	| bounds |
	bounds := self
				include: self leadingElement
				ofSize: 153.39999999999998
				in: BlGridLayoutBounds new.
	self assert: (bounds size: true) equals: 153.39999999999998.
	^bounds
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> leadingElement [
	^(BlElement new)
		constraintsDo: [:c | c grid horizontal specAlignment: BlGridAlignment leading];
		yourself
]

{ #category : #'examples - layout' }
BlGridLayoutFractionalSizeExamples >> matchParentColumnsLaidOutNarrowerThanMeasured [
	"A matchParent column requires only its minimum size, not the cell width of the previous pass"
	<gtExample>
	<return: #BlElement>
	| grid first second context |
	grid := self gridWithTwoColumnsOfWidth: 400.
	first := self fillCellMatchingParent.
	second := self fillCellMatchingParent.
	grid
		addChild: first;
		addChild: second.
	grid forceLayout.
	context := BlElementBoundsUpdater new.
	grid applyLayoutIn: (0 @ 0 extent: 399 @ 20) context: context.
	context commitChanges.
	self assert: first position equals: 0 @ 0.
	self assert: second position x equals: first width.
	self assert: second bounds inParent right equals: 399.
	^grid
]

{ #category : #'examples - bounds' }
BlGridLayoutFractionalSizeExamples >> mixedAlignmentBoundsKeepSentinelSize [
	"A column that mixes a fill and a leading cell needs the fill cell's size minus the sentinel past the leading alignment point, about 2^30, as it always did. The fix only makes columns of undefined-aligned cells exact"
	<gtExample>
	<return: #BlGridLayoutBounds>
	| bounds undefined |
	undefined := self fillAlignmentAnswersUndefinedSentinel.
	bounds := BlGridLayoutBounds new.
	self includeFillElementOfSize: 100 in: bounds.
	self
		include: self leadingElement
		ofSize: 50
		in: bounds.
	self assert: (bounds size: true) equals: 100 - undefined.
	^bounds
]

{ #category : #'examples - layout' }
BlGridLayoutFractionalSizeExamples >> overflowingColumnsAxis [
	"The horizontal axis of #overflowingColumnsStayBounded. Its Arcs view shows the grid's maximum as dropped, its Columns view the overflow of 1 past the grid"
	<gtExample>
	<return: #BlGridLayoutAxis>
	| axis |
	axis := self overflowingColumnsStayBounded layout axis: true.
	self assert: axis hasDroppedArcs.
	self assert: axis locations last equals: 400.
	^axis
]

{ #category : #'examples - layout' }
BlGridLayoutFractionalSizeExamples >> overflowingColumnsStayBounded [
	"Two columns of 200 really do not fit in 399. The solver drops the grid's maximum; the weights must not then spread the grid width over every column again, so the overflow stays 1"
	<gtExample>
	<return: #BlElement>
	| grid first second |
	grid := self gridWithTwoColumnsOfWidth: 399.
	first := self fillCellWithExactWidth: 200.
	second := self fillCellWithExactWidth: 200.
	grid
		addChild: first;
		addChild: second.
	self relayout: grid.
	self assert: first width equals: 200.
	self assert: second position x equals: 200.
	self assert: second bounds inParent right equals: 400.
	^grid
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> relayout: anElement [
	"Measure and lay out, then lay out again: the second pass solves the columns from the widths the children were measured at"
	anElement forceLayout.
	anElement requestLayout.
	anElement forceLayout.
	^anElement
]

{ #category : #'gt-views' }
BlGridLayoutFractionalSizeExamples >> roundingTextOf: aSize [
	| roundTrip |
	roundTrip := self sentinelRoundTripOf: aSize.
	roundTrip > aSize ifTrue: [^'up' asRopedText foreground: Color red].
	^roundTrip < aSize
		ifTrue: ['down']
		ifFalse: ['exact' asRopedText foreground: Color gray]
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> scaledCellWidths [
	"Cell widths in steps of 0.4, as a display scale of 1.25 produces"
	^(0 to: 50) collect: [:each | 100 + (each * 0.4)]
]

{ #category : #'examples - layout' }
BlGridLayoutFractionalSizeExamples >> scaledWidthColumnsAxis [
	"The horizontal axis of #scaledWidthMatchParentColumnsFitTheirGrid. All arcs are kept and satisfied, and the last line is exactly at the grid's width"
	<gtExample>
	<return: #BlGridLayoutAxis>
	| axis |
	axis := self scaledWidthMatchParentColumnsFitTheirGrid layout axis: true.
	self assert: axis hasDroppedArcs not.
	self assert: axis locations last equals: 307.4.
	^axis
]

{ #category : #'examples - layout' }
BlGridLayoutFractionalSizeExamples >> scaledWidthMatchParentColumnsFitTheirGrid [
	"The client case: a grid of 307.4 at display scale 1.25 with two weighted matchParent fill columns, as the labels and editors of a GtDiffElement"
	<gtExample>
	<return: #BlElement>
	| grid first second |
	grid := self gridWithTwoColumnsOfWidth: 307.4.
	first := self fillCellMatchingParent.
	second := self fillCellMatchingParent.
	grid
		addChild: first;
		addChild: second.
	self relayout: grid.
	self assert: first position equals: 0 @ 0.
	self assert: second position x equals: first width.
	self assert: second bounds inParent right equals: 307.4.
	^grid
]

{ #category : #'examples - sentinel' }
BlGridLayoutFractionalSizeExamples >> scaledWidthsThatRoundUp [
	"Cell widths in steps of 0.4, as at a display scale of 1.25. These are the widths that the sentinel round trip makes larger, so that their columns no longer fit their grid; the others come back smaller or unchanged"
	<gtExample>
	<return: #Array>
	| undefined widths roundingUp roundingDown |
	undefined := self fillAlignmentAnswersUndefinedSentinel.
	widths := (0 to: 50) collect: [:each | 100 + (each * 0.4)].
	roundingUp := widths
				select: [:each | undefined + (each - undefined) > each].
	roundingDown := widths
				select: [:each | undefined + (each - undefined) < each].
	self assert: roundingUp size equals: 20.
	self assert: roundingDown size equals: 20.
	self assert: (roundingUp includes: 100.4).
	self assert: (roundingDown includes: 100.8).
	^roundingUp asArray
]

{ #category : #'examples - sentinel' }
BlGridLayoutFractionalSizeExamples >> sentinelMagnitudeKeepsTwentyTwoFractionBits [
	"A size minus the sentinel is about 2^30; a double then resolves only steps of 2^-22"
	<gtExample>
	<return: #SmallFloat64>
	| shifted |
	shifted := 153.39999999999998 - self fillAlignmentAnswersUndefinedSentinel.
	self assert: shifted ulp equals: (2 raisedTo: -22) asFloat.
	self assert: 153.39999999999998 ulp < (2 raisedTo: -40) asFloat.
	^shifted ulp
]

{ #category : #'examples - sentinel' }
BlGridLayoutFractionalSizeExamples >> sentinelRoundTripIsExactForDyadicSizes [
	"Integers, halves and quarters fit the 2^-22 grid, which is why the bug never shows at display scale 1"
	<gtExample>
	<return: #Array>
	| undefined sizes |
	undefined := self fillAlignmentAnswersUndefinedSentinel.
	sizes := #(25 154.0 200.5 300.25).
	sizes
		do: [:each | self assert: undefined + (each - undefined) equals: each].
	^sizes
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> sentinelRoundTripOf: aSize [
	"The size BlGridLayoutBounds answered before the fix: aSize through the UNDEFINED sentinel and back"
	| undefined |
	undefined := self undefinedAlignmentValue.
	^undefined + (aSize - undefined)
]

{ #category : #'examples - sentinel' }
BlGridLayoutFractionalSizeExamples >> sentinelRoundTripRoundsDown [
	"The direction of the error depends on the low bits of the size; a smaller size still fits its grid"
	<gtExample>
	<return: #SmallFloat64>
	| undefined size roundTrip |
	undefined := self fillAlignmentAnswersUndefinedSentinel.
	size := 166.3.
	roundTrip := undefined + (size - undefined).
	self assert: roundTrip equals: 166.29999995231628.
	self assert: roundTrip < size.
	^roundTrip
]

{ #category : #'examples - sentinel' }
BlGridLayoutFractionalSizeExamples >> sentinelRoundTripRoundsUp [
	"The Float round trip through the sentinel makes this size larger. The error is far above one ulp and above Float defaultComparisonPrecision, so closeTo: would not even call the two sizes close"
	<gtExample>
	<return: #SmallFloat64>
	| undefined size roundTrip |
	undefined := self fillAlignmentAnswersUndefinedSentinel.
	size := 153.39999999999998.
	roundTrip := undefined + (size - undefined).
	self assert: roundTrip equals: 153.40000009536743.
	self assert: roundTrip > size.
	self assert: roundTrip - size > Float defaultComparisonPrecision.
	self assert: (roundTrip closeTo: size) not.
	^roundTrip
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> twoFillColumnsOfWidth: aNumber [
	| grid |
	grid := self gridWithTwoColumnsOfWidth: aNumber * 2.
	grid
		addChild: (self fillCellWithExactWidth: aNumber);
		addChild: (self fillCellWithExactWidth: aNumber).
	^self relayout: grid
]

{ #category : #factories }
BlGridLayoutFractionalSizeExamples >> undefinedAlignmentValue [
	"Fill, undefined and baseline alignments have no alignment point; they answer the UNDEFINED sentinel of BlGridLayoutConstants"
	^BlGridAlignment fill alignmentValue: BlElement new viewSize: 0
]

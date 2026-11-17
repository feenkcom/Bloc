Class {
	#name : #BlGridLayoutExamples,
	#superclass : #Object,
	#traits : 'TBlLayoutExamplesSetup + TGtExampleAssertable',
	#classTraits : 'TBlLayoutExamplesSetup classTrait + TGtExampleAssertable classTrait',
	#category : #'Bloc-Layout-Examples-Grid'
}

{ #category : #factories }
BlGridLayoutExamples >> childWeightedFill [
	^(self childElementWithVisualProperties)
		constraintsDo: 
				[:c |
				c horizontal matchParent.
				c vertical exact: 50.
				(c grid horizontal)
					weight: 1;
					specAlignment: BlGridAlignment fill];
		yourself
]

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleCellFitContent [
	<gtExample>
	<return: #BlElement>
	| parent child subchild |
	parent := self parentWithGridHorizontalLayout.
	parent
		constraintsDo: [ :c | 
			c horizontal exact: 300.
			c vertical fitContent ].
	parent background: Color white.

	child := self matchWidthFitHeight.
	child layout: BlGridLayout vertical.
	child background: Color paleBlue.

	subchild := self childExact: 200 @ 100.
	subchild background: Color paleRed.

	child addChild: subchild.
	parent addChild: child.

	parent forceLayout.

	self assert: subchild extent equals: 200 @ 100.
	self assert: subchild position equals: 0 @ 0.

	self assert: child extent equals: 300 @ 100.
	self assert: child position equals: 0 @ 0.

	self assert: parent extent equals: 300 @ 100.
	self assert: parent position equals: 0 @ 0.

	^ parent
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellFitContentLimitedBelowHeader [
	<gtExample>
	<return: #BlElement>
	| parent header body |
	parent := BlElement new
			layout: (BlGridLayout horizontal columnCount: 1);
			size: 200 @ 100;
			background: Color white.
	header := BlElement new
			size: 200 @ 20;
			background: Color lightGray.
	body := BlElement new
			layout: BlLinearLayout vertical;
			background: Color paleBlue;
			constraintsDo: [ :c | 
				c horizontal exact: 200.
				c vertical fitContentLimited ].
	body addChild: (BlElement new size: 200 @ 1000).
	parent
		addChildren: {header.
				body}.
	parent forceLayout.

	self assert: parent extent equals: 200 @ 100.
	self assert: header extent equals: 200 @ 20.
	self assert: body position equals: 0 @ 20.
	self assert: body extent equals: 200 @ 80.
	^ parent
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellFitContentLimitedBelowHeaderVertical [
	<gtExample>
	<return: #BlElement>
	| parent body |
	parent := self exampleCellFitContentLimitedBelowHeader.
	parent layout: (BlGridLayout vertical rowCount: 2).
	parent forceLayout.
	body := parent children second.
	self assert: body position equals: 0 @ 20.
	self assert: body extent equals: 200 @ 80.
	^ parent
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellFitContentLimitedBesideHeader [
	<gtExample>
	<return: #BlElement>
	| parent header body |
	parent := self exampleCellFitContentLimitedBelowHeader.
	parent size: 100 @ 200.
	parent layout columnCount: 2.
	header := parent children first.
	header size: 20 @ 200.
	body := parent children second.
	body layout: BlLinearLayout horizontal.
	body
		constraintsDo: [ :c | 
			c horizontal fitContentLimited.
			c vertical exact: 200 ].
	body children first size: 1000 @ 200.
	parent forceLayout.
	self assert: body position equals: 20 @ 0.
	self assert: body extent equals: 80 @ 200.
	^ parent
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellFitContentLimitedInLimitedGrid [
	<gtExample>
	<return: #BlElement>
	| outer parent body |
	parent := self exampleCellFitContentLimitedBelowHeader.
	parent constraints vertical fitContentLimited.
	outer := BlElement new
			layout: BlLinearLayout vertical;
			size: 200 @ 100.
	outer addChild: parent.
	outer forceLayout.
	body := parent children second.
	self assert: parent extent equals: 200 @ 100.
	self assert: body extent equals: 200 @ 80.
	body children first size: 200 @ 30.
	outer forceLayout.
	self assert: parent extent equals: 200 @ 50.
	self assert: body extent equals: 200 @ 30.
	^ outer
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellFitContentLimitedShortContent [
	<gtExample>
	<return: #BlElement>
	| parent body |
	parent := self exampleCellFitContentLimitedBelowHeader.
	body := parent children second.
	body children first size: 200 @ 30.
	parent forceLayout.
	self assert: body position equals: 0 @ 20.
	self assert: body extent equals: 200 @ 30.
	^ parent
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellFitContentLimitedSpansRows [
	<gtExample>
	<return: #BlElement>
	| parent header body top bottom |
	parent := self exampleCellFitContentLimitedBelowHeader.
	parent layout columnCount: 2.
	header := parent children first.
	header constraints grid horizontal span: 2.
	body := parent children second.
	body
		constraintsDo: [ :c | 
			c horizontal exact: 100.
			c grid vertical span: 2 ].
	body children first size: 100 @ 1000.
	top := BlElement new
			size: 100 @ 30;
			background: Color paleGreen.
	bottom := BlElement new
			size: 100 @ 30;
			background: Color paleRed.
	parent
		addChildren: {top.
				bottom}.
	parent forceLayout.
	self assert: body position equals: 0 @ 20.
	self assert: body extent equals: 100 @ 80.
	self assert: top bounds inParent bottom <= 100.
	self assert: bottom bounds inParent bottom <= 100.
	^ parent
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellFitContentLimitedWithFill [
	<gtExample>
	<return: #BlElement>
	| parent body |
	parent := self exampleCellFitContentLimitedBelowHeader.
	body := parent children second.
	body constraints grid vertical specAlignment: BlGridAlignment fill.
	parent forceLayout.
	self assert: body extent equals: 200 @ 80.
	body children first size: 200 @ 30.
	parent forceLayout.
	self assert: body extent equals: 200 @ 80.
	^ parent
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellFitContentLimitedWithMarginsAndPadding [
	<gtExample>
	<return: #BlElement>
	| parent body |
	parent := self exampleCellFitContentLimitedBelowHeader.
	parent padding: (BlInsets top: 5 bottom: 5).
	body := parent children second.
	body margin: (BlInsets top: 3 bottom: 7).
	parent forceLayout.
	self assert: body position equals: 0 @ 28.
	self assert: body extent equals: 200 @ 60.
	self
		assert: body bounds inParent bottom + body margin bottom + parent padding bottom
		equals: 100.
	^ parent
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellFitContentLimitedWithOversizedHeader [
	<gtExample>
	<return: #BlElement>
	| parent header body |
	parent := self exampleCellFitContentLimitedBelowHeader.
	header := parent children first.
	header size: 200 @ 120.
	parent forceLayout.
	body := parent children second.
	self assert: parent extent equals: 200 @ 100.
	self assert: header extent equals: 200 @ 120.
	self assert: body position equals: 0 @ 120.
	self assert: body extent equals: 200 @ 100.
	^ parent
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellFitContentLimitedWithSpacing [
	<gtExample>
	<return: #BlElement>
	| parent header body |
	parent := self exampleCellFitContentLimitedBelowHeader.
	parent layout cellSpacing: 10.
	header := parent children first.
	header constraints horizontal exact: 180.
	body := parent children second.
	body constraints horizontal exact: 180.
	body children first size: 180 @ 1000.
	parent forceLayout.
	self assert: header position equals: 10 @ 10.
	self assert: body position equals: 10 @ 40.
	self assert: body extent equals: 180 @ 50.
	^ parent
]

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleCellSpacingHorizontal1 [
	<gtExample>
	<return: #BlElement>
	| parent childA childB |
	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.

	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 200.
	parent layout cellSpacing: 20.
	parent layout horizontal.

	parent
		addChildren: {childA.
				childB}.
	parent forceLayout.

	self assert: childA extent equals: 170 @ 160.
	self assert: childA position equals: 20 @ 20.

	self assert: childB extent equals: 170 @ 160.
	self assert: childB position equals: 210 @ 20.

	self assert: parent extent equals: 400 @ 200.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleCellSpacingVertical1 [
	<gtExample>
	<return: #BlElement>
	| parent childA childB |
	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.

	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal exact: 200.
	parent constraints vertical exact: 400.
	parent layout cellSpacing: 20.
	parent layout vertical.

	parent
		addChildren: {childA.
				childB}.
	parent forceLayout.

	self assert: childA extent equals: 160 @ 170.
	self assert: childA position equals: 20 @ 20.

	self assert: childB extent equals: 160 @ 170.
	self assert: childB position equals: 20 @ 210.

	self assert: parent extent equals: 200 @ 400.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellsFitContentLimitedRespectMinimumHeight [
	<gtExample>
	<return: #BlElement>
	| parent firstBody secondBody |
	parent := self exampleCellFitContentLimitedBelowHeader.
	firstBody := parent children second.
	firstBody constraints minHeight: 60.
	secondBody := BlElement new
			layout: BlLinearLayout vertical;
			background: Color paleGreen;
			constraintsDo: [ :c | 
				c horizontal exact: 200.
				c vertical fitContentLimited ].
	secondBody addChild: (BlElement new size: 200 @ 1000).
	parent addChild: secondBody.
	parent forceLayout.
	self assert: firstBody extent equals: 200 @ 60.
	self assert: secondBody position equals: 0 @ 80.
	self assert: secondBody extent equals: 200 @ 20.
	^ parent
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellsFitContentLimitedShareRemainingHeight [
	<gtExample>
	<return: #BlElement>
	| parent firstBody secondBody |
	parent := self exampleCellFitContentLimitedBelowHeader.
	firstBody := parent children second.
	secondBody := BlElement new
			layout: BlLinearLayout vertical;
			background: Color paleGreen;
			constraintsDo: [ :c | 
				c horizontal exact: 200.
				c vertical fitContentLimited ].
	secondBody addChild: (BlElement new size: 200 @ 60).
	parent addChild: secondBody.
	parent forceLayout.
	self assert: firstBody extent equals: 200 @ 50.
	self assert: secondBody extent equals: 200 @ 30.
	self assert: secondBody bounds inParent bottom equals: 100.
	^ parent
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellsFitContentLimitedShareRow [
	<gtExample>
	<return: #BlElement>
	| parent header body shortBody |
	parent := self exampleCellFitContentLimitedBelowHeader.
	parent layout columnCount: 2.
	header := parent children first.
	header constraints grid horizontal span: 2.
	body := parent children second.
	body constraints horizontal exact: 100.
	body children first size: 100 @ 1000.
	shortBody := BlElement new
			layout: BlLinearLayout vertical;
			background: Color paleGreen;
			constraintsDo: [ :c | 
				c horizontal exact: 100.
				c vertical fitContentLimited ].
	shortBody addChild: (BlElement new size: 100 @ 30).
	parent addChild: shortBody.
	parent forceLayout.
	self assert: body extent equals: 100 @ 80.
	self assert: shortBody position equals: 100 @ 20.
	self assert: shortBody extent equals: 100 @ 30.
	^ parent
]

{ #category : #examples }
BlGridLayoutExamples >> exampleCellsFitContentLimitedWithWeights [
	<gtExample>
	<return: #BlElement>
	| parent firstBody secondBody |
	parent := self exampleCellFitContentLimitedBelowHeader.
	firstBody := parent children second.
	firstBody children first size: 200 @ 20.
	firstBody constraints grid vertical weight: 3.
	secondBody := BlElement new
			layout: BlLinearLayout vertical;
			background: Color paleGreen;
			constraintsDo: [ :c | 
				c horizontal exact: 200.
				c vertical fitContentLimited.
				c grid vertical weight: 1 ].
	secondBody addChild: (BlElement new size: 200 @ 20).
	parent addChild: secondBody.
	parent forceLayout.
	self assert: firstBody extent equals: 200 @ 50.
	self assert: secondBody position equals: 0 @ 70.
	self assert: secondBody extent equals: 200 @ 30.
	^ parent
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillEmpty [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.

	grid
		fill: array
		from: 0
		to: 1
		with: 1.

	self assert: array equals: #().
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillFirstInFourElements [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid
		fill: array
		from: 0
		to: 1
		with: 1.

	self assert: array equals: #(1 0 0 0).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillForthInFourElements [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid
		fill: array
		from: 3
		to: 4
		with: 1.

	self assert: array equals: #(0 0 0 1).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOneElement [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 1 withAll: 0.

	grid
		fill: array
		from: 0
		to: 1
		with: 1.

	self assert: array equals: #(1).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsEmpty1 [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.

	self
		should: [ grid
				fill: array
				from: -1
				to: 0
				with: 1 ]
		raise: SubscriptOutOfBounds
		description: 'Should raise SubscriptOutOfBounds'.
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsEmpty2 [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.

	self
		should: [ grid
				fill: array
				from: -1
				to: 1
				with: 1 ]
		raise: SubscriptOutOfBounds
		description: 'Should raise SubscriptOutOfBounds'.
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsEmpty3 [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.

	grid
		fill: array
		from: 0
		to: 0
		with: 1.
	self assert: array equals: #().
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsEmpty4 [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	grid
		fill: array
		from: 0
		to: 2
		with: 1.
	self assert: array equals: #().
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsInFourElements1 [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	self
		should: [ grid
				fill: array
				from: -1
				to: 3
				with: 1 ]
		raise: SubscriptOutOfBounds
		description: 'Should raise SubscriptOutOfBounds'.
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsInFourElements2 [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	self
		should: [ grid
				fill: array
				from: -1
				to: 6
				with: 1 ]
		raise: SubscriptOutOfBounds
		description: 'Should raise SubscriptOutOfBounds'.
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsInFourElements3 [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.
	grid
		fill: array
		from: 4
		to: 6
		with: 1.
	self assert: array equals: #(0 0 0 0).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillSecondInFourElements [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid
		fill: array
		from: 1
		to: 2
		with: 1.

	self assert: array equals: #(0 1 0 0).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillThreeElements [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 3 withAll: 0.

	grid
		fill: array
		from: 0
		to: 3
		with: 1.

	self assert: array equals: #(1 1 1).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillTwoElements [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 2 withAll: 0.

	grid
		fill: array
		from: 0
		to: 2
		with: 1.

	self assert: array equals: #(1 1).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillTwoInFourElements1 [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid
		fill: array
		from: 0
		to: 2
		with: 1.

	self assert: array equals: #(1 1 0 0).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillTwoInFourElements2 [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid
		fill: array
		from: 1
		to: 3
		with: 1.

	self assert: array equals: #(0 1 1 0).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillTwoInFourElements3 [
	<gtExample>
	<return: #BlGridLayoutImpl>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid
		fill: array
		from: 2
		to: 4
		with: 1.

	self assert: array equals: #(0 0 1 1).
	^ grid
]

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleOneCellExactChildInExactParent [
	<gtExample>
	<return: #BlElement>
	| parent child |
	child := self childExact: 200 @ 300.

	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal exact: 300.
	parent constraints vertical exact: 400.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 200 @ 300.
	self assert: child position equals: 0 @ 0.

	self assert: parent extent equals: 300 @ 400.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleOneCellExactChildInFitParent [
	<gtExample>
	<return: #BlElement>
	| parent child |
	child := self childExact: 200 @ 300.

	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 200 @ 300.
	self assert: child position equals: 0 @ 0.

	self assert: parent extent equals: 200 @ 300.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleOneCellMatchChildInExactParent [
	<gtExample>
	<return: #BlElement>
	| parent child |
	child := self childElementMatchingParent.

	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 300.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 400 @ 300.
	self assert: child position equals: 0 @ 0.

	self assert: parent extent equals: 400 @ 300.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #'examples - unit - spans' }
BlGridLayoutExamples >> exampleSpanDistributeOneColumn [
	<gtExample>
	<return: #BlElement>
	| parent childA childB childC |
	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.
	childC := self childElementMatchingParent.

	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 400.
	parent layout columnCount: 1.

	parent
		addChildren: {childA.
				childB.
				childC}.
	parent forceLayout.

	self
		assert: childA constraints grid horizontal spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).
	self
		assert: childA constraints grid vertical spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).

	self
		assert: childB constraints grid horizontal spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).
	self
		assert: childB constraints grid vertical spec span
		equals: (BlGridLayoutInterval min: 1 max: 2).

	self
		assert: childC constraints grid horizontal spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).
	self
		assert: childC constraints grid vertical spec span
		equals: (BlGridLayoutInterval min: 2 max: 3).

	^ parent
]

{ #category : #'examples - unit - spans' }
BlGridLayoutExamples >> exampleSpanDistributeOneRow [
	<gtExample>
	<return: #BlElement>
	| parent childA childB childC |
	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.
	childC := self childElementMatchingParent.

	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 400.
	parent layout rowCount: 1.

	parent
		addChildren: {childA.
				childB.
				childC}.
	parent forceLayout.

	self
		assert: childA constraints grid horizontal spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).
	self
		assert: childA constraints grid vertical spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).

	self
		assert: childB constraints grid horizontal spec span
		equals: (BlGridLayoutInterval min: 1 max: 2).
	self
		assert: childB constraints grid vertical spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).

	self
		assert: childC constraints grid horizontal spec span
		equals: (BlGridLayoutInterval min: 2 max: 3).
	self
		assert: childC constraints grid vertical spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).
	^ parent
]

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleWeightedFillCellsInExactParent [
	<gtExample>
	<return: #BlElement>
	| parent first second |
	parent := self parentWithGridHorizontalLayout.
	parent layout columnCount: 2.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 100.
	first := self childWeightedFill.
	second := self childWeightedFill.
	parent
		addChild: first;
		addChild: second.
	parent forceLayout.
	self assert: first position equals: 0 @ 0.
	self assert: first extent equals: 200 @ 50.
	self assert: second position equals: 200 @ 0.
	self assert: second extent equals: 200 @ 50.
	^parent
]

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleWeightedFillCellsLaidOutNarrowerThanMeasured [
	<gtExample>
	<return: #BlElement>
	| parent first second context |
	parent := self exampleWeightedFillCellsInExactParent.
	first := parent children first.
	second := parent children second.
	context := BlElementBoundsUpdater new.
	parent applyLayoutIn: (0 @ 0 extent: 399 @ 100) context: context.
	context commitChanges.
	self assert: first position equals: 0 @ 0.
	self assert: second position x equals: first width.
	self assert: second bounds inParent right equals: 399.
	^parent
]

{ #category : #'examples - setup' }
BlGridLayoutExamples >> matchWidthFitHeight [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ]
]

{ #category : #'examples - setup' }
BlGridLayoutExamples >> parentWithGridHorizontalLayout [
	<gtExample>
	<return: #BlElement>
	| element |
	element := BlElement new
			border: (BlBorder builder
					dashed;
					paint: Color red;
					width: 3;
					build);
			layout: BlGridLayout horizontal.

	self assert: element layout class equals: BlGridLayout.

	^ element
]

Class {
	#name : #BlHorizontalTreeFlowLayoutExamples,
	#superclass : #Object,
	#category : #'Bloc-Layout-Examples-Tree-Flow'
}

{ #category : #'examples - elements' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlow [
	<gtExample>
	<return: #BlElement>
	| aContainer childA childB |
	aContainer := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			layout: BlHorizontalTreeFlowLayout new.

	childA := BlElement new
			size: 100 @ 100;
			background: Color paleRed;
			constraintsDo: [ :c | 
				c horizontalTreeFlow
					row: 1;
					depth: 1 ].

	childB := BlElement new
			size: 100 @ 100;
			background: Color paleBlue;
			constraintsDo: [ :c | 
				c horizontalTreeFlow
					row: 2;
					depth: 1 ].

	aContainer
		addChildren: {childA.
				childB}.

	^ aContainer
]

{ #category : #'examples - children' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlowNodes [
	"Children constraints:
	A
	B"

	<gtExample>
	<return: #Array>
	| childA childB |
	childA := BlElement new
			size: 100 @ 100;
			background: Color paleRed;
			constraintsDo: [ :c | 
				c horizontalTreeFlow
					row: 1;
					depth: 1 ].

	childB := BlElement new
			size: 100 @ 100;
			background: Color paleBlue;
			constraintsDo: [ :c | 
				c horizontalTreeFlow
					row: 2;
					depth: 1 ].

	^ {childA.
		childB}
]

{ #category : #'examples - grid' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlowNodesTree [
	<gtExample>
	<return: #BlHorizontalTreeFlowLayoutGrid>
	| aTree |
	aTree := BlHorizontalTreeFlowLayoutGrid
			fromLayoutNodes: self singleColumnFlowNodes.

	^ aTree
]

{ #category : #'examples - elements' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnSplitsInTwo [
	<gtExample>
	<return: #BlElement>
	| aContainer |
	aContainer := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			layout: (BlHorizontalTreeFlowLayout new
					numberOfVisibleColumns: 2;
					firstVisibleColumn: 1;
					horizontalOffset: 0;
					cellSpacing: 2).

	aContainer
		when: BlMouseWheelEvent
		do: [ :anEvent | aContainer layoutDo: [ :aLayout | aLayout mouseWheelEvent: anEvent ] ].

	aContainer addChildren: self singleColumnSplitsInTwoFlowNodes.

	^ aContainer
]

{ #category : #'examples - children' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnSplitsInTwoFlowNodes [
	"Children constraints:
	A B
	  C D"
	<gtExample>
	<return: #Array>
	| childA childB childC childD |
	childA := BlElement new
			background: Color paleRed;
			border: Color red;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 1 ].

	childB := BlElement new
			background: Color paleBlue;
			border: Color blue;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 2 ].

	childC := BlElement new
			background: Color paleGreen;
			border: Color green;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 2;
					depth: 2 ].

	childD := BlElement new
			background: Color paleYellow;
			border: Color yellow;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 2;
					depth: 3 ].

	^ {childA.
		childB.
		childC.
		childD}
]

{ #category : #'examples - elements' }
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlow [
	<gtExample>
	<return: #BlElement>
	| aContainer |
	aContainer := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			layout: (BlHorizontalTreeFlowLayout new
					numberOfVisibleColumns: 2;
					firstVisibleColumn: 1;
					horizontalOffset: 0;
					cellSpacing: 2).

	aContainer
		when: BlMouseWheelEvent
		do: [ :anEvent | aContainer layoutDo: [ :aLayout | aLayout mouseWheelEvent: anEvent ] ].

	aContainer addChildren: self twoColumnFlowNodes.

	^ aContainer
]

{ #category : #'examples - children' }
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlowNodes [
	"Children constraints:
	A C
	B  "

	<gtExample>
	<return: #Array>
	| childA childB childC |
	childA := BlElement new
			background: Color paleRed;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 1 ].

	childB := BlElement new
			background: Color paleBlue;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 2;
					depth: 1 ].

	childC := BlElement new
			background: Color paleGreen;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 2 ].

	^ {childA.
		childB.
		childC}
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlowParentNode [
	<gtExample>
	| children childA childB childC |
	children := self twoColumnFlowNodes.
	childA := children first.
	childB := children second.
	childC := children third.

	^ BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new
				in: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				yourself);
		extentSpec: (BlExtentMeasurementSpec atMost: 800 @ 600);
		children: {BlLayoutChildNode new
					constraints: childA constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childA);
					withElement: childA.
				BlLayoutChildNode new
					constraints: childB constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childB);
					withElement: childB.
				BlLayoutChildNode new
					constraints: childC constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childC);
					withElement: childC}
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlowParentNode_layoutSate [
	<gtExample>
	| aState |
	aState := BlHorizontalTreeFlowLayout new
			createStateFor: self twoColumnFlowParentNode.

	^ aState
]

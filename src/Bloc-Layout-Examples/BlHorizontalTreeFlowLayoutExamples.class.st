Class {
	#name : #BlHorizontalTreeFlowLayoutExamples,
	#superclass : #Object,
	#category : #'Bloc-Layout-Examples-Tree-Flow'
}

{ #category : #'examples - elements' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlow [
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

	aContainer addChildren: self bothRowCellsSplitInTwoFlowNodes.

	^ aContainer
]

{ #category : #'examples - children' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowNodes [
	"Children constraints:
	A B D
	  C E
	    F
	    G"

	<gtExample>
	<return: #Array>
	| childA childB childC childD childE childF childG |
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
					row: 1;
					depth: 3 ].

	childE := BlElement new
			background: Color lightMagenta;
			border: Color magenta;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 2;
					depth: 3 ].

	childF := BlElement new
			background: Color paleYellow;
			border: Color yellow;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 3;
					depth: 3 ].

	childG := BlElement new
			background: Color lightMagenta;
			border: Color magenta;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 4;
					depth: 3 ].

	^ {childA.
		childB.
		childC.
		childD.
		childE.
		childF.
		childG}
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode [
	"Children constraints:
	A B D
	  C E
	    F
	    G"

	<gtExample>
	| children childA childB childC childD childE childF childG |
	children := self bothRowCellsSplitInTwoFlowNodes.
	childA := children first.
	childB := children second.
	childC := children third.
	childD := children fourth.
	childE := children fifth.
	childF := children sixth.
	childG := children seventh.

	^ BlLayoutParentNode new
		constraints: BlLayoutCommonConstraints new;
		extentSpec: (BlExtentMeasurementSpec exact: 800 @ 600);
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
					withElement: childC.
				BlLayoutChildNode new
					constraints: childD constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childD);
					withElement: childD.
				BlLayoutChildNode new
					constraints: childE constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childE);
					withElement: childE.
				BlLayoutChildNode new
					constraints: childF constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childF);
					withElement: childF.
				BlLayoutChildNode new
					constraints: childG constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childG);
					withElement: childG}
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_layoutState [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 401 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 401 @ 301.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 800 @ 2.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 800 @ 151.5.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 800 @ 301.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 800 @ 450.5.
	self assert: aChild extent equals: 397 @ 147.5.

	^ aState
]

{ #category : #'examples - elements' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow [
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

	aContainer addChildren: self rowCellSplitsInTwoFlowNodes.

	^ aContainer
]

{ #category : #'examples - children' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlowNodes [
	"Children constraints:
	A B
	  C D
	    E"

	<gtExample>
	<return: #Array>
	| childA childB childC childD childE |
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
					row: 3;
					depth: 3 ].

	childE := BlElement new
			background: Color lightMagenta;
			border: Color magenta;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 4;
					depth: 3 ].

	^ {childA.
		childB.
		childC.
		childD.
		childE}
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlowParentNode [
	"Children constraints:
	A B
	  C D
	    E"

	<gtExample>
	| children childA childB childC childD childE |
	children := self rowCellSplitsInTwoFlowNodes.
	childA := children first.
	childB := children second.
	childC := children third.
	childD := children fourth.
	childE := children fifth.

	^ BlLayoutParentNode new
		constraints: BlLayoutCommonConstraints new;
		extentSpec: (BlExtentMeasurementSpec exact: 800 @ 600);
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
					withElement: childC.
				BlLayoutChildNode new
					constraints: childD constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childD);
					withElement: childD.
				BlLayoutChildNode new
					constraints: childE constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childE);
					withElement: childE}
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlowParentNode_layoutState [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlowParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 401 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 401 @ 301.
	self assert: aChild extent equals: 397 @ 297.

	"aChild := aParentNode children fourth.
	self assert: aChild position equals: 800 @ 301.
	self assert: aChild extent equals: 397 @ 297."

	^ aState
]

{ #category : #'examples - elements' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlow [
	<gtExample>
	<return: #BlElement>
	| aContainer |
	aContainer := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			layout: BlHorizontalTreeFlowLayout new.

	aContainer addChildren: self singleColumnFlowNodes.

	^ aContainer
]

{ #category : #'examples - children' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlowNodes [
	"Children constraints:
	A
	B"

	<gtExample>
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

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlowParentNode [
	"Children constraints:
	A
	B"

	<gtExample>
	| children childA childB |
	children := self singleColumnFlowNodes.
	childA := children first.
	childB := children second.

	^ BlLayoutParentNode new
		constraints: BlLayoutCommonConstraints new;
		extentSpec: (BlExtentMeasurementSpec exact: 800 @ 600);
		children: {BlLayoutChildNode new
					constraints: childA constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childA);
					withElement: childA.
				BlLayoutChildNode new
					constraints: childB constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childB);
					withElement: childB}
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlowParentNode_layoutState [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self singleColumnFlowParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.

	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 100 @ 100.

	aChild := aParentNode children second.
	self assert: aChild position equals: 2 @ 301.
	self assert: aChild extent equals: 100 @ 100.

	^ aState
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

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnSplitsInTwoParentNode [
	"Children constraints:
	A B
	  C D"

	<gtExample>
	| children childA childB childC childD |
	children := self singleColumnSplitsInTwoFlowNodes.
	childA := children first.
	childB := children second.
	childC := children third.
	childD := children fourth.

	^ BlLayoutParentNode new
		constraints: BlLayoutCommonConstraints new;
		extentSpec: (BlExtentMeasurementSpec exact: 800 @ 600);
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
					withElement: childC.
				BlLayoutChildNode new
					constraints: childD constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childD);
					withElement: childD}
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnSplitsInTwoParentNode_layoutState [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self singleColumnSplitsInTwoParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 401 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 401 @ 301.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 800 @ 301.
	self assert: aChild extent equals: 397 @ 297.

	^ aState
]

{ #category : #'examples - elements' }
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlow1 [
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

	aContainer addChildren: self twoColumnFlow1Nodes.

	^ aContainer
]

{ #category : #'examples - children' }
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlow1Nodes [
	"Children constraints:
	A C
	B  "

	<gtExample>
	<return: #Array>
	| childA childB childC |
	childA := BlElement new
			id: #'childA-row-1-depth-1';
			background: Color paleRed;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 1 ].

	childB := BlElement new
			id: #'childB-row-2-depth-1';
			background: Color paleBlue;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 2;
					depth: 1 ].

	childC := BlElement new
			id: #'childC-row-1-depth-2';
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
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlow1ParentNode [
	"Children constraints:
	A C
	B  "

	<gtExample>
	| children childA childB childC |
	children := self twoColumnFlow1Nodes.
	childA := children first.
	childB := children second.
	childC := children third.

	^ BlLayoutParentNode new
		constraints: BlLayoutCommonConstraints new;
		extentSpec: (BlExtentMeasurementSpec exact: 800 @ 600);
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
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlow1ParentNode_layoutSate [
	<gtExample>
	| aState |
	aState := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0.5;
			cellSpacing: 2;
			createStateFor: self twoColumnFlow1ParentNode.
			
	aState measureAndPlaceChildren.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlow1ParentNode_layoutState [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self twoColumnFlow1ParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children second.
	self assert: aChild position equals: 2 @ 301.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 401 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	^ aState
]

{ #category : #'examples - elements' }
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlow2 [
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

	aContainer addChildren: self twoColumnFlow2Nodes.

	^ aContainer
]

{ #category : #'examples - children' }
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlow2Nodes [
	"Children constraints:
	A  
	B C"

	<gtExample>
	<return: #Array>
	| childA childB childC |
	childA := BlElement new
			id: #'childA-row-1-depth-1';
			background: Color paleRed;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 1 ].

	childB := BlElement new
			id: #'childB-row-2-depth-1';
			background: Color paleBlue;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 2;
					depth: 1 ].

	childC := BlElement new
			id: #'childC-row-1-depth-2';
			background: Color paleGreen;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 2;
					depth: 2 ].

	^ {childA.
		childB.
		childC}
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlow2ParentNode [
	"Children constraints:
	A  
	B C"

	<gtExample>
	| children childA childB childC |
	children := self twoColumnFlow2Nodes.
	childA := children first.
	childB := children second.
	childC := children third.

	^ BlLayoutParentNode new
		constraints: BlLayoutCommonConstraints new;
		extentSpec: (BlExtentMeasurementSpec exact: 800 @ 600);
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
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlow2ParentNode_layoutState [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self twoColumnFlow2ParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children second.
	self assert: aChild position equals: 2 @ 301.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 401 @ 301.
	self assert: aChild extent equals: 397 @ 297.

	^ aState
]

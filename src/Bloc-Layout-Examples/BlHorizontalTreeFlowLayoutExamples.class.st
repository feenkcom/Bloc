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

{ #category : #'examples - parent node' }
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

{ #category : #'examples - parent node' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact250Width [
	"Children constraints:
	A B D
	  C E
	    F
	    G"

	<gtExample>
	| parentNode |
	parentNode := self bothRowCellsSplitInTwoFlowParentNode.
	parentNode children do: [ :eachChild | eachChild constraints horizontal exact: 250 ].
	
	^ parentNode
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact250Width_layoutState [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact250Width.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 250 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 254 @ 2.
	self assert: aChild extent equals: 250 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 254 @ 301.
	self assert: aChild extent equals: 250 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 506 @ 2.
	self assert: aChild extent equals: 250 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 506 @ 151.5.
	self assert: aChild extent equals: 250 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 506 @ 301.
	self assert: aChild extent equals: 250 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 506 @ 450.5.
	self assert: aChild extent equals: 250 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact250Width_layoutState_secondVisibleColumn [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact250Width.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 2;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 250 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 254 @ 2.
	self assert: aChild extent equals: 250 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 254 @ 301.
	self assert: aChild extent equals: 250 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 506 @ 2.
	self assert: aChild extent equals: 250 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 506 @ 151.5.
	self assert: aChild extent equals: 250 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 506 @ 301.
	self assert: aChild extent equals: 250 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 506 @ 450.5.
	self assert: aChild extent equals: 250 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact250Width_layoutState_thirdVisibleColumn [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact250Width.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 250 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 254 @ 2.
	self assert: aChild extent equals: 250 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 254 @ 301.
	self assert: aChild extent equals: 250 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 506 @ 2.
	self assert: aChild extent equals: 250 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 506 @ 151.5.
	self assert: aChild extent equals: 250 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 506 @ 301.
	self assert: aChild extent equals: 250 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 506 @ 450.5.
	self assert: aChild extent equals: 250 @ 147.5.

	^ aState
]

{ #category : #'examples - parent node' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width [
	"Children constraints:
	A B D
	  C E
	    F
	    G"

	<gtExample>
	| parentNode |
	parentNode := self bothRowCellsSplitInTwoFlowParentNode.
	parentNode children do: [ :eachChild | eachChild constraints horizontal exact: 350 ].
	
	^ parentNode
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 354 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 354 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 706 @ 2.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 706 @ 151.5.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 706 @ 301.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 706 @ 450.5.
	self assert: aChild extent equals: 350 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState_secondVisibleColumn [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 2;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -256 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 96 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 96 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 448 @ 2.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 448 @ 151.5.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 448 @ 301.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 448 @ 450.5.
	self assert: aChild extent equals: 350 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState_secondVisibleColumn_minus01 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 2;
			horizontalOffset: -0.1;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -176 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 176 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 176 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 528 @ 2.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 528 @ 151.5.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 528 @ 301.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 528 @ 450.5.
	self assert: aChild extent equals: 350 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState_secondVisibleColumn_narrowerThirdColumn [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	(aParentNode children allButFirst: 3) do: [ :eachNode | eachNode constraints horizontal exact: 150 ].
	
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 2;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -56 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 296 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 296 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 648 @ 2.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 648 @ 151.5.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 648 @ 301.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 648 @ 450.5.
	self assert: aChild extent equals: 150 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState_secondVisibleColumn_narrowerThirdColumn_minus001 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	(aParentNode children allButFirst: 3) do: [ :eachNode | eachNode constraints horizontal exact: 150 ].
	
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 2;
			horizontalOffset: -0.01;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -48 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 304 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 304 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 656 @ 2.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 656 @ 151.5.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 656 @ 301.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 656 @ 450.5.
	self assert: aChild extent equals: 150 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState_secondVisibleColumn_narrowerThirdColumn_minus01 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	(aParentNode children allButFirst: 3) do: [ :eachNode | eachNode constraints horizontal exact: 150 ].
	
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 2;
			horizontalOffset: -0.1;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 354 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 354 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 706 @ 2.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 706 @ 151.5.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 706 @ 301.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 706 @ 450.5.
	self assert: aChild extent equals: 150 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState_thirdVisibleColumn [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -256 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 96 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 96 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 448 @ 2.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 448 @ 151.5.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 448 @ 301.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 448 @ 450.5.
	self assert: aChild extent equals: 350 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState_thirdVisibleColumn_minus005 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: -0.05;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -216 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 136 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 136 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 488 @ 2.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 488 @ 151.5.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 488 @ 301.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 488 @ 450.5.
	self assert: aChild extent equals: 350 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState_thirdVisibleColumn_minus01 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: -0.1;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -176 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 176 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 176 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 528 @ 2.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 528 @ 151.5.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 528 @ 301.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 528 @ 450.5.
	self assert: aChild extent equals: 350 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState_thirdVisibleColumn_minus05 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: -0.5;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 354 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 354 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 706 @ 2.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 706 @ 151.5.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 706 @ 301.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 706 @ 450.5.
	self assert: aChild extent equals: 350 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState_thirdVisibleColumn_minus08 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: -0.8;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 354 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 354 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 706 @ 2.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 706 @ 151.5.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 706 @ 301.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 706 @ 450.5.
	self assert: aChild extent equals: 350 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState_thirdVisibleColumn_narrowerThirdColumn [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	(aParentNode children allButFirst: 3) do: [ :eachNode | eachNode constraints horizontal exact: 150 ].
	
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -56 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 296 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 296 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 648 @ 2.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 648 @ 151.5.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 648 @ 301.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 648 @ 450.5.
	self assert: aChild extent equals: 150 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState_thirdVisibleColumn_narrowerThirdColumn_minus001 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	(aParentNode children allButFirst: 3) do: [ :eachNode | eachNode constraints horizontal exact: 150 ].
	
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: -0.01;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -48 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 304 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 304 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 656 @ 2.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 656 @ 151.5.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 656 @ 301.
	self assert: aChild extent equals: 150 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 656 @ 450.5.
	self assert: aChild extent equals: 150 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_exact350Width_layoutState_thirdVisibleColumn_plus01 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode_exact350Width.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: 0.1;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -256 @ 2.
	self assert: aChild extent equals: 350 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 96 @ 2.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 96 @ 301.
	self assert: aChild extent equals: 350 @ 297.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 448 @ 2.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 448 @ 151.5.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 448 @ 301.
	self assert: aChild extent equals: 350 @ 147.5.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 448 @ 450.5.
	self assert: aChild extent equals: 350 @ 147.5.

	^ aState
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

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> bothRowCellsSplitInTwoFlowParentNode_layoutState_fillEntireColumnHeight [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self bothRowCellsSplitInTwoFlowParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2;
			fillEntireColumnHeight.
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

{ #category : #support }
BlHorizontalTreeFlowLayoutExamples >> installBasicScrollToColumnMetaLink: aLastValue [
	| aNode aMetaLink |
	aNode := (BlHorizontalTreeFlowLayout >> #basicScrollToColumn:in:) ast.
	aMetaLink := MetaLink new
			metaObject: [ :theLayout :anArguments | 
				anArguments second requestLayout.
				anArguments second space doLayout.
				aLastValue at: 1 put: theLayout firstVisibleColumn.
				aLastValue at: 2 put: theLayout horizontalOffset.
				aLastValue at: 3 put: (anArguments second children collect: [ :each | each id identifier -> each position ]) ];
			selector: #value:value:;
			arguments: #(receiver arguments);
			control: #before.
	aNode link: aMetaLink.
	^ aMetaLink
]

{ #category : #'examples - scrolling' }
BlHorizontalTreeFlowLayoutExamples >> installBasicScrollToColumnMetaLink: aLastValue during: aBlock [
	| aMetaLink |
	aMetaLink := self installBasicScrollToColumnMetaLink: aLastValue.
	aBlock ensure: [ aMetaLink uninstall ]
]

{ #category : #'examples - scrolling' }
BlHorizontalTreeFlowLayoutExamples >> installBasicScrollToColumnMetaLinkDuring: aBlock [
	| aMetaLink aLastValue |
	aLastValue := Array new: 3.
	aMetaLink := self installBasicScrollToColumnMetaLink: aLastValue.
	aBlock ensure: [ aMetaLink uninstall ].
	^ aLastValue
]

{ #category : #'examples - children' }
BlHorizontalTreeFlowLayoutExamples >> oneLongLineNodes [
	"Children constraints:
	A B C D E F G"

	<gtExample>
	<return: #Array>
	| childA childB childC childD childE childF childG |
	childA := BlElement new
			id: #'child-A';
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
			id: #'child-B';
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
			id: #'child-C';
			background: Color paleGreen;
			border: Color green;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 3 ].

	childD := BlElement new
			id: #'child-D';
			background: Color paleYellow;
			border: Color yellow;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 4 ].

	childE := BlElement new
			id: #'child-E';
			background: Color lightMagenta;
			border: Color magenta;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 5 ].

	childF := BlElement new
			id: #'child-F';
			background: Color paleYellow;
			border: Color yellow;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 6 ].

	childG := BlElement new
			id: #'child-G';
			background: Color lightMagenta;
			border: Color magenta;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 7 ].

	^ {childA.
		childB.
		childC.
		childD.
		childE.
		childF.
		childG}
]

{ #category : #'examples - parent node' }
BlHorizontalTreeFlowLayoutExamples >> oneLongLineParentNode [
	"Children constraints:
	A B C D E F G"

	<gtExample>
	| children childA childB childC childD childE childF childG |
	children := self oneLongLineNodes.
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
BlHorizontalTreeFlowLayoutExamples >> oneLongLineParentNode_layoutState [
	<gtExample>
	| aState aParent aParentNode aChild aLayout |
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: 0;
			cellSpacing: 2.

	aParent := BlElement new
			layout: aLayout;
			constraintsDo: [ :c | 
				c horizontal exact: 800.
				c vertical exact: 600 ];
			addChildren: self oneLongLineNodes.
	aParentNode := (BlLayoutParentNode toMeasure: aParent)
			extentSpec: (BlExtentMeasurementSpec exact: 800 @ 600).
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.

	aChild := aParentNode children first.
	self assert: aChild position equals: -796 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: -397 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children third.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 401 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 800 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 1199 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 1598 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	^ aState
]

{ #category : #'examples - scrolling' }
BlHorizontalTreeFlowLayoutExamples >> oneLongLineParentNode_scripter_smoothScrollToColumn1 [
	<gtExample>
	| aScripter aParent aLayout aScrollToColumn aLastValue |
	aScripter := BlScripter new extent: 800 @ 600.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: 0;
			cellSpacing: 2.

	aParent := BlElement new
			layout: aLayout;
			border: (BlBorder paint: Color black);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			addChildren: self oneLongLineNodes.

	aScripter element: aParent.

	aScripter assert
		label: 'Assert C child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-C';
		play.

	aScrollToColumn := 1.
	aLastValue := self
			installBasicScrollToColumnMetaLinkDuring: [ aScripter do
					label: 'Scroll to A child';
					block: [ :anElement | anElement layout smoothScrollToColumn: aScrollToColumn in: anElement ];
					play ].
	aScripter userData at: #lastValue put: aLastValue.

	aScripter assert
		label: 'Assert A child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-A';
		play.

	self assert: (aLastValue at: 1) equals: 3.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) key equals: #'child-A'.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) value equals: 2 @ 2.
	self assert: aLayout firstVisibleColumn equals: aScrollToColumn.
	self assert: aLayout horizontalOffset equals: 0.

	^ aScripter
]

{ #category : #'examples - scrolling' }
BlHorizontalTreeFlowLayoutExamples >> oneLongLineParentNode_scripter_smoothScrollToColumn2 [
	<gtExample>
	| aScripter aParent aLayout aLastValue aScrollToColumn |
	aScripter := BlScripter new extent: 800 @ 600.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: 0;
			cellSpacing: 2.
	aParent := BlElement new
			layout: aLayout;
			border: (BlBorder paint: Color black);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			addChildren: self oneLongLineNodes.
	aScripter element: aParent.
	aScripter assert
		label: 'Assert C child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-C';
		play.

	aScrollToColumn := 2.
	aLastValue := self
			installBasicScrollToColumnMetaLinkDuring: [ aScripter do
					label: 'Scroll to B child';
					block: [ :anElement | anElement layout smoothScrollToColumn: aScrollToColumn in: anElement ];
					play ].
	aScripter userData at: #lastValue put: aLastValue.

	aScripter assert
		label: 'Assert B child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-B';
		play.

	self assert: (aLastValue at: 1) equals: 3.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) key equals: #'child-B'.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) value equals: 2 @ 2.
	self assert: aLayout firstVisibleColumn equals: 2.
	self assert: aLayout horizontalOffset equals: 0.
	^ aScripter
]

{ #category : #'examples - scrolling' }
BlHorizontalTreeFlowLayoutExamples >> oneLongLineParentNode_scripter_smoothScrollToColumn2_minus025 [
	<gtExample>
	| aScripter aParent aLayout aScrollToColumn aLastValue |
	aScripter := BlScripter new extent: 800 @ 600.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: -0.25;
			cellSpacing: 2.

	aParent := BlElement new
			layout: aLayout;
			border: (BlBorder paint: Color black);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			addChildren: self oneLongLineNodes.

	aScripter element: aParent.

	aScripter assert
		label: 'Assert C child position';
		value: [ :anElement | anElement position ] equals: 202 @ 2;
		/ #'child-C';
		play.

	aScrollToColumn := 2.
	aLastValue := self
			installBasicScrollToColumnMetaLinkDuring: [ aScripter do
					label: 'Scroll to B child';
					block: [ :anElement | anElement layout smoothScrollToColumn: aScrollToColumn in: anElement ];
					play ].
	aScripter userData at: #lastValue put: aLastValue.

	aScripter assert
		label: 'Assert B child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-B';
		play.

	self assert: (aLastValue at: 1) equals: 3.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) key equals: #'child-B'.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) value equals: 2 @ 2.
	self assert: aLayout firstVisibleColumn equals: 2.
	self assert: aLayout horizontalOffset equals: 0.

	^ aScripter
]

{ #category : #'examples - scrolling' }
BlHorizontalTreeFlowLayoutExamples >> oneLongLineParentNode_scripter_smoothScrollToColumn2_plus025 [
	<gtExample>
	| aScripter aParent aLayout aScrollToColumn aLastValue |
	aScripter := BlScripter new extent: 800 @ 600.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: 0.25;
			cellSpacing: 2.

	aParent := BlElement new
			layout: aLayout;
			border: (BlBorder paint: Color black);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			addChildren: self oneLongLineNodes.

	aScripter element: aParent.

	aScripter assert
		label: 'Assert C child position';
		value: [ :anElement | anElement position ] equals: -198 @ 2;
		/ #'child-C';
		play.

	aScrollToColumn := 2.
	aLastValue := self
			installBasicScrollToColumnMetaLinkDuring: [ aScripter do
					label: 'Scroll to B child';
					block: [ :anElement | anElement layout smoothScrollToColumn: aScrollToColumn in: anElement ];
					play ].
	aScripter userData at: #lastValue put: aLastValue.

	aScripter assert
		label: 'Assert B child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-B';
		play.

	self assert: (aLastValue at: 1) equals: 3.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) key equals: #'child-B'.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) value equals: 2 @ 2.
	self assert: aLayout firstVisibleColumn equals: 2.
	self assert: aLayout horizontalOffset equals: 0.

	^ aScripter
]

{ #category : #'examples - scrolling' }
BlHorizontalTreeFlowLayoutExamples >> oneLongLineParentNode_scripter_smoothScrollToColumn4 [
	<gtExample>
	| aScripter aParent aLayout aScrollToColumn aLastValue |
	aScripter := BlScripter new extent: 800 @ 600.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: 0;
			cellSpacing: 2.

	aParent := BlElement new
			layout: aLayout;
			border: (BlBorder paint: Color black);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			addChildren: self oneLongLineNodes.

	aScripter element: aParent.

	aScripter assert
		label: 'Assert C child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-C';
		play.

	aScrollToColumn := 4.
	aLastValue := self
			installBasicScrollToColumnMetaLinkDuring: [ aScripter do
					label: 'Scroll to D child';
					block: [ :anElement | anElement layout smoothScrollToColumn: aScrollToColumn in: anElement ];
					play ].
	aScripter userData at: #lastValue put: aLastValue.

	aScripter assert
		label: 'Assert D child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-D';
		play.

	self assert: (aLastValue at: 1) equals: 3.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) key equals: #'child-D'.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) value equals: 2 @ 2.
	self assert: aLayout firstVisibleColumn equals: 4.
	self assert: aLayout horizontalOffset equals: 0.

	^ aScripter
]

{ #category : #'examples - scrolling' }
BlHorizontalTreeFlowLayoutExamples >> oneLongLineParentNode_scripter_smoothScrollToColumn4_minus025 [
	<gtExample>
	| aScripter aParent aLayout aScrollToColumn aLastValue |
	aScripter := BlScripter new extent: 800 @ 600.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: -0.25;
			cellSpacing: 2.

	aParent := BlElement new
			layout: aLayout;
			border: (BlBorder paint: Color black);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			addChildren: self oneLongLineNodes.

	aScripter element: aParent.

	aScripter assert
		label: 'Assert C child position';
		value: [ :anElement | anElement position ] equals: 202 @ 2;
		/ #'child-C';
		play.

	aScrollToColumn := 4.
	aLastValue := self
			installBasicScrollToColumnMetaLinkDuring: [ aScripter do
					label: 'Scroll to D child';
					block: [ :anElement | anElement layout smoothScrollToColumn: aScrollToColumn in: anElement ];
					play ].
	aScripter userData at: #lastValue put: aLastValue.

	aScripter assert
		label: 'Assert D child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-D';
		play.

	self assert: (aLastValue at: 1) equals: 3.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) key equals: #'child-D'.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) value equals: 2 @ 2.
	self assert: aLayout firstVisibleColumn equals: 4.
	self assert: aLayout horizontalOffset equals: 0.

	^ aScripter
]

{ #category : #'examples - scrolling' }
BlHorizontalTreeFlowLayoutExamples >> oneLongLineParentNode_scripter_smoothScrollToColumn4_plus025 [
	<gtExample>
	| aScripter aParent aLayout aScrollToColumn aLastValue |
	aScripter := BlScripter new extent: 800 @ 600.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: 0.25;
			cellSpacing: 2.

	aParent := BlElement new
			layout: aLayout;
			border: (BlBorder paint: Color black);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			addChildren: self oneLongLineNodes.

	aScripter element: aParent.

	aScripter assert
		label: 'Assert C child position';
		value: [ :anElement | anElement position ] equals: -198 @ 2;
		/ #'child-C';
		play.

	aScrollToColumn := 4.
	aLastValue := self
			installBasicScrollToColumnMetaLinkDuring: [ aScripter do
					label: 'Scroll to D child';
					block: [ :anElement | anElement layout smoothScrollToColumn: aScrollToColumn in: anElement ];
					play ].
	aScripter userData at: #lastValue put: aLastValue.

	aScripter assert
		label: 'Assert D child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-D';
		play.

	self assert: (aLastValue at: 1) equals: 3.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) key equals: #'child-D'.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) value equals: 2 @ 2.
	self assert: aLayout firstVisibleColumn equals: 4.
	self assert: aLayout horizontalOffset equals: 0.

	^ aScripter.
]

{ #category : #'examples - scrolling' }
BlHorizontalTreeFlowLayoutExamples >> oneLongLineParentNode_scripter_smoothScrollToColumn6 [
	<gtExample>
	| aScripter aParent aLayout aScrollToColumn aLastValue |
	aScripter := BlScripter new extent: 800 @ 600.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: 0;
			cellSpacing: 2.

	aParent := BlElement new
			layout: aLayout;
			border: (BlBorder paint: Color black);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			addChildren: self oneLongLineNodes.

	aScripter element: aParent.

	aScripter assert
		label: 'Assert C child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-C';
		play.

	aScrollToColumn := 6.
	aLastValue := self
			installBasicScrollToColumnMetaLinkDuring: [ aScripter do
					label: 'Scroll to F child';
					block: [ :anElement | anElement layout smoothScrollToColumn: aScrollToColumn in: anElement ];
					play ].
	aScripter userData at: #lastValue put: aLastValue.

	aScripter assert
		label: 'Assert F child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-F';
		play.

	self assert: (aLastValue at: 1) equals: 3.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) key equals: #'child-F'.
	self assert: ((aLastValue at: 3) at: aScrollToColumn) value equals: 2 @ 2.
	self assert: aLayout firstVisibleColumn equals: aScrollToColumn.
	self assert: aLayout horizontalOffset equals: 0.

	^ aScripter
]

{ #category : #'examples - scrolling' }
BlHorizontalTreeFlowLayoutExamples >> oneLongLineParentNode_scripter_smoothScrollToColumn7 [
	<gtExample>
	| aScripter aParent aLayout aScrollToColumn aLastValue |
	aScripter := BlScripter new extent: 800 @ 600.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: 0;
			cellSpacing: 2.

	aParent := BlElement new
			layout: aLayout;
			border: (BlBorder paint: Color black);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			addChildren: self oneLongLineNodes.

	aScripter element: aParent.

	aScripter assert
		label: 'Assert C child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-C';
		play.

	aScrollToColumn := 7.
	aLastValue := self
			installBasicScrollToColumnMetaLinkDuring: [ aScripter do
					label: 'Scroll to G child';
					block: [ :anElement | anElement layout smoothScrollToColumn: aScrollToColumn in: anElement ];
					play ].
	aScripter userData at: #lastValue put: aLastValue.

	aScripter assert
		label: 'Assert F child position';
		value: [ :anElement | anElement position ] equals: 2 @ 2;
		/ #'child-F';
		play.

	self assert: (aLastValue at: 1) equals: 3.
	self assert: ((aLastValue at: 3) at: aScrollToColumn - 1) key equals: #'child-F'.
	self assert: ((aLastValue at: 3) at: aScrollToColumn - 1) value equals: 2 @ 2.
	self assert: aLayout firstVisibleColumn equals: aScrollToColumn.
	self assert: aLayout horizontalOffset equals: 0.

	^ aScripter
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
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesNodes [
	"Children constraints:
	A B D
	  C 
	    E
	    F"

	<gtExample>
	<return: #Array>
	| childA childB childC childD childE childF |
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
			background: Color paleOrange;
			border: Color orange;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 3 ].

	childE := BlElement new
			background: Color paleYellow;
			border: Color yellow;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 3;
					depth: 3 ].

	childF := BlElement new
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
		childF}
]

{ #category : #'examples - parent node' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode [
	"Children constraints:
	A B D
	  C 
	    E
	    F"

	<gtExample>
	| children childA childB childC childD childE childF |
	children := self rowCellSplitsInTwoFlow3LeavesNodes.
	childA := children first.
	childB := children second.
	childC := children third.
	childD := children fourth.
	childE := children fifth.
	childF := children sixth.

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
					withElement: childF}
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode_layoutState [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow3LeavesParentNode.
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
	self assert: aChild position equals: 800 @ 301.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 800 @ 450.5.
	self assert: aChild extent equals: 397 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode_layoutState_displayAllColumns [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow3LeavesParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 3;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 264 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 268 @ 2.
	self assert: aChild extent equals: 264 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 268 @ 301.
	self assert: aChild extent equals: 264 @ 297.
	
	aChild := aParentNode children fourth.
	self assert: aChild position equals: 534 @ 2.
	self assert: aChild extent equals: 264 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 534 @ 301.
	self assert: aChild extent equals: 264 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 534 @ 450.5.
	self assert: aChild extent equals: 264 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode_layoutState_fillEntireColumnHeight [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow3LeavesParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2;
			fillEntireColumnHeight.
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
	self assert: (aChild extent closeTo: 397 @ 197.33 precision: 0.01).

	aChild := aParentNode children fifth.
	self assert: (aChild position closeTo: 800 @ 201.33 precision: 0.01).
	self assert: (aChild extent closeTo: 397 @ 197.33 precision: 0.01).

	aChild := aParentNode children sixth.
	self assert: (aChild position closeTo: 800 @ 400.66 precision: 0.01).
	self assert: (aChild extent closeTo: 397 @ 197.33 precision: 0.01).

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode_layoutState_fourthVisibleColumn [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow3LeavesParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 4;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -397 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 2 @ 301.
	self assert: aChild extent equals: 397 @ 297.
	
	aChild := aParentNode children fourth.
	self assert: aChild position equals: 401 @ 2.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 401 @ 301.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 401 @ 450.5.
	self assert: aChild extent equals: 397 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode_layoutState_horizontalOffsetPlus025 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow3LeavesParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0.25;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 - 200 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 401 - 200 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 401 - 200 @ 301.
	self assert: aChild extent equals: 397 @ 297.
	
	aChild := aParentNode children fourth.
	self assert: aChild position equals: 800 - 200 @ 2.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 800 - 200 @ 301.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 800 - 200 @ 450.5.
	self assert: aChild extent equals: 397 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode_layoutState_horizontalOffsetPlus075 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow3LeavesParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0.75;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: 2 - 399 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 401 - 399 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 401 - 399 @ 301.
	self assert: aChild extent equals: 397 @ 297.
	
	aChild := aParentNode children fourth.
	self assert: aChild position equals: 800 - 399 @ 2.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 800 - 399 @ 301.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 800 - 399 @ 450.5.
	self assert: aChild extent equals: 397 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode_layoutState_secondVisibleColumn [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow3LeavesParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 2;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -397 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 2 @ 301.
	self assert: aChild extent equals: 397 @ 297.
	
	aChild := aParentNode children fourth.
	self assert: aChild position equals: 401 @ 2.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 401 @ 301.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 401 @ 450.5.
	self assert: aChild extent equals: 397 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode_layoutState_secondVisibleColumn_horizontalOffsetMinus025 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow3LeavesParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 2;
			horizontalOffset: -0.25;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -397 + 200 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 2 + 200 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 2 + 200 @ 301.
	self assert: aChild extent equals: 397 @ 297.
	
	aChild := aParentNode children fourth.
	self assert: aChild position equals: 401 + 200 @ 2.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 401 + 200 @ 301.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 401 + 200 @ 450.5.
	self assert: aChild extent equals: 397 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode_layoutState_secondVisibleColumn_horizontalOffsetMinus075 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow3LeavesParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 2;
			horizontalOffset: -0.75;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -397 + 399 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 2 + 399 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 2 + 399 @ 301.
	self assert: aChild extent equals: 397 @ 297.
	
	aChild := aParentNode children fourth.
	self assert: aChild position equals: 401 + 399 @ 2.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 401 + 399 @ 301.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 401 + 399 @ 450.5.
	self assert: aChild extent equals: 397 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode_layoutState_secondVisibleColumn_horizontalOffsetPlus025 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow3LeavesParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 2;
			horizontalOffset: 0.25;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -397 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 2 @ 301.
	self assert: aChild extent equals: 397 @ 297.
	
	aChild := aParentNode children fourth.
	self assert: aChild position equals: 401 @ 2.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 401 @ 301.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 401 @ 450.5.
	self assert: aChild extent equals: 397 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode_layoutState_span [
	<gtExample>
	| aState aParentNode aChild aLayout childD |
	aParentNode := self rowCellSplitsInTwoFlow3LeavesParentNode.
	childD := aParentNode children at: 4.
	self assert: childD constraints horizontalTreeFlow row equals: 1.
	self assert: childD constraints horizontalTreeFlow depth equals: 3.
	childD constraints horizontalTreeFlow span: 2.
	self assert: childD constraints horizontalTreeFlow span equals: 2.

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
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 800 @ 301.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 800 @ 450.5.
	self assert: aChild extent equals: 397 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode_layoutState_span_fillEntireColumnHeight [
	<gtExample>
	| aState aParentNode aChild aLayout childD |
	aParentNode := self rowCellSplitsInTwoFlow3LeavesParentNode.
	childD := aParentNode children at: 4.
	self assert: childD constraints horizontalTreeFlow row equals: 1.
	self assert: childD constraints horizontalTreeFlow depth equals: 3.
	childD constraints horizontalTreeFlow span: 2.
	self assert: childD constraints horizontalTreeFlow span equals: 2.

	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2;
			fillEntireColumnHeight.
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
	self assert: (aChild extent closeTo: 397 @ 197.33 precision: 0.01).

	aChild := aParentNode children fifth.
	self assert: (aChild position closeTo: 800 @ 201.33 precision: 0.01).
	self assert: (aChild extent closeTo: 397 @ 197.33 precision: 0.01).

	aChild := aParentNode children sixth.
	self assert: (aChild position closeTo: 800 @ 400.66 precision: 0.01).
	self assert: (aChild extent closeTo: 397 @ 197.33 precision: 0.01).

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3LeavesParentNode_layoutState_thirdVisibleColumn [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow3LeavesParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 3;
			horizontalOffset: 0;
			cellSpacing: 2.
	aState := aLayout createStateFor: aParentNode.

	aState measureAndPlaceChildren.
	
	aChild := aParentNode children first.
	self assert: aChild position equals: -397 @ 2.
	self assert: aChild extent equals: 397 @ 596.

	aChild := aParentNode children second.
	self assert: aChild position equals: 2 @ 2.
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children third.
	self assert: aChild position equals: 2 @ 301.
	self assert: aChild extent equals: 397 @ 297.
	
	aChild := aParentNode children fourth.
	self assert: aChild position equals: 401 @ 2.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 401 @ 301.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children sixth.
	self assert: aChild position equals: 401 @ 450.5.
	self assert: aChild extent equals: 397 @ 147.5.

	^ aState
]

{ #category : #'examples - children' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3TopLeavesNodes [
	"Children constraints:
	A B D
	  C E
	    F
	    ."

	<gtExample>
	<return: #Array>
	| childA childB childC childD childE childF |
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
			background: Color paleOrange;
			border: Color orange;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 3 ].

	childE := BlElement new
			background: Color paleYellow;
			border: Color yellow;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 2;
					depth: 3 ].

	childF := BlElement new
			background: Color lightMagenta;
			border: Color magenta;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 3;
					depth: 3;
					span: 2 ].

	^ {childA.
		childB.
		childC.
		childD.
		childE.
		childF}
]

{ #category : #'examples - parent node' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3TopLeavesParentNode [
	"Children constraints:
	A B D
	  C E
	    F
	    ."

	<gtExample>
	| children childA childB childC childD childE childF |
	children := self rowCellSplitsInTwoFlow3TopLeavesNodes.
	childA := children first.
	childB := children second.
	childC := children third.
	childD := children fourth.
	childE := children fifth.
	childF := children sixth.

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
					withElement: childF}
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3TopLeavesParentNode_layoutState [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow3TopLeavesParentNode.
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
	self assert: aChild extent equals: 397 @ 297.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow3TopLeavesParentNode_layoutState_fillEntireColumnHeight [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow3TopLeavesParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2;
			fillEntireColumnHeight.
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
	self assert: (aChild extent closeTo: 397 @ 197.33 precision: 0.01).

	aChild := aParentNode children fifth.
	self assert: (aChild position closeTo: 800 @ 201.33 precision: 0.01).
	self assert: (aChild extent closeTo: 397 @ 197.33 precision: 0.01).

	aChild := aParentNode children sixth.
	self assert: (aChild position closeTo: 800 @ 400.66 precision: 0.01).
	self assert: (aChild extent closeTo: 397 @ 197.33 precision: 0.01).

	^ aState
]

{ #category : #'examples - elements' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow5Leaves [
	<gtExample>
	<return: #BlElement>
	| aContainer |
	aContainer := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			layout: (BlHorizontalTreeFlowLayout new
					numberOfVisibleColumns: 3;
					firstVisibleColumn: 1;
					horizontalOffset: 0;
					cellSpacing: 2).

	aContainer
		when: BlMouseWheelEvent
		do: [ :anEvent | aContainer layoutDo: [ :aLayout | aLayout mouseWheelEvent: anEvent ] ].

	aContainer addChildren: self rowCellSplitsInTwoFlow5LeavesNodes.

	^ aContainer
]

{ #category : #'examples - children' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow5LeavesNodes [
	"Children constraints:
	A B D
	  C E
	    F
	    G
	    H
	A has B C
	B has E D
	C has F G H"

	<gtExample>
	<return: #Array>
	| childA childB childC childD childE childF childG childH |
	childA := BlElement new
			id: #A;
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
			id: #B;
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
			id: #C;
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
			id: #D;
			background: Color paleOrange;
			border: Color orange;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 1;
					depth: 3;
					span: 3 ].

	childE := BlElement new
			id: #E;
			background: Color paleYellow;
			border: Color yellow;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 4;
					depth: 3;
					span: 3 ].

	childF := BlElement new
			id: #F;
			background: Color lightMagenta;
			border: Color magenta;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 7;
					depth: 3;
					span: 2 ].

	childG := BlElement new
			id: #G;
			background: Color purple muchLighter;
			border: Color purple;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 9;
					depth: 3;
					span: 2 ].

	childH := BlElement new
			id: #H;
			background: Color lightBrown;
			border: Color brown;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 11;
					depth: 3;
					span: 2 ].

	^ {childA.
		childB.
		childC.
		childD.
		childE.
		childF.
		childG.
		childH}
]

{ #category : #'examples - parent node' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow5LeavesParentNode [
	"Children constraints:
	A B D
	  C E
	    F
	    G
	    H
	A has B C
	B has E D
	C has F G H"

	<gtExample>
	| children childA childB childC childD childE childF childG childH |
	children := self rowCellSplitsInTwoFlow5LeavesNodes.
	childA := children first.
	childB := children second.
	childC := children third.
	childD := children fourth.
	childE := children fifth.
	childF := children sixth.
	childG := children seventh.
	childH := children eighth.

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
					withElement: childG.
				BlLayoutChildNode new
					constraints: childH constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childH);
					withElement: childH}
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow5LeavesParentNode_layoutState [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow5LeavesParentNode.
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
	self assert: (aChild extent closeTo: 397 @ 97.7 precision: 0.1).

	aChild := aParentNode children seventh.
	self assert: (aChild position closeTo: 800 @ 400.6 precision: 0.1).
	self assert: (aChild extent closeTo: 397 @ 97.7 precision: 0.1).
	
	aChild := aParentNode children eighth.
	self assert: (aChild position closeTo: 800 @ 500.3 precision: 0.1).
	self assert: (aChild extent closeTo: 397 @ 97.7 precision: 0.1).

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlow5LeavesParentNode_layoutState_fillEntireColumnHeight [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlow5LeavesParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2;
			fillEntireColumnHeight.
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
	self assert: aChild extent equals: 397 @ 117.6.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 800 @ 121.6.
	self assert: aChild extent equals: 397 @ 117.6.
	
	aChild := aParentNode children sixth.
	self assert: aChild position equals: 800 @ 241.2.
	self assert: aChild extent equals: 397 @ 117.6.

	aChild := aParentNode children seventh.
	self assert: aChild position equals: 800 @ 360.8.
	self assert: aChild extent equals: 397 @ 117.6.
	
	aChild := aParentNode children eighth.
	self assert: aChild position equals: 800 @ 480.4.
	self assert: aChild extent equals: 397 @ 117.6.

	^ aState
]

{ #category : #'examples - children' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlowNodes [
	"Children constraints:
	A B
	  C 
	    D
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

{ #category : #'examples - parent node' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlowParentNode [
	"Children constraints:
	A B
	  C 
	    D
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

	aChild := aParentNode children fourth.
	self assert: aChild position equals: 800 @ 301.
	self assert: aChild extent equals: 397 @ 147.5.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 800 @ 450.5.
	self assert: aChild extent equals: 397 @ 147.5.

	^ aState
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInTwoFlowParentNode_layoutState_fillEntireColumnHeight [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInTwoFlowParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2;
			fillEntireColumnHeight.
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
	self assert: aChild extent equals: 397 @ 297.

	aChild := aParentNode children fifth.
	self assert: aChild position equals: 800 @ 301.
	self assert: aChild extent equals: 397 @ 297.

	^ aState
]

{ #category : #'examples - elements' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInto256 [
	<gtExample>
	<return: #BlElement>
	| aContainer |
	aContainer := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			layout: (BlHorizontalTreeFlowLayout new
					numberOfVisibleColumns: 4;
					firstVisibleColumn: 1;
					horizontalOffset: 0;
					cellSpacing: 2).

	aContainer
		when: BlMouseWheelEvent
		do: [ :anEvent | aContainer layoutDo: [ :aLayout | aLayout mouseWheelEvent: anEvent ] ].

	aContainer addChildren: self rowCellSplitsInto256Nodes.

	^ aContainer
]

{ #category : #'examples - children' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInto256Nodes [
	"Children constraints:
	A B D
	    E I
	      J
	  C F K
	    G L
	      M
	      N
	    H
	A has B C
	B has E D
	C has F G H
	E has I J
	F has K
	G has L M N"

	<gtExample>
	<return: #Array>
	| childI childJ childK childL childM childN childG childH |
	childI := BlElement new
			background: Color paleRed;
			border: Color red;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 4;
					depth: 4;
					span: 2 ].

	childJ := BlElement new
			background: Color paleBlue;
			border: Color blue;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 6;
					depth: 4;
					span: 2 ].

	childK := BlElement new
			background: Color paleGreen;
			border: Color green;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 8;
					depth: 4;
					span: 1 ].

	childL := BlElement new
			background: Color paleOrange;
			border: Color orange;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 9;
					depth: 4;
					span: 2 ].

	childM := BlElement new
			background: Color paleYellow;
			border: Color yellow;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 11;
					depth: 4;
					span: 1 ].

	childN := BlElement new
			background: Color lightMagenta;
			border: Color magenta;
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c horizontalTreeFlow
					row: 12;
					depth: 4;
					span: 1 ].

	^ self rowCellSplitsInTwoFlow5LeavesNodes
		, {childI.
				childJ.
				childK.
				childL.
				childM.
				childN}
]

{ #category : #'examples - parent node' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInto256ParentNode [
	"Children constraints:
	A B D
	    E I
	      J
	  C F K
	    G L
	      M
	      N
	    H
	A has B C
	B has E D
	C has F G H
	E has I J
	F has K
	G has L M N"

	<gtExample>
	| children childA childB childC childD childE childF childG childH childI childJ childK childL childM childN |
	children := self rowCellSplitsInto256Nodes.
	childA := children first.
	childB := children second.
	childC := children third.
	childD := children fourth.
	childE := children fifth.
	childF := children sixth.
	childG := children seventh.
	childH := children eighth.
	childI := children at: 9.
	childJ := children at: 10.
	childK := children at: 11.
	childL := children at: 12.
	childM := children at: 13.
	childN := children at: 14.

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
					withElement: childG.
				BlLayoutChildNode new
					constraints: childH constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childH);
					withElement: childH.
				BlLayoutChildNode new
					constraints: childI constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childI);
					withElement: childI.
				BlLayoutChildNode new
					constraints: childJ constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childJ);
					withElement: childJ.
				BlLayoutChildNode new
					constraints: childK constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childK);
					withElement: childK.
				BlLayoutChildNode new
					constraints: childL constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childL);
					withElement: childL.
				BlLayoutChildNode new
					constraints: childM constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childM);
					withElement: childM.
				BlLayoutChildNode new
					constraints: childN constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: childN);
					withElement: childN}
]

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> rowCellSplitsInto256ParentNode_layoutState [
	"Note: currently does not work as expected.
	Observed issues: 
		We do not have a way to computed or explicitly define number of rows in a column,
		which is an issue if last rows are not occupied.
	Possible solutions:
		- We could use empty elements (size: 0@0) to fill the last row.
		- Currently span value has to be an integer. 
		  Maybe having span value as a float value could help. I am not sure about it.
	
	Children constraints:
	A B D
	    E I
	      J
	  C F K
	    G L
	      M
	      N
	    H
	A has B C
	B has E D
	C has F G H
	E has I J
	F has K
	G has L M N"

	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self rowCellSplitsInto256ParentNode.
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
	self assert: (aChild extent closeTo: 397 @ 97.7 precision: 0.1).

	aChild := aParentNode children seventh.
	self assert: (aChild position closeTo: 800 @ 400.6 precision: 0.1).
	self assert: (aChild extent closeTo: 397 @ 97.7 precision: 0.1).

	aChild := aParentNode children eighth.
	self assert: (aChild position closeTo: 800 @ 500.3 precision: 0.1).
	self assert: (aChild extent closeTo: 397 @ 97.7 precision: 0.1).

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

{ #category : #'examples - parent node' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlowFitContentParentNode [
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
		extentSpec: (BlExtentMeasurementSpec unspecified);
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
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlowFitContentParentNode_layoutState [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self singleColumnFlowFitContentParentNode.
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
	self assert: aChild position equals: 2 @ 104.
	self assert: aChild extent equals: 100 @ 100.

	^ aState
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

{ #category : #'examples - parent node' }
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

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlowParentNode_layoutState_horizontalOffsetMinus025 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self singleColumnFlowParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: -0.25;
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

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlowParentNode_layoutState_horizontalOffsetPlus025 [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self singleColumnFlowParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0.25;
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

{ #category : #'examples - parent node' }
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

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnSplitsInTwoParentNode_layoutState_fillEntireColumnHeight [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self singleColumnSplitsInTwoParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2;
			fillEntireColumnHeight.
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
	self assert: aChild extent equals: 397 @ 596.

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

{ #category : #'examples - parent node' }
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

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlow1ParentNode_layoutState_fillEntireColumnHeight [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self twoColumnFlow1ParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2;
			fillEntireColumnHeight.
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
	self assert: aChild extent equals: 397 @ 596.

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

{ #category : #'examples - parent node' }
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

{ #category : #'examples - state' }
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlow2ParentNode_layoutState_fillEntireColumnHeight [
	<gtExample>
	| aState aParentNode aChild aLayout |
	aParentNode := self twoColumnFlow2ParentNode.
	aLayout := BlHorizontalTreeFlowLayout new
			numberOfVisibleColumns: 2;
			firstVisibleColumn: 1;
			horizontalOffset: 0;
			cellSpacing: 2;
			fillEntireColumnHeight.
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
	self assert: aChild extent equals: 397 @ 596.

	^ aState
]

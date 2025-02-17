Class {
	#name : #BlHorizontalTreeFlowLayoutExamples,
	#superclass : #Object,
	#category : #'Bloc-Layout-Examples-Tree-Flow'
}

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlow [
	<gtExample>
	| aContainer childA childB |
	
	aContainer := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlHorizontalTreeFlowLayout new.
	
	childA := BlElement new
		size: 100@100;
		background: Color paleRed;
		constraintsDo: [ :c | c horizontalTreeFlow row: 1; depth: 1 ].
		
	childB := BlElement new
		size: 100@100;
		background: Color paleBlue;
		constraintsDo: [ :c | c horizontalTreeFlow row: 2; depth: 1 ].
		
	aContainer addChildren: { childA . childB }.
	
	^ aContainer
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlowNodes [
	<gtExample>
	| childA childB |
	
	childA := BlElement new
		size: 100@100;
		background: Color paleRed;
		constraintsDo: [ :c | c horizontalTreeFlow row: 1; depth: 1 ].
		
	childB := BlElement new
		size: 100@100;
		background: Color paleBlue;
		constraintsDo: [ :c | c horizontalTreeFlow row: 2; depth: 1 ].
		
	^ { childA . childB }
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnFlowNodesTree [
	<gtExample>
	| aTree |
	
	aTree := BlHorizontalTreeFlowLayoutGrid
		fromLayoutNodes: self singleColumnFlowNodes.
	
	^ aTree
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnSplitsInTwo [
	<gtExample>
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
		do: [ :anEvent |
			aContainer layoutDo: [ :aLayout | aLayout mouseWheelEvent: anEvent ] ].

	aContainer addChildren: self singleColumnSplitsInTwoFlowNodes.

	^ aContainer
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutExamples >> singleColumnSplitsInTwoFlowNodes [
	<gtExample>
	| childA childB childC childD |
	
	childA := BlElement new
		background: Color paleRed;
		border: (Color red);
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c horizontalTreeFlow row: 1; depth: 1 ].

	childB := BlElement new
		background: Color paleBlue;
		border: (Color blue);
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c horizontalTreeFlow row: 1; depth: 2 ].
	
	childC := BlElement new
		background: Color paleGreen;
		border: (Color green);
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c horizontalTreeFlow row: 2; depth: 2 ].

	childD := BlElement new
		background: Color paleYellow;
		border: (Color yellow);
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c horizontalTreeFlow row: 2; depth: 3 ].
		
	^ { childA . childB . childC . childD }
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutExamples >> twoColumnFlowNodes [
	<gtExample>
	| childA childB childC|

	childA := BlElement new
		background: Color paleRed;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c horizontalTreeFlow row: 1; depth: 1 ].
		
	childB := BlElement new
		background: Color paleBlue;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c horizontalTreeFlow row: 2; depth: 1 ].
	
	childC := BlElement new
		background: Color paleGreen;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c horizontalTreeFlow row: 1; depth: 2 ].
	
	^ { childA . childB . childC }
]

Class {
	#name : #BlSteppedLayoutExamples,
	#superclass : #Object,
	#category : #'Bloc-Layout-Examples-Stepped'
}

{ #category : #'as yet unclassified' }
BlSteppedLayoutExamples >> atMostNodeWithTwoExactChildren [
	<gtExample>

	^ BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec atMost: 800@600);
		children: { 
			BlLayoutChildNode new
				constraints: BlLayoutCommonConstraints new;
				measurement: (BlLayoutNodeComputedMeasurement new
					position: (0@0);
					extent: 200@400).
			BlLayoutChildNode new
				constraints: BlLayoutCommonConstraints new;
				measurement: (BlLayoutNodeComputedMeasurement new
					position: (0@0);
					extent: 200@300).
			BlLayoutChildNode new
				constraints: BlLayoutCommonConstraints new;
				measurement: (BlLayoutNodeComputedMeasurement new
					position: (0@0);
					extent: 200@550).
		}.
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutExamples >> atMostNodeWithTwoExactChildren_layoutState [
	<gtExample>
	| aState |

	aState := BlSteppedLayout new
		anchorBounds: (100@100 extent: 50@50);
		createStateFor: self atMostNodeWithTwoExactChildren.

	self assert: aState containerWidth equals: 800.0.
	self assert: aState containerHeight equals: 600.0.

	^ aState
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutExamples >> atMostNodeWithTwoExactChildren_layoutState_measureFirstChild [
	<gtExample>
	| aState aParentNode |
	
	aParentNode := self atMostNodeWithTwoExactChildren.

	aState := BlSteppedLayout new
		anchorBounds: (500@100 extent: 50@50);
		createStateFor: aParentNode.

	self assert: aState containerWidth equals: 800.0.
	self assert: aState containerHeight equals: 600.0.

	aState measureAndPlaceChild: aParentNode children first.

	^ aState
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutExamples >> atMostNodeWithTwoExactChildren_layoutState_measureSecondChild [
	<gtExample>
	| aState aParentNode |
	
	aParentNode := self atMostNodeWithTwoExactChildren.

	aState := self atMostNodeWithTwoExactChildren_layoutState_measureFirstChild.
	
	aState measureAndPlaceChild: aParentNode children second.

	^ aState
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutExamples >> atMostNodeWithTwoExactChildren_layoutState_measureThirdChild [
	<gtExample>
	| aState aParentNode |

	aParentNode := self atMostNodeWithTwoExactChildren.

	aState := self atMostNodeWithTwoExactChildren_layoutState_measureSecondChild.

	aState measureAndPlaceChild: aParentNode children third.

	^ aState
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutExamples >> atMostNodeWithTwoExactChildren_measure [
	<gtExample>
	| aParentNode aLayout |

	aParentNode := self atMostNodeWithTwoExactChildren.

	aLayout := BlSteppedLayout new.
	aLayout anchorBounds: (100@100 extent: 2@2).
	aLayout measure: aParentNode.

	^ aParentNode
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutExamples >> elementWithTwoExactChildren [
	<gtExample>
	| popup childA childB childC |
	
	popup := BlElement new
		layout: BlSteppedLayout new;
		background: (Color veryVeryLightGray alpha: 0.2);
		border: (Color veryVeryLightGray);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	childA := BlElement new
		background: (Color paleBlue alpha: 0.7);
		border: (Color paleBlue darker);
		size: 150@300.

	childB := BlElement new
		background: (Color paleGreen alpha: 0.7);
		border: (Color paleGreen darker);
		size: 200@400.

	childC := BlElement new
		background: (Color paleYellow alpha: 0.7);
		border: (Color paleYellow darker);
		size: 300@200.

	popup addChildren: { childA . childB . childC }.

	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: popup;
		addChild: (BlElement new
			size: 25@25;
			geometry: BlCircleGeometry new;
			background: (Color red alpha: 0.5);
			addEventHandler: BlPullHandler new;
			when: BlElementPositionChangedEvent do: [ :anEvent | popup layoutDo: [ :l | l anchorBounds: anEvent currentTarget bounds inParent asRectangle ] ];
			when: BlElementExtentChangedEvent do: [ :anEvent | popup layoutDo: [ :l | l anchorBounds: anEvent currentTarget bounds inParent asRectangle ] ]).
]

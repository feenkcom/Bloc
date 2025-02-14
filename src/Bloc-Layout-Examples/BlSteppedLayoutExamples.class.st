Class {
	#name : #BlSteppedLayoutExamples,
	#superclass : #Object,
	#category : #'Bloc-Layout-Examples-Stepped'
}

{ #category : #'examples - nodes' }
BlSteppedLayoutExamples >> atMostNodeWithThreeExactChildren [
	<gtExample>

	^ BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec atMost: 800@600);
		children: { 
			BlLayoutChildNode new
				constraints: BlLayoutCommonConstraints new;
				measurement: (BlLayoutNodeComputedMeasurement new
					position: (10@20);
					extent: 200@400).
			BlLayoutChildNode new
				constraints: BlLayoutCommonConstraints new;
				measurement: (BlLayoutNodeComputedMeasurement new
					position: (30@50);
					extent: 200@300).
			BlLayoutChildNode new
				constraints: BlLayoutCommonConstraints new;
				measurement: (BlLayoutNodeComputedMeasurement new
					position: (-50@100);
					extent: 200@550).
		}.
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithThreeExactChildren_layoutState [
	<gtExample>
	| aState |

	aState := BlSteppedLayout new
		anchorBounds: (100@100 extent: 50@50);
		createStateFor: self atMostNodeWithThreeExactChildren.

	self assert: aState containerWidth equals: 800.0.
	self assert: aState containerHeight equals: 600.0.

	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithThreeExactChildren_layoutState_dropdown [
	<gtExample>
	| aState |

	aState := BlSteppedLayout new
		withDropdownAreas;
		anchorBounds: (100@100 extent: 50@50);
		createStateFor: self atMostNodeWithThreeExactChildren.

	self assert: aState containerWidth equals: 800.0.
	self assert: aState containerHeight equals: 600.0.

	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithThreeExactChildren_layoutState_dropdown_measureFirstChild [
	<gtExample>
	| aState aParentNode aChild |
	aParentNode := self atMostNodeWithThreeExactChildren.

	aState := BlSteppedLayout new
			withDropdownAreas;
			anchorBounds: (500 @ 100 extent: 50 @ 50);
			createStateFor: aParentNode.

	self assert: aState containerWidth equals: 800.0.
	self assert: aState containerHeight equals: 600.0.

	aChild := aParentNode children first.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild position
		equals: 500 @ 149.
	self 
		assert: aChild extent
		equals: 200 @ 400.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomRight.

	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithThreeExactChildren_layoutState_dropdown_measureSecondChild [
	<gtExample>
	| aState aParentNode aChild |
	aParentNode := self atMostNodeWithThreeExactChildren.

	aState := self
			atMostNodeWithThreeExactChildren_layoutState_dropdown_measureFirstChild.

	aChild := aParentNode children second.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild position
		equals: 300 @ 149.
	self 
		assert: aChild extent
		equals: 200 @ 300.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomLeft.

	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithThreeExactChildren_layoutState_dropdown_measureThirdChild [
	<gtExample>
	| aState aParentNode aChild |
	aParentNode := self atMostNodeWithThreeExactChildren.

	aState := self
			atMostNodeWithThreeExactChildren_layoutState_dropdown_measureSecondChild.

	aChild := aParentNode children third.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild position
		equals: 100 @ 50.
	self 
		assert: aChild extent
		equals: 200 @ 550.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark allToLeft.

	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithThreeExactChildren_layoutState_measureFirstChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithThreeExactChildren.

	aState := BlSteppedLayout new
		anchorBounds: (500@100 extent: 50@50);
		createStateFor: aParentNode.

	self assert: aState containerWidth equals: 800.0.
	self assert: aState containerHeight equals: 600.0.

	aChild := aParentNode children first.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomRight.
		
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithThreeExactChildren_layoutState_measureSecondChild [
	<gtExample>
	| aState aParentNode |
	
	aParentNode := self atMostNodeWithThreeExactChildren.

	aState := self atMostNodeWithThreeExactChildren_layoutState_measureFirstChild.
	
	aState measureAndPlaceChild: aParentNode children second.

	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithThreeExactChildren_layoutState_measureThirdChild [
	<gtExample>
	| aState aParentNode |

	aParentNode := self atMostNodeWithThreeExactChildren.

	aState := self atMostNodeWithThreeExactChildren_layoutState_measureSecondChild.

	aState measureAndPlaceChild: aParentNode children third.

	^ aState
]

{ #category : #'examples - nodes' }
BlSteppedLayoutExamples >> atMostNodeWithThreeExactChildren_measure [
	<gtExample>
	| aParentNode aLayout |

	aParentNode := self atMostNodeWithThreeExactChildren.

	aLayout := BlSteppedLayout new.
	aLayout anchorBounds: (100@100 extent: 2@2).
	aLayout measure: aParentNode.

	^ aParentNode
]

{ #category : #'examples - showroom' }
BlSteppedLayoutExamples >> elementWithHandleAndTwoRelativeChildren_dropdown [
	<gtExample>
	| popup handle childA sourceA childB sourceB childC |
	popup := BlElement new
			layout: (BlSteppedLayout new 
				withDropdownAreas;
				withCenteredHandle);
			background: (Color veryVeryLightGray alpha: 0.2);
			border: Color veryVeryLightGray;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].

	handle := BlElement new
			background: (Color transparent);
			border: (Color red darker darker alpha: 0.5);
			size: 25@25;
			geometry: BlRectangleGeometry new.
				
	sourceA := BlElement new
			background: (Color paleBlue darker alpha: 0.7);
			border: Color paleBlue darker darker;
			size: 150 @ 40;
			relocate: 0 @ 50;
			addEventHandler: BlPullHandler new beVertical disallowOutOfBounds.

	childA := BlElement new
			background: (Color paleBlue alpha: 0.7);
			border: Color paleBlue darker;
			size: 150 @ 300;
			addChild: sourceA.

	sourceB := BlElement new
			background: (Color paleGreen darker alpha: 0.7);
			border: Color paleGreen darker darker;
			size: 200 @ 40;
			relocate: 0 @ 50;
			addEventHandler: BlPullHandler new beVertical disallowOutOfBounds.
			
	childB := BlElement new
			background: (Color paleGreen alpha: 0.7);
			border: Color paleGreen darker;
			size: 200 @ 400;
			constraintsDo: [ :c | c stepped relativeBounds: (0 @ 50 extent: 150 @ 50) ];
			addChild: sourceB.

	sourceA
		when: BlPullEvent
		do: [ :anEvent | 
			childB
				constraintsDo: [ :c | 
					c stepped
						relativeBounds: (anEvent newPosition extent: anEvent currentTarget extent) ] ].

	childC := BlElement new
			background: (Color paleYellow alpha: 0.7);
			border: Color paleYellow darker;
			size: 100 @ 200;
			constraintsDo: [ :c | c stepped relativeBounds: (0 @ 50 extent: 200 @ 50) ].
			
	sourceB
		when: BlPullEvent
		do: [ :anEvent | 
			childC
				constraintsDo: [ :c | 
					c stepped
						relativeBounds: (anEvent newPosition extent: anEvent currentTarget extent) ] ].

	popup
		addChildren: {handle.
				childA.
				childB.
				childC}.

	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: popup;
		addChild: (BlElement new
				size: 25 @ 25;
				geometry: BlRectangleGeometry new;
				background: (Color red alpha: 0.5);
				addEventHandler: BlPullHandler new disallowOutOfBounds;
				when: BlElementPositionChangedEvent
					do: [ :anEvent | 
						popup
							layoutDo: [ :l | l anchorBounds: anEvent currentTarget bounds inParent asRectangle ] ];
				when: BlElementExtentChangedEvent
					do: [ :anEvent | 
						popup
							layoutDo: [ :l | l anchorBounds: anEvent currentTarget bounds inParent asRectangle ] ])
]

{ #category : #'examples - showroom' }
BlSteppedLayoutExamples >> elementWithHandleAndTwoThreeRelativeChildren [
	<gtExample>
	| popup handle childA sourceA childB sourceB childC |
	popup := BlElement new
			layout: BlSteppedLayout new withCenteredHandle;
			background: (Color veryVeryLightGray alpha: 0.2);
			border: Color veryVeryLightGray;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].

	handle := BlElement new
			background: (Color transparent);
			border: (Color red darker darker alpha: 0.5);
			size: 15@15;
			geometry: BlCircleGeometry new.
				
	sourceA := BlElement new
			background: (Color paleBlue darker alpha: 0.7);
			border: Color paleBlue darker darker;
			size: 150 @ 40;
			relocate: 0 @ 50;
			addEventHandler: BlPullHandler new beVertical disallowOutOfBounds.

	childA := BlElement new
			background: (Color paleBlue alpha: 0.7);
			border: Color paleBlue darker;
			size: 150 @ 300;
			addChild: sourceA.

	sourceB := BlElement new
			background: (Color paleGreen darker alpha: 0.7);
			border: Color paleGreen darker darker;
			size: 200 @ 40;
			relocate: 0 @ 50;
			addEventHandler: BlPullHandler new beVertical disallowOutOfBounds.
			
	childB := BlElement new
			background: (Color paleGreen alpha: 0.7);
			border: Color paleGreen darker;
			size: 200 @ 400;
			constraintsDo: [ :c | c stepped relativeBounds: (0 @ 50 extent: 150 @ 50) ];
			addChild: sourceB.

	sourceA
		when: BlPullEvent
		do: [ :anEvent | 
			childB
				constraintsDo: [ :c | 
					c stepped
						relativeBounds: (anEvent newPosition extent: anEvent currentTarget extent) ] ].

	childC := BlElement new
			background: (Color paleYellow alpha: 0.7);
			border: Color paleYellow darker;
			size: 100 @ 200;
			constraintsDo: [ :c | c stepped relativeBounds: (0 @ 50 extent: 200 @ 50) ].
			
	sourceB
		when: BlPullEvent
		do: [ :anEvent | 
			childC
				constraintsDo: [ :c | 
					c stepped
						relativeBounds: (anEvent newPosition extent: anEvent currentTarget extent) ] ].

	popup
		addChildren: {handle.
				childA.
				childB.
				childC}.

	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: popup;
		addChild: (BlElement new
				size: 25 @ 25;
				geometry: BlCircleGeometry new;
				background: (Color red alpha: 0.5);
				addEventHandler: BlPullHandler new disallowOutOfBounds;
				when: BlElementPositionChangedEvent
					do: [ :anEvent | 
						popup
							layoutDo: [ :l | l anchorBounds: anEvent currentTarget bounds inParent asRectangle ] ];
				when: BlElementExtentChangedEvent
					do: [ :anEvent | 
						popup
							layoutDo: [ :l | l anchorBounds: anEvent currentTarget bounds inParent asRectangle ] ])
]

{ #category : #'examples - showroom' }
BlSteppedLayoutExamples >> elementWithTwoRelativeChildren [
	<gtExample>
	| popup childA sourceA childB sourceB childC |
	popup := BlElement new
			layout: BlSteppedLayout new;
			background: (Color veryVeryLightGray alpha: 0.2);
			border: Color veryVeryLightGray;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].

	sourceA := BlElement new
			background: (Color paleBlue darker alpha: 0.7);
			border: Color paleBlue darker darker;
			size: 150 @ 40;
			relocate: 0 @ 50;
			addEventHandler: BlPullHandler new beVertical disallowOutOfBounds.

	childA := BlElement new
			background: (Color paleBlue alpha: 0.7);
			border: Color paleBlue darker;
			size: 150 @ 300;
			addChild: sourceA.

	sourceB := BlElement new
			background: (Color paleGreen darker alpha: 0.7);
			border: Color paleGreen darker darker;
			size: 200 @ 40;
			relocate: 0 @ 50;
			addEventHandler: BlPullHandler new beVertical disallowOutOfBounds.
			
	childB := BlElement new
			background: (Color paleGreen alpha: 0.7);
			border: Color paleGreen darker;
			size: 200 @ 400;
			constraintsDo: [ :c | c stepped relativeBounds: (0 @ 50 extent: 150 @ 50) ];
			addChild: sourceB.

	sourceA
		when: BlPullEvent
		do: [ :anEvent | 
			childB
				constraintsDo: [ :c | 
					c stepped
						relativeBounds: (anEvent newPosition extent: anEvent currentTarget extent) ] ].

	childC := BlElement new
			background: (Color paleYellow alpha: 0.7);
			border: Color paleYellow darker;
			size: 100 @ 200;
			constraintsDo: [ :c | c stepped relativeBounds: (0 @ 50 extent: 200 @ 50) ].
			
	sourceB
		when: BlPullEvent
		do: [ :anEvent | 
			childC
				constraintsDo: [ :c | 
					c stepped
						relativeBounds: (anEvent newPosition extent: anEvent currentTarget extent) ] ].

	popup
		addChildren: {childA.
				childB.
				childC}.

	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: popup;
		addChild: (BlElement new
				size: 25 @ 25;
				geometry: BlCircleGeometry new;
				background: (Color red alpha: 0.5);
				addEventHandler: BlPullHandler new disallowOutOfBounds;
				when: BlElementPositionChangedEvent
					do: [ :anEvent | 
						popup
							layoutDo: [ :l | l anchorBounds: anEvent currentTarget bounds inParent asRectangle ] ];
				when: BlElementExtentChangedEvent
					do: [ :anEvent | 
						popup
							layoutDo: [ :l | l anchorBounds: anEvent currentTarget bounds inParent asRectangle ] ])
]

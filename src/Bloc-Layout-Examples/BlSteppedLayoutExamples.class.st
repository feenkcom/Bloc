Class {
	#name : #BlSteppedLayoutExamples,
	#superclass : #Object,
	#category : #'Bloc-Layout-Examples-Stepped'
}

{ #category : #'examples - nodes' }
BlSteppedLayoutExamples >> atMostNodeWithFirstHigherChild [
	<gtExample>

	| childOne childTwo childThree |
	childOne := BlElement new
		size: 200@800;
		relocate: 10@20.
	childTwo := BlElement new
		size: 200@300;
		relocate: (30@50).
	childThree := BlElement new
		size: 200@550;
		relocate: (-50@100).
	
	^ BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec atMost: 800@600);
		children: { 
			BlLayoutChildNode new
				constraints: childOne constraints;
				measurement: (BlLayoutNodeElementMeasurement new
					element: childOne);
				withElement: childOne.
			BlLayoutChildNode new
				constraints: childTwo constraints;
				measurement: (BlLayoutNodeElementMeasurement new
					element: childTwo);
				withElement: childTwo.
			BlLayoutChildNode new
				constraints: childThree constraints;
				measurement: (BlLayoutNodeElementMeasurement new
					element: childThree);
				withElement: childThree.
		}.
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstHigherChild_lessRight_layoutState [
	<gtExample>
	| aState |

	aState := BlSteppedLayout new
		anchorBounds: (500@100 extent: 50@50);
		createStateFor: self atMostNodeWithFirstHigherChild.

	self assert: aState containerWidth equals: 800.0.
	self assert: aState containerHeight equals: 600.0.

	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstHigherChild_lessRight_layoutState_measureFirstChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstHigherChild.
	aState := self atMostNodeWithFirstHigherChild_lessRight_layoutState.

	aChild := aParentNode children first.
	aState measureAndPlaceChild: aChild.
	
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark allToRight.
	self assert: aChild extent equals: 200@600.
	self assert: aChild position equals: 550 @ 0.
		
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstHigherChild_lessRight_layoutState_measureSecondChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstHigherChild.
	aState := self atMostNodeWithFirstHigherChild_lessRight_layoutState_measureFirstChild.

	aChild := aParentNode children second.
	aState measureAndPlaceChild: aChild.
	
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomLeft.
	self assert: aChild extent equals: 200@300.
	self assert: aChild position equals: 350 @ 0.
		
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstHigherChild_lessRight_layoutState_measureThirdChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstHigherChild.
	aState := self atMostNodeWithFirstHigherChild_lessRight_layoutState_measureSecondChild.

	aChild := aParentNode children third.
	aState measureAndPlaceChild: aChild.
	
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomLeft.
	self assert: aChild extent equals: 200@550.
	self assert: aChild position equals: 150 @ 0.
		
	^ aState
]

{ #category : #'examples - nodes' }
BlSteppedLayoutExamples >> atMostNodeWithFirstHigherChild_measure [
	<gtExample>
	| aParentNode aLayout |

	aParentNode := self atMostNodeWithFirstHigherChild.

	aLayout := BlSteppedLayout new.
	aLayout anchorBounds: (100@100 extent: 2@2).
	aLayout measure: aParentNode.

	^ aParentNode
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstHigherChild_moreRight_layoutState [
	<gtExample>
	| aState |

	aState := BlSteppedLayout new
		anchorBounds: (600@100 extent: 50@50);
		createStateFor: self atMostNodeWithFirstHigherChild.

	self assert: aState containerWidth equals: 800.0.
	self assert: aState containerHeight equals: 600.0.

	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstHigherChild_moreRight_layoutState_measureFirstChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstHigherChild.

	aState := self atMostNodeWithFirstHigherChild_moreRight_layoutState.

	aChild := aParentNode children first.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark allToLeft.
	self assert: aChild position equals: 400@0.
	self assert: aChild extent equals: 200@600.
		
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstHigherChild_moreRight_layoutState_measureSecondChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstHigherChild.

	aState := self atMostNodeWithFirstHigherChild_moreRight_layoutState_measureFirstChild.

	aChild := aParentNode children second.
	aState measureAndPlaceChild: aChild.
	
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomRight.
	self assert: aChild position equals: 600@0.
	self assert: aChild extent equals: 200@300.
		
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstHigherChild_moreRight_layoutState_measureThirdChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstHigherChild.

	aState := self atMostNodeWithFirstHigherChild_moreRight_layoutState_measureSecondChild.

	aChild := aParentNode children third.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomLeft.
	self assert: aChild position equals: 400@0.
	self assert: aChild extent equals: 200@550.
	
	^ aState
]

{ #category : #'examples - nodes' }
BlSteppedLayoutExamples >> atMostNodeWithFirstLargerChild [
	<gtExample>
	
	| childOne childTwo childThree |
	childOne := BlElement new
		size: 900@800;
		relocate: 10@20.
	childTwo := BlElement new
		size: 200@300;
		relocate: 30@50.
	childThree := BlElement new
		size: 200@550;
		relocate: (-50@100).

	^ BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec atMost: 800@600);
		children: { 
			BlLayoutChildNode new
				constraints: childOne constraints;
				measurement: (BlLayoutNodeElementMeasurement new
					element: childOne);
				withElement: childOne.
			BlLayoutChildNode new
				constraints: childTwo constraints;
				measurement: (BlLayoutNodeElementMeasurement new
					element: childTwo);
				withElement: childTwo.
			BlLayoutChildNode new
				constraints: childThree constraints;
				measurement: (BlLayoutNodeElementMeasurement new
					element: childThree);
				withElement: childThree.
		}.
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstLargerChild_layoutState [
	<gtExample>
	| aState |

	aState := BlSteppedLayout new
		anchorBounds: (600@100 extent: 50@50);
		createStateFor: self atMostNodeWithFirstLargerChild.

	self assert: aState containerWidth equals: 800.0.
	self assert: aState containerHeight equals: 600.0.

	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstLargerChild_layoutState_measureFirstChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstLargerChild.

	aState := self atMostNodeWithFirstLargerChild_layoutState.

	aChild := aParentNode children first.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark allToLeft.
	self assert: aChild extent equals: 600@600.
	self assert: aChild position equals: 0@0.
	
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstLargerChild_layoutState_measureSecondChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstLargerChild.

	aState := self atMostNodeWithFirstLargerChild_layoutState_measureFirstChild.

	aChild := aParentNode children second.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomRight.
	self assert: aChild extent equals: 200@300.
	self assert: aChild position equals: 600@0.
	
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstLargerChild_layoutState_measureThirdChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstLargerChild.

	aState := self atMostNodeWithFirstLargerChild_layoutState_measureSecondChild.

	aChild := aParentNode children third.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomLeft.
	self assert: aChild extent equals: 200@550.
	self assert: aChild position equals: 400@0.
	
	^ aState
]

{ #category : #'examples - nodes' }
BlSteppedLayoutExamples >> atMostNodeWithFirstLargerChild_measure [
	<gtExample>
	| aParentNode aLayout |

	aParentNode := self atMostNodeWithFirstLargerChild.

	aLayout := BlSteppedLayout new.
	aLayout anchorBounds: (100@100 extent: 2@2).
	aLayout measure: aParentNode.

	^ aParentNode
]

{ #category : #'examples - nodes' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWideChild [
	<gtExample>

	| childOne childTwo childThree |
	childOne := BlElement new
		size: 750@600;
		relocate: 10@20.
	childTwo := BlElement new
		size: 200@300;
		relocate: 30@50.
	childThree := BlElement new
		size: 600@550;
		relocate: (-50@100).
		
	^ BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec atMost: 800@600);
		children: { 
			BlLayoutChildNode new
				constraints: childOne constraints;
				measurement: (BlLayoutNodeElementMeasurement new
					element: childOne);
				withElement: childOne.
			BlLayoutChildNode new
				constraints: childTwo constraints;
				measurement: (BlLayoutNodeElementMeasurement new
					element: childTwo);
				withElement: childTwo.
			BlLayoutChildNode new
				constraints: childThree constraints;
				measurement: (BlLayoutNodeElementMeasurement new
					element: childThree);
				withElement: childThree.
		}.
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWideChild_lessRight_layoutState [
	<gtExample>
	| aState |

	aState := BlSteppedLayout new
		anchorBounds: (600@100 extent: 50@50);
		createStateFor: self atMostNodeWithFirstWideChild.

	self assert: aState containerWidth equals: 800.0.
	self assert: aState containerHeight equals: 600.0.

	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWideChild_lessRight_layoutState_measureFirstChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstWideChild.
	aState := self atMostNodeWithFirstWideChild_lessRight_layoutState.

	aChild := aParentNode children first.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark allToBottom.
	self assert: aChild extent equals: 750@450.
	self assert: aChild position equals: 0@150.
		
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWideChild_lessRight_layoutState_measureSecondChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstWideChild.
	aState := self atMostNodeWithFirstWideChild_lessRight_layoutState_measureFirstChild.

	aChild := aParentNode children second.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomLeft.
	self assert: aChild extent equals: 200@300.
	self assert: aChild position equals: 550@150.
		
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWideChild_lessRight_layoutState_measureThirdChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstWideChild.
	aState := self atMostNodeWithFirstWideChild_lessRight_layoutState_measureSecondChild.

	aChild := aParentNode children third.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark allToLeft.
	self assert: aChild extent equals: 550@550.
	self assert: aChild position equals: 0@50.
		
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWideChild_moreRight_layoutState [
	<gtExample>
	| aState |

	aState := BlSteppedLayout new
		anchorBounds: (750@100 extent: 50@50);
		createStateFor: self atMostNodeWithFirstWideChild.

	self assert: aState containerWidth equals: 800.0.
	self assert: aState containerHeight equals: 600.0.

	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWideChild_moreRight_layoutState_measureFirstChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstWideChild.
	aState := self atMostNodeWithFirstWideChild_moreRight_layoutState.

	aChild := aParentNode children first.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark allToLeft.
	self assert: aChild extent equals: 750@600.
	self assert: aChild position equals: 0@0.
	
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWideChild_moreRight_layoutState_measureSecondChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstWideChild.
	aState := self atMostNodeWithFirstWideChild_moreRight_layoutState_measureFirstChild.

	aChild := aParentNode children second.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomLeft.
	self assert: aChild extent equals: 200@300.
	self assert: aChild position equals: 550@0.
	
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWideChild_moreRight_layoutState_measureThirdChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstWideChild.
	aState := self atMostNodeWithFirstWideChild_moreRight_layoutState_measureSecondChild.

	aChild := aParentNode children third.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomLeft.
	self assert: aChild extent equals: 550@550.
	self assert: aChild position equals: 0@0.
	
	^ aState
]

{ #category : #'examples - nodes' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWiderChild [
	<gtExample>

	| childOne childTwo childThree |
	childOne := BlElement new
		size: 900@400;
		relocate: 10@20.
	childTwo := BlElement new
		size: 200@300;
		relocate: 30@50.
	childThree := BlElement new
		size: 200@550;
		relocate: (-50@100).
		
	^ BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec atMost: 800@600);
		children: { 
			BlLayoutChildNode new
				constraints: childOne constraints;
				measurement: (BlLayoutNodeElementMeasurement new
					element: childOne);
				withElement: childOne.
			BlLayoutChildNode new
				constraints: childTwo constraints;
				measurement: (BlLayoutNodeElementMeasurement new
					element: childTwo);
				withElement: childTwo.
			BlLayoutChildNode new
				constraints: childThree constraints;
				measurement: (BlLayoutNodeElementMeasurement new
					element: childThree);
				withElement: childThree.
		}.
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWiderChild_layoutState [
	<gtExample>
	| aState |

	aState := BlSteppedLayout new
		anchorBounds: (600@100 extent: 50@50);
		createStateFor: self atMostNodeWithFirstWiderChild.

	self assert: aState containerWidth equals: 800.0.
	self assert: aState containerHeight equals: 600.0.

	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWiderChild_layoutState_measureFirstChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstWiderChild.
	aState := self atMostNodeWithFirstWiderChild_layoutState.

	aChild := aParentNode children first.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark allToBottom.
	self assert: aChild extent equals: 800@400.
	self assert: aChild position equals: 0@150.
		
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWiderChild_layoutState_measureSecondChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstWiderChild.
	aState := self atMostNodeWithFirstWiderChild_layoutState_measureFirstChild.

	aChild := aParentNode children second.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomLeft.
	self assert: aChild extent equals: 200@300.
	self assert: aChild position equals: 600@150.
		
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWiderChild_layoutState_measureThirdChild [
	<gtExample>
	| aState aParentNode aChild |
	
	aParentNode := self atMostNodeWithFirstWiderChild.
	aState := self atMostNodeWithFirstWiderChild_layoutState_measureSecondChild.

	aChild := aParentNode children third.
	aState measureAndPlaceChild: aChild.
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark allToLeft.
	self assert: aChild extent equals: 200@550.
	self assert: aChild position equals: 400@50.
		
	^ aState
]

{ #category : #'examples - nodes' }
BlSteppedLayoutExamples >> atMostNodeWithFirstWiderChild_measure [
	<gtExample>
	| aParentNode aLayout |

	aParentNode := self atMostNodeWithFirstWiderChild.

	aLayout := BlSteppedLayout new.
	aLayout anchorBounds: (100@100 extent: 2@2).
	aLayout measure: aParentNode.

	^ aParentNode
]

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
	self assert: aChild extent equals: 200@400.
	self assert: aChild position equals: 550 @ 150.
		
	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithThreeExactChildren_layoutState_measureSecondChild [
	<gtExample>
	| aState aParentNode aChild |
	aParentNode := self atMostNodeWithThreeExactChildren.

	aState := self atMostNodeWithThreeExactChildren_layoutState_measureFirstChild.

	aChild := aParentNode children second.
	aState measureAndPlaceChild: aChild.
	
	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark bottomLeft.
	self assert: aChild extent equals: 200@300.
	self assert: aChild position equals: 350 @ 150.

	^ aState
]

{ #category : #'examples - layout state' }
BlSteppedLayoutExamples >> atMostNodeWithThreeExactChildren_layoutState_measureThirdChild [
	<gtExample>
	| aState aParentNode aChild |
	aParentNode := self atMostNodeWithThreeExactChildren.

	aState := self atMostNodeWithThreeExactChildren_layoutState_measureSecondChild.

	aChild := aParentNode children third.
	aState measureAndPlaceChild: aChild.

	self
		assert: aChild constraints stepped mark
		equals: BlSteppedLayoutMark allToLeft.
	self assert: aChild extent equals: 200@550.
	self assert: aChild position equals: 150@50.
	
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
BlSteppedLayoutExamples >> elementWithFirstHighChildAndTwoRelativeChildren [
	<gtExample>
	| popup childA sourceA childB sourceB childC |
	popup := BlElement new
			layout: BlSteppedLayout new;
			clipChildren: false;
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
			size: 150 @ 1200;
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

{ #category : #'examples - showroom' }
BlSteppedLayoutExamples >> elementWithFirstWideChildAndTwoRelativeChildren [
	<gtExample>
	| popup childA sourceA childB sourceB childC |
	popup := BlElement new
			layout: BlSteppedLayout new;
			clipChildren: false;
			background: (Color veryVeryLightGray alpha: 0.2);
			border: Color veryVeryLightGray;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].

	sourceA := BlElement new
			background: (Color paleBlue darker alpha: 0.7);
			border: Color paleBlue darker darker;
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical exact: 40 ];
			relocate: 0 @ 50;
			addEventHandler: BlPullHandler new beVertical disallowOutOfBounds.

	childA := BlElement new
			background: (Color paleBlue alpha: 0.7);
			border: Color paleBlue darker;
			size: 800 @ 300;
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

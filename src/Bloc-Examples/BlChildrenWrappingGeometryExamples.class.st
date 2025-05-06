Class {
	#name : #BlChildrenWrappingGeometryExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Bloc-Examples-Geometries'
}

{ #category : #asserting }
BlChildrenWrappingGeometryExamples >> assertScripter: aScripter elementGeometryGroupsCount: aGroupsCount freeRectanglesCount: aFreeRectanglesCount [
	<gtExample>
	| aGeometry someGroups someFreeRectangles |
	aGeometry := aScripter element geometry.
	someGroups := aGeometry groupsFromIntersectingPairs.
	someFreeRectangles := (aGeometry freeRectanglesExclucingGroups: someGroups) asOrderedCollection.

	self assert: someGroups size equals: aGroupsCount.
	self assert: someFreeRectangles size equals: aFreeRectanglesCount.
]

{ #category : #asserting }
BlChildrenWrappingGeometryExamples >> assertScripter: aScripter elementGeometryIntersectingPairsCount: anInteger [
	<gtExample>
	| aGeometry |
	aGeometry := aScripter element geometry.

	self assert: aGeometry intersectingPairs size equals: anInteger
]

{ #category : #'examples - basic' }
BlChildrenWrappingGeometryExamples >> basicChild [
	<gtExample>
	<return: #BrFrame>
	^ BrFrame new
		exact: 200 @ 200;
		addEventHandler: BlPullHandler new
]

{ #category : #'examples - basic' }
BlChildrenWrappingGeometryExamples >> blueChild [
	<gtExample>
	<return: #BrFrame>
	^ self basicChild background: (Color blue alpha: 0.3)
]

{ #category : #'examples - element' }
BlChildrenWrappingGeometryExamples >> containerWithAdjacentChildren [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		geometry: (BlChildrenWrappingGeometry cornerRadius: 10);
		background: Color white;
		border: (BlBorder paint: Color gray width: 2);
		addChild: (self blueChild relocate: 50 @ 50);
		addChild: (self redChild relocate: 251 @ 50);
		addChild: (self greenChild relocate: 50 @ 251);
		addChild: (self yellowChild relocate: 251 @ 251)
]

{ #category : #'examples - element' }
BlChildrenWrappingGeometryExamples >> containerWithAdjacentChildren_enlargedByOne [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		geometry: (BlChildrenWrappingGeometry cornerRadius: 10 enlargedBy: 1);
		background: Color white;
		border: (BlBorder paint: Color gray width: 2);
		addChild: (self blueChild relocate: 50 @ 50);
		addChild: (self redChild relocate: 251 @ 50);
		addChild: (self greenChild relocate: 50 @ 251);
		addChild: (self yellowChild relocate: 251 @ 251)
]

{ #category : #'examples - element' }
BlChildrenWrappingGeometryExamples >> containerWithIntersectedChildren [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		geometry: (BlChildrenWrappingGeometry cornerRadius: 10);
		background: Color white;
		border: (BlBorder paint: Color gray width: 2);
		addChild: (self blueChild relocate: 50 @ 50);
		addChild: (self redChild relocate: 250 @ 75);
		addChild: (self greenChild relocate: 130 @ 230);
		addChild: (self yellowChild relocate: 300 @ 330)
]

{ #category : #'examples - element' }
BlChildrenWrappingGeometryExamples >> containerWithPressedChildren [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		geometry: (BlChildrenWrappingGeometry cornerRadius: 10);
		background: Color white;
		border: (BlBorder paint: Color gray width: 2);
		addChild: (self blueChild relocate: 50 @ 50);
		addChild: (self redChild relocate: 249 @ 50);
		addChild: (self greenChild relocate: 50 @ 249);
		addChild: (self yellowChild relocate: 249 @ 249)
]

{ #category : #'examples - element' }
BlChildrenWrappingGeometryExamples >> containerWithTouchingChildren [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		geometry: (BlChildrenWrappingGeometry cornerRadius: 10);
		background: Color white;
		border: (BlBorder paint: Color gray width: 2);
		addChild: (self blueChild relocate: 50 @ 50);
		addChild: (self redChild relocate: 250 @ 50);
		addChild: (self greenChild relocate: 50 @ 250);
		addChild: (self yellowChild relocate: 250 @ 250)
]

{ #category : #'examples - element' }
BlChildrenWrappingGeometryExamples >> containerWithTouchingChildren_enlargedByOne [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		geometry: (BlChildrenWrappingGeometry cornerRadius: 10 enlargedBy: 1);
		background: Color white;
		border: (BlBorder paint: Color gray width: 2);
		addChild: (self blueChild relocate: 50 @ 50);
		addChild: (self redChild relocate: 250 @ 50);
		addChild: (self greenChild relocate: 50 @ 250);
		addChild: (self yellowChild relocate: 250 @ 250)
]

{ #category : #'examples - element' }
BlChildrenWrappingGeometryExamples >> containerWithTwoGroups [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		geometry: (BlChildrenWrappingGeometry cornerRadius: 10);
		background: Color white;
		border: (BlBorder paint: Color gray width: 2);
		addChild: (self blueChild relocate: 50 @ 50);
		addChild: (self redChild relocate: 240 @ 75);
		addChild: (self greenChild relocate: 80 @ 275);
		addChild: (self yellowChild relocate: 250 @ 330)
]

{ #category : #'examples - element' }
BlChildrenWrappingGeometryExamples >> containerWithTwoGroups_enlargedByOne [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		geometry: (BlChildrenWrappingGeometry cornerRadius: 10 enlargedBy: 1);
		background: Color white;
		border: (BlBorder paint: Color gray width: 2);
		addChild: (self blueChild relocate: 50 @ 50);
		addChild: (self redChild relocate: 240 @ 75);
		addChild: (self greenChild relocate: 80 @ 275);
		addChild: (self yellowChild relocate: 250 @ 330)
]

{ #category : #'examples - basic' }
BlChildrenWrappingGeometryExamples >> greenChild [
	<gtExample>
	<return: #BrFrame>
	^ self basicChild background: (Color green alpha: 0.3)
]

{ #category : #'examples - basic' }
BlChildrenWrappingGeometryExamples >> redChild [
	<gtExample>
	<return: #BrFrame>
	^ self basicChild background: (Color red alpha: 0.3)
]

{ #category : #'examples - scripter' }
BlChildrenWrappingGeometryExamples >> scripter [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := BlScripter new.

	self assert: aScripter events isEmpty.

	^ aScripter
]

{ #category : #'examples - geometry' }
BlChildrenWrappingGeometryExamples >> scripterWithAdjacentChildren [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterWithElement: [ self containerWithAdjacentChildren ].

	self assertScripter: aScripter elementGeometryIntersectingPairsCount: 0.
	self
		assertScripter: aScripter
		elementGeometryGroupsCount: 0
		freeRectanglesCount: 4.

	^ aScripter
]

{ #category : #'examples - geometry' }
BlChildrenWrappingGeometryExamples >> scripterWithAdjacentChildren_enlargedByOne [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithElement: [ self containerWithAdjacentChildren_enlargedByOne ].

	self assertScripter: aScripter elementGeometryIntersectingPairsCount: 6.
	self
		assertScripter: aScripter
		elementGeometryGroupsCount: 1
		freeRectanglesCount: 0.

	^ aScripter
]

{ #category : #'examples - geometry' }
BlChildrenWrappingGeometryExamples >> scripterWithIntersectedChildren [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithElement: [ self containerWithIntersectedChildren ].

	self assertScripter: aScripter elementGeometryIntersectingPairsCount: 3.
	self
		assertScripter: aScripter
		elementGeometryGroupsCount: 1
		freeRectanglesCount: 0.

	^ aScripter
]

{ #category : #'examples - geometry' }
BlChildrenWrappingGeometryExamples >> scripterWithPressedChildren [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterWithElement: [ self containerWithPressedChildren ].

	self assertScripter: aScripter elementGeometryIntersectingPairsCount: 6.
	self
		assertScripter: aScripter
		elementGeometryGroupsCount: 1
		freeRectanglesCount: 0.

	^ aScripter
]

{ #category : #'examples - geometry' }
BlChildrenWrappingGeometryExamples >> scripterWithTouchingChildren [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterWithElement: [ self containerWithTouchingChildren ].

	self assertScripter: aScripter elementGeometryIntersectingPairsCount: 0.
	self
		assertScripter: aScripter
		elementGeometryGroupsCount: 0
		freeRectanglesCount: 4.

	^ aScripter
]

{ #category : #'examples - geometry' }
BlChildrenWrappingGeometryExamples >> scripterWithTouchingChildren_enlargedByOne [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithElement: [ self containerWithTouchingChildren_enlargedByOne ].

	self assertScripter: aScripter elementGeometryIntersectingPairsCount: 6.
	self
		assertScripter: aScripter
		elementGeometryGroupsCount: 1
		freeRectanglesCount: 0.

	^ aScripter
]

{ #category : #'examples - geometry' }
BlChildrenWrappingGeometryExamples >> scripterWithTwoGroups [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterWithElement: [ self containerWithTwoGroups ].

	self assertScripter: aScripter elementGeometryIntersectingPairsCount: 2.
	self
		assertScripter: aScripter
		elementGeometryGroupsCount: 2
		freeRectanglesCount: 0.

	^ aScripter
]

{ #category : #'examples - geometry' }
BlChildrenWrappingGeometryExamples >> scripterWithTwoGroups_enlargedByOne [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithElement: [ self containerWithTwoGroups_enlargedByOne ].

	self assertScripter: aScripter elementGeometryIntersectingPairsCount: 3.
	self
		assertScripter: aScripter
		elementGeometryGroupsCount: 1
		freeRectanglesCount: 0.

	^ aScripter
]

{ #category : #'examples - basic' }
BlChildrenWrappingGeometryExamples >> yellowChild [
	<gtExample>
	<return: #BrFrame>
	^ self basicChild background: (Color yellow alpha: 0.3)
]

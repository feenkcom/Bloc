Class {
	#name : #BlElementLayoutBoundaryExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #examples }
BlElementLayoutBoundaryExamples >> exactLayoutBoundary_01_pulse [
	<gtExample>
	| aSpace |
	
	aSpace := self spaceWithExactLayoutBoundary.
	
	self assert: aSpace isLayoutRequested.
	self assert: aSpace elementsNeedingLayout isEmpty.
	
	aSpace pulse.
	
	self assert: aSpace root extent equals: 500@400.
	self assert: (aSpace root childNamed: #container) extent equals: 400@300.
	self assert: (aSpace root childNamed: #boundary) extent equals: 300@200.
	self assert: (aSpace root childNamed: #child) extent equals: 300@200.
	
	self assert: aSpace isLayoutRequested not.
	self assert: aSpace elementsNeedingLayout isEmpty.
	
	^ aSpace
]

{ #category : #examples }
BlElementLayoutBoundaryExamples >> exactLayoutBoundary_02_requestLayoutChild [
	<gtExample>
	| aSpace |
	
	aSpace := self exactLayoutBoundary_01_pulse.
	
	(aSpace root childNamed: #child) requestLayout.
	
	self assert: aSpace isLayoutRequested.
	self assert: aSpace elementsNeedingLayout equals: { aSpace root childNamed: #boundary } asSet.
	
	aSpace pulse.
	
	self assert: aSpace root extent equals: 500@400.
	self assert: (aSpace root childNamed: #container) extent equals: 400@300.
	self assert: (aSpace root childNamed: #boundary) extent equals: 300@200.
	self assert: (aSpace root childNamed: #child) extent equals: 300@200.
	
	self assert: aSpace isLayoutRequested not.
	self assert: aSpace elementsNeedingLayout isEmpty.
	
	^ aSpace
]

{ #category : #examples }
BlElementLayoutBoundaryExamples >> ignoreLayoutBoundary_01_pulse [
	<gtExample>
	| aSpace |
	
	aSpace := self spaceWithIgnoreLayoutBoundary.
	
	self assert: aSpace isLayoutRequested.
	self assert: aSpace elementsNeedingLayout isEmpty.
	
	aSpace pulse.
	
	self assert: aSpace root extent equals: 500@400.
	self assert: (aSpace root childNamed: #container) extent equals: 400@300.
	self assert: (aSpace root childNamed: #boundary) extent equals: 300@200.
	self assert: (aSpace root childNamed: #childA) extent equals: 300@200.
	self assert: (aSpace root childNamed: #childB) extent equals: 200@100.
	
	self assert: aSpace isLayoutRequested not.
	self assert: aSpace elementsNeedingLayout isEmpty.
	
	^ aSpace
]

{ #category : #examples }
BlElementLayoutBoundaryExamples >> ignoreLayoutBoundary_02_requestLayoutChildA [
	<gtExample>
	| aSpace |
	
	aSpace := self ignoreLayoutBoundary_01_pulse.
	
	(aSpace root childNamed: #childA) requestLayout.
	
	self assert: aSpace isLayoutRequested.
	self assert: aSpace elementsNeedingLayout equals: { aSpace root childNamed: #container } asSet.
	
	aSpace pulse.
	
	self assert: aSpace root extent equals: 500@400.
	self assert: (aSpace root childNamed: #container) extent equals: 400@300.
	self assert: (aSpace root childNamed: #boundary) extent equals: 300@200.
	self assert: (aSpace root childNamed: #childA) extent equals: 300@200.
	self assert: (aSpace root childNamed: #childB) extent equals: 200@100.
	
	self assert: aSpace isLayoutRequested not.
	self assert: aSpace elementsNeedingLayout isEmpty.
	
	^ aSpace
]

{ #category : #examples }
BlElementLayoutBoundaryExamples >> ignoreLayoutBoundary_02_requestLayoutIgnoredChild [
	<gtExample>
	| aSpace |
	
	aSpace := self ignoreLayoutBoundary_01_pulse.
	
	(aSpace root childNamed: #childB) requestLayout.
	
	self assert: aSpace isLayoutRequested.
	self assert: aSpace elementsNeedingLayout equals: { aSpace root childNamed: #boundary } asSet.
	
	aSpace pulse.
	
	self assert: aSpace root extent equals: 500@400.
	self assert: (aSpace root childNamed: #container) extent equals: 400@300.
	self assert: (aSpace root childNamed: #boundary) extent equals: 300@200.
	self assert: (aSpace root childNamed: #childA) extent equals: 300@200.
	self assert: (aSpace root childNamed: #childB) extent equals: 200@100.
	
	self assert: aSpace isLayoutRequested not.
	self assert: aSpace elementsNeedingLayout isEmpty.
	
	^ aSpace
]

{ #category : #'instance creation' }
BlElementLayoutBoundaryExamples >> spaceWithExactLayoutBoundary [
	<gtExample>
	| aSpace aContainer aLayoutBoundary aChild |
	
	aSpace := BlSpace new.
	aSpace extent: 500@400.
	
	aContainer := BlElement new
		size: 400@300.

	aLayoutBoundary := BlElement new
		size: 300@200.

	aChild := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	self assert: aLayoutBoundary isLayoutBoundary.
	self assert: aChild isLayoutBoundary.

	aLayoutBoundary addChild: aChild as: #child.
	aContainer addChild: aLayoutBoundary as: #boundary.
	aSpace root addChild: aContainer as: #container.
		
	^ aSpace
]

{ #category : #'instance creation' }
BlElementLayoutBoundaryExamples >> spaceWithIgnoreLayoutBoundary [
	<gtExample>
	| aSpace aContainer aLayoutBoundary aChildA aChildB |
	
	aSpace := BlSpace new.
	aSpace extent: 500@400.
	
	aContainer := BlElement new
		size: 400@300.
		
	aLayoutBoundary := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].

	aChildA := BlElement new
		size: 300@200.

	aChildB := BlElement new
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 200@100.

	self assert: aLayoutBoundary isLayoutBoundary not.
	"child A is a boundary because it has a fixed size"
	self assert: aChildA isLayoutBoundary.
	self assert: aChildB isLayoutBoundary.

	aLayoutBoundary addChild: aChildA as: #childA.
	aLayoutBoundary addChild: aChildB as: #childB.
	aContainer addChild: aLayoutBoundary as: #boundary.
	aSpace root addChild: aContainer as: #container.
		
	^ aSpace
]

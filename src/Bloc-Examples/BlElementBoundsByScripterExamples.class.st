Class {
	#name : #BlElementBoundsByScripterExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_0 [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripter.
	aScripter
		element: self bounds_in_space_element_container;
		play.

	^ aScripter
]

{ #category : #'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_1 [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self bounds_in_space_0.
	aScripter
		checkStep: [ :s | 
			s
				id: #parent_1;
				value: [ :anElement | anElement extent ]
					equals: [ self bounds_in_space_element_extent ];
				value: [ :anElement | anElement boundsInSpace ]
					equals: [ self bounds_in_space_element_bounds ] ].

	aScripter
		checkStep: [ :s | 
			s
				id: #parent_2;
				value: [ :anElement | anElement extent ]
					equals: [ self bounds_in_space_element_extent ];
				value: [ :anElement | anElement boundsInSpace ]
					equals: [ self bounds_in_space_element_bounds translateBy: 50 @ 50 ] ].

	aScripter
		checkStep: [ :s | 
			s
				id: #child;
				value: [ :anElement | anElement extent ]
					equals: [ self bounds_in_space_element_extent ];
				value: [ :anElement | anElement boundsInSpace ]
					equals: [ self bounds_in_space_element_bounds ];
				value: [ :anElement | anElement positionInSpaceChangedCount ] equals: [ 0 ] ].

	^ aScripter
]

{ #category : #'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_2 [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self bounds_in_space_1.

	aScripter
		doStep: [ :s | 
			s
				action: [ :anElement | 
					| aChild |
					aChild := anElement childWithId: #child.
					aChild removeFromParent.
					(anElement childWithId: #parent_2) addChild: aChild ] ].

	^ aScripter
]

{ #category : #'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_3 [
	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self bounds_in_space_2.

	aScripter
		checkStep: [ :s | 
			s
				id: #parent_1;
				value: [ :anElement | anElement extent ]
					equals: [ self bounds_in_space_element_extent ];
				value: [ :anElement | anElement boundsInSpace ]
					equals: [ self bounds_in_space_element_bounds ] ].

	aScripter
		checkStep: [ :s | 
			s
				id: #parent_2;
				value: [ :anElement | anElement extent ]
					equals: [ self bounds_in_space_element_extent ];
				value: [ :anElement | anElement boundsInSpace ]
					equals: [ self bounds_in_space_element_bounds translateBy: 50 @ 50 ] ].

	aScripter
		checkStep: [ :s | 
			s
				id: #child;
				value: [ :anElement | anElement extent ]
					equals: [ self bounds_in_space_element_extent ];
				value: [ :anElement | anElement boundsInSpace ]
					equals: [ self bounds_in_space_element_bounds translateBy: 50 @ 50 ];
				value: [ :anElement | anElement positionInSpaceChangedCount ] equals: [ 1 ] ].

	^ aScripter
]

{ #category : #'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_element_1 [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		id: #parent_1;
		size: self bounds_in_space_element_extent;
		border: (BlBorder paint: (Color blue alpha: 0.2) width: 2)
]

{ #category : #'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_element_2 [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		id: #parent_2;
		size: self bounds_in_space_element_extent;
		relocate: 50 @ 50;
		border: (BlBorder paint: (Color red alpha: 0.2) width: 2)
]

{ #category : #'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_element_bounds [
	<gtExample>
	<return: #Rectangle>
	^ 0 @ 0 extent: 500 @ 400
]

{ #category : #'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_element_child [
	<gtExample>
	<return: #BlExampleEventsCountingElement>
	^ BlExampleEventsCountingElement new
		id: #child;
		background: (Color veryVeryLightGray alpha: 0.4);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_element_container [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		id: #container;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		addChildren: {self bounds_in_space_element_1 addChild: self bounds_in_space_element_child.
				self bounds_in_space_element_2}
]

{ #category : #'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_element_extent [
	<gtExample>
	<return: #Point>
	^ 500 @ 400
]

{ #category : #'examples - scripter' }
BlElementBoundsByScripterExamples >> scripter [
	<gtExample>
	<return: #BlScripter>
	^ BlScripter new
]

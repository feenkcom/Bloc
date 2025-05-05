Class {
	#name : #BlClickEventExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Bloc-Examples-Event'
}

{ #category : #'examples - events' }
BlClickEventExamples >> clickInHiddenChild [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self twoElementsInScripter.

	aScripter
		substeps: 'Click in hidden child'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Set child with hidden visibility';
						block: [ :aChild | aChild visibility: BlVisibility hidden ];
						onChildAt: 1 ].

			aStep clickStep: [ :s | s onChildAt: 1 ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the click was consumed by parent';
						do: [ | aClickCollection |
							aClickCollection := aScripter userData at: #clicks.
							self assert: aClickCollection size equals: 1.
							self assert: aClickCollection first equals: #parent ] ] ].

	^ aScripter
]

{ #category : #'examples - events' }
BlClickEventExamples >> clickInHiddenChildAndVisibleClippedGrandchild [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self threeElementsWithTrueChildClippingInScripter.

	aScripter
		substeps: 'Click in hidden grandchild'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Set child with hidden visibility';
						block: [ :aChild | aChild visibility: BlVisibility hidden ];
						onChildAt: 1 ].

			aStep
				clickStep: [ :s | 
					s
						onChildAt: 1;
						onChildAt: 1 ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the click was consumed by parent';
						do: [ | aClickCollection |
							aClickCollection := aScripter userData at: #clicks.
							self assert: aClickCollection size equals: 1.
							self assert: aClickCollection first equals: #parent ] ] ].

	^ aScripter
]

{ #category : #'examples - events' }
BlClickEventExamples >> clickInHiddenChildAndVisibleGrandchild [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self threeElementsInScripter.

	aScripter
		substeps: 'Click in hidden grandchild'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Set child with hidden visibility';
						block: [ :aChild | aChild visibility: BlVisibility hidden ];
						onChildAt: 1 ].

			aStep
				clickStep: [ :s | 
					s
						onChildAt: 1;
						onChildAt: 1 ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the click was consumed by parent';
						do: [ | aClickCollection |
							aClickCollection := aScripter userData at: #clicks.
							self assert: aClickCollection size equals: 1.
							self assert: aClickCollection first equals: #parent ] ] ].

	^ aScripter
]

{ #category : #'examples - events' }
BlClickEventExamples >> clickInHiddenChildAndVisibleUnclippedGrandchild [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self threeElementsWithFalseChildClippingInScripter.

	aScripter
		substeps: 'Click in hidden grandchild'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Set child with hidden visibility';
						block: [ :aChild | aChild visibility: BlVisibility hidden ];
						onChildAt: 1 ].

			aStep
				clickStep: [ :s | 
					s
						onChildAt: 1;
						onChildAt: 1 ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the click was consumed by parent';
						do: [ | aClickCollection |
							aClickCollection := aScripter userData at: #clicks.
							self assert: aClickCollection size equals: 1.
							self assert: aClickCollection first equals: #parent ] ] ].

	^ aScripter
]

{ #category : #'examples - events' }
BlClickEventExamples >> clickInParentWithGoneChild [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self twoElementsInScripter.

	aScripter
		substeps: 'Click in gone child'
		do: [ :aStep | 
			aStep do
				label: 'Set child with gone visibility';
				block: [ :aChild | aChild visibility: BlVisibility gone ];
				onChildAt: 1.

			aStep
				click;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the click was consumed by parent';
						do: [ | aClickCollection |
							aClickCollection := aScripter userData at: #clicks.
							self assert: aClickCollection size equals: 1.
							self assert: aClickCollection first equals: #parent ] ] ].

	^ aScripter
]

{ #category : #'examples - events' }
BlClickEventExamples >> clickInVisibleChild [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self twoElementsInScripter.

	aScripter
		substeps: 'Click in visible child'
		do: [ :aStep | 
			aStep clickStep: [ :s | s onChildAt: 1 ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the click was consumed by child';
						do: [ | aClickCollection |
							aClickCollection := aScripter userData at: #clicks.
							self assert: aClickCollection size equals: 1.
							self assert: aClickCollection first equals: #child ] ] ].

	^ aScripter
]

{ #category : #'examples - elements' }
BlClickEventExamples >> element [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		layout: BlLinearLayout vertical;
		border: (BlBorder paint: Color gray width: 1);
		background: Color purple muchLighter;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #'examples - elements' }
BlClickEventExamples >> threeElements [
	<gtExample>
	<return: #BlElement>
	^ self element
		addChild: (self element
					addChild: self element as: #grandchild;
					background: Color red muchLighter)
			as: #child;
		background: Color green muchLighter;
		id: #parent
]

{ #category : #'examples - elements in scripter' }
BlClickEventExamples >> threeElementsInScripter [
	<gtExample>
	<return: #BlScripter>
	^ self
		scripterWithElement: [ :aTarget :aScripter | 
			| anElement aChild anEventCollection |
			anElement := self threeElements.
			anEventCollection := aScripter userData
					at: #clicks
					ifAbsentPut: [ OrderedCollection new ].
			anElement
				when: BlClickEvent
				do: [ :anEvent | 
					anEventCollection add: #parent.
					anEvent consumed: true ].
			aChild := anElement childAt: 1.
			aChild
				when: BlClickEvent
				do: [ :anEvent | 
					anEventCollection add: #child.
					anEvent consumed: true ].
			(aChild childAt: 1)
				when: BlClickEvent
				do: [ :anEvent | 
					anEventCollection add: #grandchild.
					anEvent consumed: true ].
			anElement ]
]

{ #category : #'examples - elements' }
BlClickEventExamples >> threeElementsWithFalseChildClipping [
	<gtExample>
	<return: #BlElement>
	| aParent aChild aGrandchild |
	aParent := self element
			background: Color green muchLighter;
			id: #parent;
			layout: BlFrameLayout new;
			size: 100 @ 100.

	aChild := self element
			size: 30 @ 30;
			id: #child;
			clipChildren: false;
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ].

	aGrandchild := self element
			size: 20 @ 20;
			background: Color red muchLighter;
			id: #grandchild;
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored horizontal alignRightAt: 1.1.
				c ignored vertical alignTopAt: 1.1 ].

	aParent addChild: aChild.
	aChild addChild: aGrandchild.

	^ aParent
]

{ #category : #'examples - elements in scripter' }
BlClickEventExamples >> threeElementsWithFalseChildClippingInScripter [
	<gtExample>
	<return: #BlScripter>
	^ self
		scripterWithElement: [ :aTarget :aScripter | 
			| anElement aChild anEventCollection |
			anElement := self threeElementsWithFalseChildClipping.
			anEventCollection := aScripter userData
					at: #clicks
					ifAbsentPut: [ OrderedCollection new ].
			anElement
				when: BlClickEvent
				do: [ :anEvent | 
					anEventCollection add: #parent.
					anEvent consumed: true ].
			aChild := anElement childAt: 1.
			aChild
				when: BlClickEvent
				do: [ :anEvent | 
					anEventCollection add: #child.
					anEvent consumed: true ].
			(aChild childAt: 1)
				when: BlClickEvent
				do: [ :anEvent | 
					anEventCollection add: #grandchild.
					anEvent consumed: true ].
			anElement ]
]

{ #category : #'examples - elements' }
BlClickEventExamples >> threeElementsWithTrueChildClipping [
	<gtExample>
	<return: #BlElement>
	| aParent aChild |
	aParent := self threeElementsWithFalseChildClipping.

	aChild := aParent childAt: 1.
	aChild clipChildren: true.

	^ aParent
]

{ #category : #'examples - elements in scripter' }
BlClickEventExamples >> threeElementsWithTrueChildClippingInScripter [
	<gtExample>
	<return: #BlScripter>
	^ self
		scripterWithElement: [ :aTarget :aScripter | 
			| anElement aChild anEventCollection |
			anElement := self threeElementsWithTrueChildClipping.
			anEventCollection := aScripter userData
					at: #clicks
					ifAbsentPut: [ OrderedCollection new ].
			anElement
				when: BlClickEvent
				do: [ :anEvent | 
					anEventCollection add: #parent.
					anEvent consumed: true ].
			aChild := anElement childAt: 1.
			aChild
				when: BlClickEvent
				do: [ :anEvent | 
					anEventCollection add: #child.
					anEvent consumed: true ].
			(aChild childAt: 1)
				when: BlClickEvent
				do: [ :anEvent | 
					anEventCollection add: #grandchild.
					anEvent consumed: true ].
			anElement ]
]

{ #category : #'examples - elements' }
BlClickEventExamples >> twoElements [
	<gtExample>
	<return: #BlElement>
	^ self element
		addChild: self element as: #child;
		background: Color green muchLighter;
		id: #parent
]

{ #category : #'examples - elements in scripter' }
BlClickEventExamples >> twoElementsInScripter [
	<gtExample>
	<return: #BlScripter>
	^ self
		scripterWithElement: [ :aTarget :aScripter | 
			| anElement anEventCollection |
			anElement := self twoElements.
			anEventCollection := aScripter userData
					at: #clicks
					ifAbsentPut: [ OrderedCollection new ].
			anElement
				when: BlClickEvent
				do: [ :anEvent | 
					anEventCollection add: #parent.
					anEvent consumed: true ].
			(anElement childAt: 1)
				when: BlClickEvent
				do: [ :anEvent | 
					anEventCollection add: #child.
					anEvent consumed: true ].
			anElement ]
]

Extension { #name : #BlHorizontalTreeFlowLayoutState }

{ #category : #'*Bloc-Extensions' }
BlHorizontalTreeFlowLayoutState >> gtChildrenNodesFor: aView [
	<gtView>
	grid ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Children nodes';
		object: [ grid ];
		view: #gtChildrenNodesFor:
]

{ #category : #'*Bloc-Extensions' }
BlHorizontalTreeFlowLayoutState >> gtComputedNodesPreview [
	| minTopLeft maxBottomRight occupiedExtent displayedExtent aContainer |
	aContainer := BlElement new.

	minTopLeft := 0 @ 0.
	maxBottomRight := 0 @ 0.
	grid
		allChildrenNodesDo: [ :eachNode | 
			minTopLeft := minTopLeft min: eachNode bounds topLeft.
			maxBottomRight := maxBottomRight max: eachNode bounds bottomRight.
			aContainer
				addChild: (BrFrame new
						size: eachNode extent;
						relocate: eachNode position;
						background: aContainer theme button disabledBorderColor;
						when: BlClickEvent
							do: [ :anEvent | anEvent currentTarget phlow spawnObject: eachNode ];
						addChild: (BrLabel new
								aptitude: (BrGlamorousLabelAptitude new
										foreground: aContainer theme button disabledBackgroundColor);
								text: ('{1}' format: {eachNode position});
								constraintsDo: [ :c | 
									c frame horizontal alignLeft.
									c frame vertical alignTop ]);
						addChild: (BrLabel new
								aptitude: (BrGlamorousLabelAptitude new
										foreground: aContainer theme button disabledBackgroundColor);
								text: ('{1}' format: {eachNode bounds bottomRight});
								constraintsDo: [ :c | 
									c frame horizontal alignRight.
									c frame vertical alignBottom ]);
						addChild: (BrVerticalPane new
								fitContent;
								alignCenter;
								constraintsDo: [ :c | 
									c frame horizontal alignCenter.
									c frame vertical alignCenter ];
								addChild: (BrLabel new
										aptitude: BrGlamorousLabelAptitude;
										text: ('row: {1} depth: {2}'
												format: {eachNode constraints horizontalTreeFlow row.
														eachNode constraints horizontalTreeFlow depth}));
								addChild: (BrLabel new
										aptitude: (BrGlamorousLabelAptitude new
												foreground: aContainer theme button disabledBackgroundColor);
										text: ('{1}' format: {eachNode extent})))) ].
	minTopLeft isZero
		ifFalse: [ aContainer
				childrenDo: [ :aChild | aChild relocate: aChild position + minTopLeft negated ] ].
	occupiedExtent := maxBottomRight + minTopLeft negated.
	displayedExtent := containerWidth @ containerHeight.
	aContainer size: (occupiedExtent max: displayedExtent).
	(occupiedExtent x > containerWidth or: [ occupiedExtent y > containerHeight ])
		ifTrue: [ aContainer
				addChild: (BlElement new
						id: #'preview--displayed-area';
						preventMouseEvents;
						size: displayedExtent;
						relocate: (minTopLeft isZero ifTrue: [ 0 @ 0 ] ifFalse: [ minTopLeft negated ]);
						border: aContainer theme default primaryBorderColor;
						outskirts: BlOutskirts outside) ].

	aContainer border: aContainer theme default darkBorderColor.
	aContainer outskirts: BlOutskirts outside.
	aContainer clipChildren: false.

	^ BrFrame new
		matchParent;
		padding: (BlInsets all: 10);
		addChild: (aContainer asScalableElement clipChildren: false)
]

{ #category : #'*Bloc-Extensions' }
BlHorizontalTreeFlowLayoutState >> gtComputedNodesPreviewFor: aView [
	<gtView>
	grid ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Computed preview';
		priority: 5;
		stencil: [ self gtComputedNodesPreview ]
]

{ #category : #'*Bloc-Extensions' }
BlHorizontalTreeFlowLayoutState >> gtGridFor: aView [
	<gtView>
	grid ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Grid';
		priority: 10;
		object: [ grid ];
		view: #gtPreviewFor:
]

{ #category : #'*Bloc-Extensions' }
BlHorizontalTreeFlowLayoutState >> gtGridOverviewFor: aView [
	<gtView>
	^ aView forward
		title: 'Grid overview';
		priority: 15;
		object: [ grid ];
		view: #gtOverviewFor:
]

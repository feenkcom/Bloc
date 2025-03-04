Class {
	#name : #BlSteppedLayoutStatePreviewElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'layoutState',
		'phlowContext',
		'selectedArea',
		'childNode',
		'availableAreas',
		'expectedChildBounds',
		'wantsToPrintExpectedChildBounds',
		'displayedAreas',
		'previewContainer',
		'infoContainer',
		'selectedAreaOrigin',
		'availableAreasOrigin',
		'upToOccupiedArea'
	],
	#category : #'Bloc-Extensions-Stepped'
}

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> childNodeExtent [
	<return: #Point or: nil>
	selectedAreaOrigin = #lastOccupiedArea
		ifTrue: [ ^ selectedArea requestedExtent 
			ifNil: [ selectedArea bounds extent ] ].
			
	selectedAreaOrigin = #upToOccupiedArea
		ifTrue: [ ^ selectedArea requestedExtent 
			ifNil: [ selectedArea bounds extent ] ].

	^ childNode ifNotNil: #extent
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> computeContextInformation [
	phlowContext ifNil: [ ^ self ].
	phlowContext navigation
		previousProcessContextSuchThat: [ :aProcessContext | true ] 
		do: [ :aProcessContext | 
			| aMethodContext |
			aMethodContext := aProcessContext findMethodContextSuchThat: [ :eachContext | 
				eachContext method = (BlSteppedLayoutState >> #placeMeasuredChild:) ].
			aMethodContext ifNotNil: [ 
				selectedArea := aMethodContext tempNamed: #selectedArea.
				selectedAreaOrigin := #tempVariable.
				childNode := aMethodContext tempNamed: #aLayoutChildNode.
				availableAreas := aMethodContext tempNamed: #availableAreas.
				availableAreasOrigin := #tempVariable. ].
			(self expectedChildBoundsFromProcessContext: aProcessContext) ifNotNil: [ :anAssoc | 
				expectedChildBounds := anAssoc value.
				childNode ifNil: [ 
					childNode := anAssoc key ] ] ] 
		ifAbsent: [ 
				selectedArea := nil.
				childNode := nil ]
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> computeDisplayedAreas [
	availableAreas ifNil: [
		layoutState occupiedAreas 
			ifEmpty: [
				availableAreasOrigin := #initialAvailableAreas.
				availableAreas := layoutState initialAvailableAreas ]
			ifNotEmpty: [ :aCollection |
				upToOccupiedArea 
					ifNil: [ 
						availableAreasOrigin := #lastOccupiedArea.
						availableAreas := aCollection last availableAreas ]
					ifNotNil: [
						availableAreasOrigin := #upToOccupiedArea.
						availableAreas := upToOccupiedArea availableAreas ] ] ].
			
	displayedAreas := selectedArea
		ifNil: [ 
			upToOccupiedArea 
				ifNil: [ layoutState occupiedAreas ]
				ifNotNil: [ layoutState occupiedAreas 
					copyFrom: 1 
					to: (layoutState occupiedAreas identityIndexOf: upToOccupiedArea) ] ]
		ifNotNil: [ (layoutState occupiedAreas identityIncludes: selectedArea)
				ifTrue: [ layoutState occupiedAreas ]
				ifFalse: [ layoutState occupiedAreas copyWith: selectedArea ] ].
				
	selectedArea ifNil: [ 
		availableAreasOrigin = #lastOccupiedArea ifTrue: [ 
			selectedArea := layoutState occupiedAreas last.
			selectedAreaOrigin := #lastOccupiedArea ].
		availableAreasOrigin = #upToOccupiedArea ifTrue: [
			selectedArea := upToOccupiedArea.
			selectedAreaOrigin := #upToOccupiedArea ] ]
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> computeWantsToPrintExpectedChildBounds [
	wantsToPrintExpectedChildBounds := false.
	(childNode isNotNil and: [ expectedChildBounds isNotNil ]) ifTrue: [ 
		wantsToPrintExpectedChildBounds := childNode position ~= expectedChildBounds origin 
			or: [ childNode extent ~= expectedChildBounds extent ] ].
]

{ #category : #initialization }
BlSteppedLayoutStatePreviewElement >> defaultPreviewContainerBorder [
	^ BlBorder paint: Color lightGray width: 2
]

{ #category : #initialization }
BlSteppedLayoutStatePreviewElement >> descriptionText [
	| aText |
	aText := 'Stepped layout preview. ' asRopedText bold.

	aText
		append: 'This visualization explains stepped layout algorithm. It displays ' asRopedText.
	aText append: 'container extent' asRopedText bold.
	aText append: ', which is typically of a window size. If the container has defined padding, it is also displayed. The ' asRopedText.
	aText append: 'red rectangle' asRopedText bold.
	aText append: ' denotes anchor bounds, which is typically bounds of an element (anchor) on which a mouse click happened. ' asRopedText.
	aText append: 'Yellow rectangles' asRopedText bold.
	aText append: ' denote already occupied areas. Those areas are occupied by menu elements, e.g., context menu, dropdown, tooltip). ' asRopedText.
	aText append: 'Blue rectangle' asRopedText bold.
	aText append: ' denotes the last (or currently computed) occupied area. Those yellow and blue rectangles indicate their alignment and placement mark. Users can ' asRopedText.
	aText append: 'hover occupied area buttons' asRopedText bold.
	aText append: ' (the small yellow and blue elements with numbers) to analyze layout computation for the specific menu elements. Users can also '
				asRopedText.
	aText append: 'hover available area buttons' asRopedText bold.
	aText append: ' (the small gray elements with numbers) to preview the considered placement areas for the last computed occupied area in blue. Those considered placement areas also includes possible menu element positions with the element requested size which may be larger if the element is shrinked.'
				asRopedText.

	^ aText
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> expectedChildBoundsFromProcessContext: aProcessContext [
	"I iterate example methods, looking for code like:
	- self assert: aChild extent equals: 200 @ 550.
	- self assert: aChild position equals: 200 @ (0+3).
	I extract expected child node position and extent.
	I return child node instances -> (expectedPosition @ expectedExtent).
	I return nil if I do not find anything."

	| aPosition anExtent aChildNode |
	aPosition := anExtent := aChildNode := nil.
	aProcessContext
		findMethodContextSuchThat: [ :eachContext | 
			eachContext method isGTExampleMethod
				and: [ eachContext tempNames
						do: [ :eachTempName | 
							| aValue |
							aValue := eachContext tempNamed: eachTempName.
							(aValue isKindOf: BlLayoutNode)
								and: [ eachContext method ast
										nodesDo: [ :eachNode | 
											(eachNode isMessage
												and: [ eachNode isSelfSend
														and: [ eachNode selector = #assert:equals:
																and: [ eachNode arguments first isMessage
																		and: [ eachNode arguments first receiver isLocalVariable
																				and: [ eachNode arguments first receiver name = eachTempName
																						and: [ eachNode arguments second isMessage
																								and: [ eachNode arguments second selector = #@ ] ] ] ] ] ] ])
												ifTrue: [ | anXValue anYValue |
													anXValue := eachNode class compiler evaluate: eachNode arguments second receiver sourceCode.
													anYValue := eachNode class compiler evaluate: eachNode arguments second arguments first sourceCode.
													aChildNode := aValue.
													eachNode arguments first selector = #position
														ifTrue: [ aPosition := anXValue @ anYValue ].
													eachNode arguments first selector = #extent
														ifTrue: [ anExtent := anXValue @ anYValue ] ] ] ] ].
					aPosition isNotNil and: [ anExtent isNotNil ] ] ].

	^ (aPosition isNotNil and: [ anExtent isNotNil ])
		ifTrue: [ aChildNode -> (aPosition extent: anExtent) ]
		ifFalse: [ nil ]
]

{ #category : #initialization }
BlSteppedLayoutStatePreviewElement >> initialize [
	super initialize.
	wantsToPrintExpectedChildBounds := false.
	
	self matchParent.
	self padding: (BlInsets all: 6).
	self clipChildren: false.
	
	self addChild: self newEditorWithDescription.
	self initializeInfoContainer.
	self initializePreviewContainer.
	
	self addChild: infoContainer.
	self addChild: previewContainer
]

{ #category : #initialization }
BlSteppedLayoutStatePreviewElement >> initializeInfoContainer [
	infoContainer := BrVerticalPane new
			alignCenterLeft;
			zIndex: 1;
			fitContent;
			margin: (BlInsets bottom: 10)
]

{ #category : #initialization }
BlSteppedLayoutStatePreviewElement >> initializePreviewContainer [
	previewContainer := BlElement new.
	previewContainer outskirts: BlOutskirts outside.
	previewContainer border: self defaultPreviewContainerBorder.
	previewContainer margin: (BlInsets all: 6).
	previewContainer clipChildren: false
]

{ #category : #accessing }
BlSteppedLayoutStatePreviewElement >> layoutState [
	^ layoutState
]

{ #category : #accessing }
BlSteppedLayoutStatePreviewElement >> layoutState: aLayoutState [
	layoutState := aLayoutState.
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> newAreaPreviewElementFor: anArea color: aColor label: aLabel childNodeExtent: aChildNodeExtent [
	| isSameCorner positionBlock |
	isSameCorner := false.
	positionBlock := [ :aPositionLabel :aNodeElement :anAreaElement |
		aPositionLabel text: ('position: {1}{2}' format: {
			(aNodeElement bounds inParent: anAreaElement parent) topLeft.
			isSameCorner ifTrue: [ ', alignment' ] ifFalse: [ '' ] }) ].
			
	^ BrFrame new
		id: ('area-', aLabel asString) asSymbol;
		relocate: anArea bounds origin;
		exact: anArea bounds extent;
		border: aColor;
		background: (aColor alpha: 0.4);
		in: [ :theFrame | 
			aChildNodeExtent ifNotNil: [ 
				| positionLabel |
				((anArea horizontalAlignment = BlElementAlignment horizontal start) 
					and: [ anArea verticalAlignment = BlElementAlignment vertical start ])
						ifTrue: [ isSameCorner := true ].
				theFrame clipChildren: false.
				theFrame addChild: (BrFrame new
					id: #childNode;
					background: (aColor muchLighter alpha: 0.4);
					border: (BlBorder builder 
						dashed; 
						paint: (aColor darker alpha: 0.4); 
						width: 2; 
						build);
					outskirts: (BlOutskirts inside);
					exact: aChildNodeExtent;
					constraintsDo: [ :c | 
						c frame horizontal alignment: anArea horizontalAlignment.
						c frame vertical alignment: anArea verticalAlignment ];
					addChild: (positionLabel := BrLabel new
						id: #position;
						aptitude: BrGlamorousLabelAptitude;
						background: (aColor darker alpha: 0.4);
						text: ('position: {1}{2}' format: {
							'x@y'.
							isSameCorner ifTrue: [ ', alignment' ] ifFalse: [ '' ] });
						constraintsDo: [ :c | 
							c padding: (BlInsets all: 3).
							c frame horizontal alignLeft.
							c frame vertical alignTop ]);
					when: BlElementPositionChangedEvent do: [ :anEvent |
						positionBlock value: positionLabel value: anEvent currentTarget value: theFrame ];
					enqueueTask: (BlTaskAction new action: [ 
						positionBlock value: positionLabel value: positionLabel parent value: theFrame ]);
					addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: ('child node');
						constraintsDo: [ :c | 
							c frame horizontal alignCenter.
							c frame vertical alignCenter ]))
			]
		];
		in: [ :theFrame |
			isSameCorner ifFalse: [ 
				theFrame 
					addChild: (BrFrame new
							id: #alignment;
							fitContent;
							background: (aColor darker alpha: 0.4);
							constraintsDo: [ :c | 
								c padding: (BlInsets all: 3).
								c frame horizontal alignment: anArea horizontalAlignment.
								c frame vertical alignment: anArea verticalAlignment ];
							addChild: (BrLabel new
									constraintsDo: [ :c | 
										c frame horizontal alignCenter.
										c frame vertical alignCenter ];
									aptitude: BrGlamorousLabelAptitude new;
									text: 'alignment')) ] ];
		addChild: (BrLabel new
				id: #description;
				aptitude: BrGlamorousLabelAptitude;
				text: ('{1} ({2})'
						format: {aLabel asRopedText.
								anArea mark gtDisplayString});
				constraintsDo: [ :c | 
					c frame horizontal alignCenter.
					c frame vertical alignCenter ]);
		yourself
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> newAvailableAreasText [
	availableAreasOrigin = #initialAvailableAreas
		ifTrue: [ ^ 'Initial available areas: ' ].

	availableAreasOrigin = #lastOccupiedArea
		ifTrue: [ ^ 'Last available areas: ' ].
		
	availableAreasOrigin = #upToOccupiedArea
		ifTrue: [ ^ 'Available areas: ' ].

	^ 'Available areas: '
]

{ #category : #initialization }
BlSteppedLayoutStatePreviewElement >> newEditorWithDescription [
	^ BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude;
		text: self descriptionText;
		beReadOnlyWithoutSelection;
		margin: (BlInsets top: 10 right: 0 bottom: 10 left: 0);
		hFitContentLimited;
		vFitContent.
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> newInfoButtonWithText: aText color: aColor [
	^ BrHorizontalPane new
		alignCenter;
		fitContent;
		margin: (BlInsets right: 5);
		padding: (BlInsets all: 2);
		border: aColor;
		background: (aColor alpha: 0.4);
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: aText asRopedText)
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> newInfoLineContainer [
	^ BrHorizontalPane new
		fitContent;
		alignCenterLeft;
		margin: (BlInsets bottom: 1)
]

{ #category : #'api - updating' }
BlSteppedLayoutStatePreviewElement >> newInformationRepresentationElement [
	^ BrFrame new
		exact: 80 @ 12
]

{ #category : #accessing }
BlSteppedLayoutStatePreviewElement >> phlowContext [
	^ phlowContext
]

{ #category : #accessing }
BlSteppedLayoutStatePreviewElement >> phlowContext: anObject [
	phlowContext := anObject
]

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutStatePreviewElement >> upToOccupiedArea: anOccupiedArea [ 
	upToOccupiedArea := anOccupiedArea
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> updateAvailableAreasInformationAndPreview [
	| lineContainer |
	availableAreas ifNil: [ ^ self ].
	lineContainer := self newInfoLineContainer.
	infoContainer addChild: lineContainer.
	lineContainer
		addChild: (BrLabel new
				alignCenter;
				aptitude: BrGlamorousLabelAptitude;
				text: self newAvailableAreasText;
				margin: (BlInsets left: 4 right: 5)).
	availableAreas
		withIndexDo: [ :eachArea :index | 
			| infoButton infoArea |
			infoButton := self
					newInfoButtonWithText: index
					color: BrGlamorousColors shadowColor.
			infoArea := self
					newAreaPreviewElementFor: eachArea
					color: BrGlamorousColors shadowColor
					label: index
					childNodeExtent: self childNodeExtent.
			infoArea visibility: BlVisibility hidden.
			infoArea zIndex: 1.
			infoButton
				when: BlMouseEnterEvent
					do: [ :anEvent | infoArea visibility: BlVisibility visible ];
				when: BlMouseLeaveEvent
					do: [ :anEvent | infoArea visibility: BlVisibility hidden ].
			lineContainer addChild: infoButton.
			previewContainer addChild: infoArea ]
]

{ #category : #'api - updating' }
BlSteppedLayoutStatePreviewElement >> updateChildListInformation [
	displayedAreas withIndexCollect: [ :eachArea :index |
		
	]
]

{ #category : #'api - updating' }
BlSteppedLayoutStatePreviewElement >> updateElement [
	infoContainer removeChildren.
	previewContainer removeChildren.

	self computeContextInformation.
	self computeWantsToPrintExpectedChildBounds.
	self computeDisplayedAreas.
	self updatePreviewContainerConstraints.
	
	self updateLayoutExtentInformation.
	self updateLayoutPaddingInformation.
	self updateExpectedChildBoundsInformation.
	self updateOccupiedAreasInformation.
	self updateAvailableAreasInformationAndPreview.
	self updateChildListInformation.
	
	self updatePreviewPadding.
	self updatePreviewContainerChildren.
	self updatePreviewAnchorBoundsElement
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> updateExpectedChildBoundsInformation [
	wantsToPrintExpectedChildBounds ifNil: [ ^ self ].
	wantsToPrintExpectedChildBounds ifFalse: [ ^ self ].
	infoContainer addChild: (self newInfoLineContainer
		addChild: (BrLabel new
			alignCenter;
			aptitude: BrGlamorousLabelAptitude;
			text: ('Expected child position: {1} and extent: {2} represented as' 
				format: { expectedChildBounds origin. expectedChildBounds extent });
			margin: (BlInsets left: 4 right: 5));
		addChild: (self newInformationRepresentationElement
			border: (BlBorder builder 
				dashed; 
				paint: (BrGlamorousColors errorBackgroundColor); 
				width: 2; 
				build))).
	infoContainer addChild: (self newInfoLineContainer
		addChild: (BrLabel new
			alignCenter;
			aptitude: BrGlamorousLabelAptitude;
			text: ('Current child position: {1} and extent: {2} represented as' 
				format: { childNode position. childNode extent });
			margin: (BlInsets left: 4 right: 5));
		addChild: (self newInformationRepresentationElement
			border: (BlBorder builder 
				dashed; 
				paint: (BrGlamorousColors selectedListItemColor); 
				width: 2; 
				build))).
]

{ #category : #'api - updating' }
BlSteppedLayoutStatePreviewElement >> updateLayoutExtentInformation [
	infoContainer
		addChild: (self newInfoLineContainer
				addChild: (BrLabel new
						alignCenter;
						aptitude: BrGlamorousLabelAptitude;
						text: ('Container extent: {1} represented as' format: {layoutState containerExtent});
						margin: (BlInsets left: 4 right: 5));
				addChild: (self newInformationRepresentationElement
						border: self defaultPreviewContainerBorder))
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> updateLayoutPaddingInformation [
	self padding isEmpty ifTrue: [ ^ self ].
	
	infoContainer addChild: (self newInfoLineContainer
		addChild: (BrLabel new
			alignCenter;
			aptitude: BrGlamorousLabelAptitude;
			text: ('Container padding: {1} represented as' 
				format: { layoutState padding });
			margin: (BlInsets left: 4 right: 5));
		addChild: (self newInformationRepresentationElement
			border: (BlBorder builder 
				dashed; 
				paint: (Color lightGray alpha: 0.4); 
				width: 2; 
				build))).
]

{ #category : #'api - updating' }
BlSteppedLayoutStatePreviewElement >> updateOccupiedAreasInformation [
	| lineContainer |
	lineContainer := self newInfoLineContainer.
	infoContainer addChild: lineContainer.
	lineContainer
		addChild: (BrLabel new
				alignCenter;
				aptitude: BrGlamorousLabelAptitude;
				text: 'Occupied areas';
				margin: (BlInsets left: 4 right: 5)).
	displayedAreas
		withIndexDo: [ :eachArea :index | 
			| infoColor infoButton |
			infoColor := eachArea == selectedArea
				ifFalse: [ BrGlamorousColors failureBackgroundColor ]
				ifTrue: [ BrGlamorousColors selectedListItemColor ].
			infoButton := self
					newInfoButtonWithText: index
					color: infoColor.
			infoButton
				when: BlClickEvent
					do: [ :anEvent | anEvent currentTarget phlow spawnObject: eachArea ];
				when: BlMouseEnterEvent
					do: [ :anEvent | anEvent currentTarget background: infoColor muchDarker ];
				when: BlMouseLeaveEvent
					do: [ :anEvent | anEvent currentTarget background: infoColor ].
			lineContainer addChild: infoButton ]
]

{ #category : #'api - updating' }
BlSteppedLayoutStatePreviewElement >> updatePreviewAnchorBoundsElement [
	previewContainer
		addChild: (BlElement new
				relocate: layoutState anchorBounds origin;
				size: layoutState anchorBounds extent;
				border: BrGlamorousColors errorBackgroundColor;
				background: (BrGlamorousColors errorBackgroundColor alpha: 0.4)).
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> updatePreviewContainerChildren [
	previewContainer
		addChildren: (displayedAreas
				withIndexCollect: [ :eachArea :index | 
					(eachArea == selectedArea)
							ifFalse: [ self
									newAreaPreviewElementFor: eachArea
									color: BrGlamorousColors failureBackgroundColor
									label: index
									childNodeExtent: nil ]
							ifTrue: [ self
									newAreaPreviewElementFor: eachArea
									color: BrGlamorousColors selectedListItemColor
									label: 'selected area'
									childNodeExtent: (childNode ifNotNil: #extent) ] ]).
									
	wantsToPrintExpectedChildBounds ifTrue: [ 
		previewContainer 
			addChild: (BrFrame new
				id: #'child-expected-bounds';
				relocate: expectedChildBounds origin;
				exact: expectedChildBounds extent;
				border: (BlBorder builder 
					dashed; 
					paint: (BrGlamorousColors errorBackgroundColor); 
					width: 2; 
					build));
			addChild: (BrFrame new
				id: #'child-current-bounds';
				relocate: childNode position;
				exact: childNode extent;
				border: (BlBorder builder 
					dashed; 
					paint: (BrGlamorousColors selectedListItemColor); 
					width: 2; 
					build)) ].
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> updatePreviewContainerConstraints [
	layoutState containerWidth isInfinite
		ifTrue: [ previewContainer constraintsDo: [ :c | c horizontal matchParent ] ]
		ifFalse: [ previewContainer width: layoutState containerWidth ].

	layoutState containerHeight isInfinite
		ifTrue: [ previewContainer constraintsDo: [ :c | c vertical matchParent ] ]
		ifFalse: [ previewContainer height: layoutState containerHeight ].
]

{ #category : #'private - updating' }
BlSteppedLayoutStatePreviewElement >> updatePreviewPadding [
	layoutState padding isEmpty ifTrue: [ ^ self ].
	(layoutState containerWidth isInfinite or: [ layoutState containerHeight isInfinite ]) ifTrue: [ ^ self ].
	
	previewContainer addChild: (BlElement new
		outskirts: BlOutskirts outside;
		border: (BlBorder builder 
			dashed; 
			paint: (Color lightGray alpha: 0.4); 
			width: 2; 
			build);
		relocate: layoutState containerPositionWithPadding;
		size: layoutState containerCornerWithPadding).
]

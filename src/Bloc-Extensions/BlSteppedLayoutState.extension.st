Extension { #name : #BlSteppedLayoutState }

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutState >> gtAreaPreviewElementFor: anArea color: aColor label: aLabel childNode: aChildNode [
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
			aChildNode ifNotNil: [ 
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
					exact: aChildNode extent;
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

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutState >> gtAreaPreviewExpectedChildBoundsFrom: aProcessContext [
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
													anXValue := eachNode arguments second receiver value.
													anYValue := eachNode arguments second arguments first value.
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

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutState >> gtAreasPreviewFor: aView context: aPhlowContext [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 4;
		stencil: [ | rootContainer infoContainer container availableAreas areInitialAvailableAreas selectedArea childNode displayedAreas expectedChildBounds wantsToPrintExpectedChildBounds |
			aPhlowContext navigation
				previousProcessContextSuchThat: [ :aProcessContext | true ] 
				do: [ :aProcessContext | 
					| aMethodContext |
					aMethodContext := aProcessContext findMethodContextSuchThat: [ :eachContext | 
						eachContext method = (BlSteppedLayoutState >> #placeMeasuredChild:) ].
					aMethodContext ifNotNil: [ 
						selectedArea := aMethodContext tempNamed: #selectedArea.
						childNode := aMethodContext tempNamed: #aLayoutChildNode.
						availableAreas := aMethodContext tempNamed: #availableAreas ].
					(self gtAreaPreviewExpectedChildBoundsFrom: aProcessContext) ifNotNil: [ :anAssoc | 
						expectedChildBounds := anAssoc value.
						childNode ifNil: [ childNode := anAssoc key ] ] ] 
				ifAbsent: [ 
					selectedArea := nil.
					childNode := nil ].
			
			wantsToPrintExpectedChildBounds := false.
			(childNode isNotNil and: [ expectedChildBounds isNotNil ]) ifTrue: [ 
				wantsToPrintExpectedChildBounds := childNode position ~= expectedChildBounds origin 
					or: [ childNode extent ~= expectedChildBounds extent ].
				wantsToPrintExpectedChildBounds := true ].
			
			areInitialAvailableAreas := false.
			availableAreas ifNil: [
				occupiedAreas ifEmpty: [ 
					areInitialAvailableAreas := true.
					availableAreas := self initialAvailableAreas ] ].

			rootContainer := BrVerticalPane new.
			rootContainer matchParent.
			rootContainer padding: (BlInsets all: 6).

			container := BlElement new.
			container outskirts: BlOutskirts outside.
			container border: (BlBorder paint: Color lightGray width: 2).
			container margin: (BlInsets all: 6).
			container clipChildren: false.

			self containerWidth isInfinite
				ifTrue: [ container constraintsDo: [ :c | c horizontal matchParent ] ]
				ifFalse: [ container width: self containerWidth ].

			self containerHeight isInfinite
				ifTrue: [ container constraintsDo: [ :c | c vertical matchParent ] ]
				ifFalse: [ container height: self containerHeight ].

			wantsToPrintExpectedChildBounds ifTrue: [ 
				container addChild: (BrFrame new
					id: #'child-expected-bounds';
					relocate: expectedChildBounds origin;
					exact: expectedChildBounds extent;
					border: (BlBorder builder 
						dashed; 
						paint: (BrGlamorousColors errorBackgroundColor); 
						width: 2; 
						build))
			].
			
			availableAreas
				ifNotNil: [ 
					infoContainer := BrHorizontalPane new.
					infoContainer zIndex: 1.
					infoContainer fitContent.
					rootContainer addChild: infoContainer.

					infoContainer
						addChild: (BrLabel new
								alignCenter;
								aptitude: BrGlamorousLabelAptitude;
								text: (areInitialAvailableAreas ifTrue: [ 'Initial available areas: ' ] ifFalse: [ 'Available areas: ' ]);
								margin: (BlInsets left: 4 right: 5)).
					availableAreas
						withIndexDo: [ :eachArea :index | 
							| infoButton infoArea |
							infoButton := BrHorizontalPane new
									alignCenter;
									fitContent;
									margin: (BlInsets right: 5);
									padding: (BlInsets all: 2);
									border: BrGlamorousColors shadowColor;
									background: (BrGlamorousColors shadowColor alpha: 0.4);
									addChild: (BrLabel new
											aptitude: BrGlamorousLabelAptitude;
											text: index asRopedText).

							infoArea := self
									gtAreaPreviewElementFor: eachArea
									color: BrGlamorousColors shadowColor
									label: index
									childNode: childNode.
							infoArea visibility: BlVisibility hidden.
							infoArea zIndex: 1.

							infoButton
								when: BlMouseEnterEvent
									do: [ :anEvent | infoArea visibility: BlVisibility visible ];
								when: BlMouseLeaveEvent
									do: [ :anEvent | infoArea visibility: BlVisibility hidden ].

							infoContainer addChild: infoButton.
							container addChild: infoArea ] ].

			wantsToPrintExpectedChildBounds ifTrue: [
				rootContainer addChild: (BrHorizontalPane new
					alignCenterLeft;
					zIndex: 1;
					fitContent;
					addChild: (BrLabel new
						alignCenter;
						aptitude: BrGlamorousLabelAptitude;
						text: ('Expected child position: {1} and extent: {2} represented as' 
							format: { expectedChildBounds origin. expectedChildBounds extent });
						margin: (BlInsets left: 4 right: 5);
					addChild: (BrFrame new 
						margin: (BlInsets left: 5);
						exact: 80@12;
						border: (BlBorder builder 
						dashed; 
						paint: (BrGlamorousColors errorBackgroundColor); 
						width: 2; 
						build)))).
				rootContainer addChild: (BrHorizontalPane new
					zIndex: 1;
					fitContent;
					addChild: (BrLabel new
						alignCenter;
						aptitude: BrGlamorousLabelAptitude;
						text: ('Current child position: {1} and extent: {2}' 
							format: { childNode position. childNode extent });
						margin: (BlInsets left: 4 right: 5))) ].
							
			rootContainer addChild: container.

			displayedAreas := selectedArea
					ifNil: [ occupiedAreas ]
					ifNotNil: [ (occupiedAreas identityIncludes: selectedArea)
							ifTrue: [ occupiedAreas ]
							ifFalse: [ occupiedAreas copyWith: selectedArea ] ].

			container
				addChildren: (displayedAreas
						withIndexCollect: [ :eachArea :index | 
							eachArea == selectedArea
								ifFalse: [ self
										gtAreaPreviewElementFor: eachArea
										color: BrGlamorousColors failureBackgroundColor
										label: index
										childNode: nil ]
								ifTrue: [ self
										gtAreaPreviewElementFor: eachArea
										color: BrGlamorousColors selectedListItemColor
										label: 'selected area'
										childNode: childNode ] ]).

			container
				addChild: (BlElement new
						relocate: anchorBounds origin;
						size: anchorBounds extent;
						border: BrGlamorousColors errorBackgroundColor;
						background: (BrGlamorousColors errorBackgroundColor alpha: 0.4)).

			rootContainer ];
		actionUpdateButton
]

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutState >> gtInfoFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Info';
		priority: 5;
		items: [ {
			'Container width' -> containerWidth.
			'Container height' -> containerHeight.
			'Anchor bounds' -> anchorBounds.
			'Occupied bounds' -> occupiedBounds.
			'Occupied areas' -> occupiedAreas.
			'Preferred child weight' -> preferredChildWeight.
			'Preferred direction' -> preferredDirection.
			'Initial available areas' -> self initialAvailableAreas.
		} ];
		column: 'Name' text: #key;
		column: 'Value' text: #value;
		send: #value
]

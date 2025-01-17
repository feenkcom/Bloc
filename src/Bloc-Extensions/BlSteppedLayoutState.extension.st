Extension { #name : #BlSteppedLayoutState }

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutState >> gtAreasPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 4;
		stencil: [ | rootContainer infoContainer container initialAreas |
			rootContainer := BrVerticalPane new.
			rootContainer matchParent.
			rootContainer padding: (BlInsets all: 6).
			
			container := BlElement new.
			container outskirts: BlOutskirts outside.
			container border: (BlBorder paint: Color lightGray width: 2).
			container margin: (BlInsets all: 6).
			
			self containerWidth isInfinite
				ifTrue: [ container constraintsDo: [ :c | c horizontal matchParent ] ]
				ifFalse: [ container width: self containerWidth ].

			self containerHeight isInfinite
				ifTrue: [ container constraintsDo: [ :c | c vertical matchParent ] ]
				ifFalse: [ container height: self containerHeight ].
			
			occupiedAreas ifEmpty: [
				initialAreas := self initialAvailableAreas.
				
				infoContainer := BrHorizontalPane new.
				infoContainer fitContent.
				
				rootContainer addChild: infoContainer.
			
				infoContainer
					addChild: (BrLabel new
						alignCenter;
						aptitude: BrGlamorousLabelAptitude;
						text: 'Initial available areas: ';
						margin: (BlInsets left: 4 right: 5)).
				initialAreas
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
									
							infoArea := BrFrame new
									visibility: BlVisibility hidden;
									relocate: eachArea bounds origin;
									exact: eachArea bounds extent;
									border: BrGlamorousColors shadowColor;
									background: (BrGlamorousColors shadowColor alpha: 0.4);
									addChild: (BrFrame new
										fitContent;
										background: (BrGlamorousColors shadowColor darker alpha: 0.4);
										constraintsDo: [ :c | 
											c padding: (BlInsets all: 3).
											c frame horizontal alignment: eachArea horizontalAlignment.
											c frame vertical alignment: eachArea verticalAlignment ];
										addChild: (BrLabel new
											constraintsDo: [ :c | 
												c frame horizontal alignCenter.
												c frame vertical alignCenter ];
											aptitude: (BrGlamorousLabelAptitude new foreground: Color white);
											text: 'alignment'));
									addChild: (BrLabel new
										constraintsDo: [ :c | 
											c frame horizontal alignCenter.
											c frame vertical alignCenter ];
										aptitude: BrGlamorousLabelAptitude;
										text: index asRopedText).
										
							infoButton
								when: BlMouseEnterEvent 
									do: [ :anEvent | infoArea visibility: BlVisibility visible ];
								when: BlMouseLeaveEvent 
									do: [ :anEvent | infoArea visibility: BlVisibility hidden ].
									
							infoContainer addChild: infoButton.
							container addChild: infoArea ] ].
			
			rootContainer addChild: container.
			
			container
				addChildren: (occupiedAreas
						withIndexCollect: [ :eachArea :index | 
							BrFrame new
								relocate: eachArea bounds origin;
								exact: eachArea bounds extent;
								border: BrGlamorousColors failureBackgroundColor;
								background: (BrGlamorousColors failureBackgroundColor alpha: 0.4);
								addChild: (BrFrame new
										fitContent;
										background: (BrGlamorousColors failureBackgroundColor darker alpha: 0.4);
										constraintsDo: [ :c | 
											c padding: (BlInsets all: 3).
											c frame horizontal alignment: eachArea horizontalAlignment.
											c frame vertical alignment: eachArea verticalAlignment ];
										addChild: (BrLabel new
											constraintsDo: [ :c | 
												c frame horizontal alignCenter.
												c frame vertical alignCenter ];
											aptitude: (BrGlamorousLabelAptitude new);
											text: 'alignment'));
								addChild: (BrLabel new
									aptitude: BrGlamorousLabelAptitude;
									text: index asRopedText;
									constraintsDo: [ :c | 
										c frame horizontal alignCenter.
										c frame vertical alignCenter ]) ]).

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

Extension { #name : #BlSteppedLayoutState }

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutState >> gtAreasPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 4;
		stencil: [ | container |
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

			container
				addChildren: (occupiedAreas
						withIndexCollect: [ :eachArea :index | 
							BrHorizontalPane new
								alignCenter;
								relocate: eachArea bounds origin;
								exact: eachArea bounds extent;
								border: BrGlamorousColors failureBackgroundColor;
								background: (BrGlamorousColors failureBackgroundColor alpha: 0.4);
								addChild: (BrLabel new
									aptitude: BrGlamorousLabelAptitude;
									text: index asRopedText) ]).

			container
				addChild: (BlElement new
						relocate: anchorBounds origin;
						size: anchorBounds extent;
						border: BrGlamorousColors errorBackgroundColor;
						background: (BrGlamorousColors errorBackgroundColor alpha: 0.4)).

			container ];
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
		} ];
		column: 'Name' text: #key;
		column: 'Value' text: #value;
		send: #value
]

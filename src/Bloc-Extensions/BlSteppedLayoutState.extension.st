Extension { #name : #BlSteppedLayoutState }

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutState >> gtAreasPreviewFor: aView context: aPhlowContext [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 4;
		stencil: [
			BlSteppedLayoutStatePreviewElement new
				layoutState: self;
				phlowContext: aPhlowContext ]
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

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutState >> gtOccupiedAreasFor: aView [
	<gtView>
	occupiedAreas ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Occupied Areas';
		items: [ occupiedAreas ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Occupied bounds' text: [ :each | each bounds rounded ];
		column: 'Available bounds' text: [ :each | each selectedArea bounds rounded ];
		column: 'Mark' text: [ :each | each mark ]
]

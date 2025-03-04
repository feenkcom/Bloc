Extension { #name : #BlSteppedLayoutOccupiedArea }

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutOccupiedArea >> gtAreasPreviewFor: aView context: aPhlowContext [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 4;
		stencil: [
			BlSteppedLayoutStatePreviewElement new
				layoutState: self layoutState;
				upToOccupiedArea: self;
				phlowContext: aPhlowContext;
				updateElement. ]
]

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutOccupiedArea >> gtOccupiedBoundsFor: aView [
	<gtView>
	^ aView forward
		title: 'Occupied bounds';
		object: [ self bounds ];
		view: #gtOverviewFor:
]

Extension { #name : #BlSteppedLayoutOccupiedArea }

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutOccupiedArea >> gtOccupiedBoundsFor: aView [
	<gtView>
	^ aView forward
		title: 'Occupied bounds';
		object: [ self bounds ];
		view: #gtOverviewFor:
]

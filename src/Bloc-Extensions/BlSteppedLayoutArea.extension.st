Extension { #name : #BlSteppedLayoutArea }

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutArea >> gtBoundsFor: aView [
	<gtView>
	^ aView forward
		title: 'Bounds';
		object: [ bounds ];
		view: #gtOverviewFor:
]

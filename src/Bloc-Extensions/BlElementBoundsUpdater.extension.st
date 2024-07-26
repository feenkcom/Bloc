Extension { #name : #BlElementBoundsUpdater }

{ #category : #'*Bloc-Extensions' }
BlElementBoundsUpdater >> gtChangesFor: aView [
	<gtView>
	changes ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Changes';
		object: [ changes ];
		view: #gtItemsFor:
]

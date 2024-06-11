Extension { #name : #BlLazyStyle }

{ #category : #'*Bloc-Extensions' }
BlLazyStyle >> gtStyleComputationFor: aView [
	<gtView>
	styleComputation ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Style computation';
		object: [ styleComputation ];
		view: #gtSourceCodeFor:
]

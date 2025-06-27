Extension { #name : #BlHorizontalTreeFlowLayoutState }

{ #category : #'*Bloc-Extensions' }
BlHorizontalTreeFlowLayoutState >> gtGridFor: aView [
	<gtView>
	grid ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Grid';
		object: [ grid ];
		view: #gtPreviewFor:
]

Extension { #name : #BlTextStylerRequestedSignal }

{ #category : #'*Bloc-Extensions' }
BlTextStylerRequestedSignal >> gtElementPreviewFor: aView [
	<gtView>
	^ aView forward
		title: 'Element';
		priority: 0;
		object: [ self element ];
		view: #gtLiveFor:
]

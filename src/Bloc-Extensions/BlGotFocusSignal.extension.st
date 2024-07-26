Extension { #name : #BlGotFocusSignal }

{ #category : #'*Bloc-Extensions' }
BlGotFocusSignal >> gtElementFor: aView [
	<gtView>
	element ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Element';
		priority: 20;
		object: [ element ];
		view: #gtLiveFor:
]

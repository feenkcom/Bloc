Extension { #name : #BlCompositionLeftoverStateLayer }

{ #category : #'*Bloc-Extensions' }
BlCompositionLeftoverStateLayer >> gtStateCommandsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'State commands';
		priority: 5;
		object: [ self state ];
		view: #gtCommandsFor:
]

{ #category : #'*Bloc-Extensions' }
BlCompositionLeftoverStateLayer >> gtStateCommandsOptimizedFor: aView [
	<gtView>
	
	^ aView forward
		title: 'State commands (Optimized)';
		priority: 5.5;
		object: [ self state optimizedCopy ];
		view: #gtCommandsFor:
]

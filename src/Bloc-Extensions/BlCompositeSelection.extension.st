Extension { #name : #BlCompositeSelection }

{ #category : #'*Bloc-Extensions' }
BlCompositeSelection >> gtTreeFor: aView [
	<gtView>		
	
	^ aView forward
		title: 'Tree';
		priority: 7;
		object: [ selections ];
		view: #gtTreeFor:
]

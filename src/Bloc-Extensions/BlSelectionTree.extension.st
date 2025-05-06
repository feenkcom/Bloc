Extension { #name : #BlSelectionTree }

{ #category : #'*Bloc-Extensions' }
BlSelectionTree >> gtTreeFor: aView [
	<gtView>
	
	self hasRoot
		ifFalse: [ ^ aView empty ].
		
	^ aView forward
		title: 'Tree';
		priority: 7;
		object: [ self root ];
		view: #gtTreeFor:
]

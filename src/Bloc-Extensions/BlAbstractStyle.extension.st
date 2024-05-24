Extension { #name : #BlAbstractStyle }

{ #category : #'*Bloc-Extensions' }
BlAbstractStyle >> gtPropertiesFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Properties';
		priority: 5;
		object: [ self properties ];
		view: #gtPropertiesFor:
]

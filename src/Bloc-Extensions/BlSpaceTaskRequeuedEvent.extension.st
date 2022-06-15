Extension { #name : #BlSpaceTaskRequeuedEvent }

{ #category : #'*Bloc-Extensions' }
BlSpaceTaskRequeuedEvent >> gtStackFor: aView [
	<gtView>
	
	stack ifNil: [ ^ aView empty ].
	
	^ aView list
		title: 'Stack';
		priority: 10;
		items: [ stack ]
]

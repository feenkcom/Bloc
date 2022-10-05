Extension { #name : #BlSpaceTaskEvent }

{ #category : #'*Bloc-Extensions' }
BlSpaceTaskEvent >> gtTasksFor: aView [
	<gtView>
	self tasks ifNil: [ ^ aView empty ].

	^ aView list
		title: 'Tasks';
		items: [ self tasks ]
]

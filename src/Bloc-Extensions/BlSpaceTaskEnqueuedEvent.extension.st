Extension { #name : #BlSpaceTaskEnqueuedEvent }

{ #category : #'*Bloc-Extensions' }
BlSpaceTaskEnqueuedEvent >> gtStackFor: aView [
	<gtView>
	
	stack ifNil: [ ^ aView empty ].
	self processId = task processId
		ifFalse: [ ^ aView empty ].
	
	^ aView list
		title: 'Stack';
		priority: 10;
		items: [ stack ]
]

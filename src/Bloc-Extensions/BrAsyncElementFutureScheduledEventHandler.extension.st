Extension { #name : #BrAsyncElementFutureScheduledEventHandler }

{ #category : #'*Bloc-Extensions' }
BrAsyncElementFutureScheduledEventHandler >> gtFuturePromisesFor: aView [
	<gtView>
	futurePromises ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Future promises';
		object: [ futurePromises ];
		view: #gtItemsFor:
]

Extension { #name : #BlCompositeErrorHandler }

{ #category : #'*Bloc-Extensions' }
BlCompositeErrorHandler >> gtErrorHandlersFor: aView [
	<gtView>
	errorHandlers ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Error handlers';
		items: [ errorHandlers asOrderedCollection ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

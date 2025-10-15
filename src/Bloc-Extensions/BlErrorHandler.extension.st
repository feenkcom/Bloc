Extension { #name : #BlErrorHandler }

{ #category : #'*Bloc-Extensions' }
BlErrorHandler >> gtErrorsFor: aView [
	<gtView>
	self hasError ifFalse: [ ^ aView empty ].
	^ aView columnedList
		title: 'Errors';
		items: [ self errors ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

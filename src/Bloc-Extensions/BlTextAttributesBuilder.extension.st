Extension { #name : #BlTextAttributesBuilder }

{ #category : #'*Bloc-Extensions' }
BlTextAttributesBuilder >> gtAttributesFor: aView [
	<gtView>
	attributes ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Attributes';
		items: [ attributes ];
		column: 'Name' text: [ :each | each gtDisplayString ]
]

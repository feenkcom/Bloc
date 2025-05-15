Extension { #name : #BlKeyboardBuffer }

{ #category : #'*Bloc-Extensions' }
BlKeyboardBuffer >> gtEventsFor: aView [
	<gtView>
	events ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Events';
		items: [ events associations ];
		column: 'Key' text: [ :each | each key gtDisplayString ];
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ];
		contextItemLabel: 'Inspect key'
			action: [ :element :each | element phlow spawnObject: each key ];
		contextItemLabel: 'Inspect event'
			action: [ :element :each | element phlow spawnObject: each value ]
]

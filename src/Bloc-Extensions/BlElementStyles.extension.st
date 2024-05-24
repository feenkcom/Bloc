Extension { #name : #BlElementStyles }

{ #category : #'*Bloc-Extensions' }
BlElementStyles >> gtStylesFor: aView [
	<gtView>
	
	^ aView tree
		title: 'Styles';
		priority: 5;
		items: [ styles ];
		children: [ :eachStyleOrProperty |
			(eachStyleOrProperty isKindOf: BlElementStyle)
				ifTrue: [ eachStyleOrProperty properties ]
				ifFalse: [ (eachStyleOrProperty isKindOf: Association)
					ifTrue: [ eachStyleOrProperty value ] 
					ifFalse: #() ] ];
		itemText: [ :eachStyleOrProperty |
			(eachStyleOrProperty isKindOf: BlElementStyle)
				ifTrue: [ eachStyleOrProperty state ]
				ifFalse: [ eachStyleOrProperty ] ];
		expandAll;
		send: [ :eachStyleOrProperty | 
			(eachStyleOrProperty isKindOf: Association)
				ifTrue: [ eachStyleOrProperty value ]
				ifFalse: [ eachStyleOrProperty ] ]
]

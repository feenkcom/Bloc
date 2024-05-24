Extension { #name : #BlEagerStyles }

{ #category : #'*Bloc-Extensions' }
BlEagerStyles >> gtStylesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Styles';
		items: [ self styles ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'State' text: [ :aStyle | aStyle state ] width: 80;
		column: 'Priority' text: [ :aStyle | aStyle priority ] width: 60;
		column: 'Properties' text: [ :aStyle | 
			| aCount |
			aCount := 0.
			aStyle properties do: [ :aProperty | aCount := aCount + 1 ].
			'{1} {2}' format: { aCount. 'item' asPluralBasedOn: aCount } ] width: 100;
		column: 'Description' text: #yourself
]

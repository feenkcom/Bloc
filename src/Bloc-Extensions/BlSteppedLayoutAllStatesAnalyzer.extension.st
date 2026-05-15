Extension { #name : #BlSteppedLayoutAllStatesAnalyzer }

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutAllStatesAnalyzer >> gtAreasPreviewFor: aView context: aPhlowContext [
	^ self gtStatesFor: aView context: aPhlowContext
]

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutAllStatesAnalyzer >> gtStatesFor: aView context: aPhlowContext [
	<gtView>
	^ aView columnedList
		title: 'States';
		priority: 1;
		items: [ self layoutStates ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 80;
		column: 'Name' text: [ :anItem | anItem gtDisplayText ];
		send: [ :anItem | anItem ]
]

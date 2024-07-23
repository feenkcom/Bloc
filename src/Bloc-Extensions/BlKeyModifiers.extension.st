Extension { #name : #BlKeyModifiers }

{ #category : #'*Bloc-Extensions' }
BlKeyModifiers >> gtOverview [
	^ {
		GtPhlowOverviewItem new name: 'Is empty'; boolean: self isEmpty.
		GtPhlowOverviewItem new name: 'Is soft empty'; boolean: self isSoftEmpty.
		GtPhlowOverviewItem new name: 'Is primary modifier'; boolean: self isPrimaryModifier.
		GtPhlowOverviewItem new name: 'Is cmd'; boolean: self isCmd.
		GtPhlowOverviewItem new name: 'Is ctrl'; boolean: self isCtrl.
		GtPhlowOverviewItem new name: 'Is shift'; boolean: self isShift.
		GtPhlowOverviewItem new name: 'Is alt'; boolean: self isAlt.
		GtPhlowOverviewItem new name: 'Is capslock'; boolean: self isCapsLock.
		GtPhlowOverviewItem new name: 'Is numlock'; boolean: self isNumLock.
		GtPhlowOverviewItem new name: 'Is super'; boolean: self isSuper.
	}
]

{ #category : #'*Bloc-Extensions' }
BlKeyModifiers >> gtOverviewFor: aView [
	<gtView>
	hashKey ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Overview';
		items: [ self gtOverview ];
		column: 'Name' text: #name;
		column: 'Value' text: #description weight: 3;
		send: #value
]

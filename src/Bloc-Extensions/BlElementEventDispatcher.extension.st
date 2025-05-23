Extension { #name : #BlElementEventDispatcher }

{ #category : #'*Bloc-Extensions' }
BlElementEventDispatcher >> gtEventsFor: aView [
	<gtView>
	^ aView columnedList
		priority: 2;
		title: 'Events';
		items: [ (activatedElementEvents asDictionary associations
				sorted: [ :a :b | a key < b key ])
				, ((activatedGeneralEvents ifNil: [ #() ]) asArray
						collect: [ :each | each -> true ]) ];
		column: 'Type' text: [ :each | each key ];
		column: 'Enabled'
			text: [ :each | 
				each value
					ifTrue: [ 'yes' ]
					ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] ];
		sendTool: [ :anAssoc | 
			anAssoc key isBehavior
				ifFalse: [ anAssoc key gtDefaultInspectorTool ]
				ifTrue: [ GtClassCoderTool forClass: anAssoc key ] ]
]

Extension { #name : #BlDevScripterMemoryLoggerToStepOrganizer }

{ #category : #'*Bloc-Extensions' }
BlDevScripterMemoryLoggerToStepOrganizer >> gtOrganizedRecordingsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Organized recordings';
		priority: 2;
		items: [ stepRecordings ifNil: [ #() ] ifNotNil: #associations ];
		children: [ :anObject | (anObject isKindOf: Association) ifTrue: [ anObject value ] ifFalse: [ #() ] ];
		column: 'Name'
			text: [ :anObject | 
				(anObject isKindOf: Association)
					ifTrue: [ anObject key label asRopedText
							append: ((' {1} {2}'
									format: {anObject value size.
											'recording' asPluralBasedOn: anObject value size}) asRopedText
									foreground: BrGlamorousColors disabledButtonTextColor) ]
					ifFalse: [ anObject value ] ];
		send: [ :anObject | 
			(anObject isKindOf: Association)
				ifTrue: [ MemoryLogger withRecordings: anObject value ]
				ifFalse: [ anObject ] ]
]

{ #category : #'*Bloc-Extensions' }
BlDevScripterMemoryLoggerToStepOrganizer >> gtRecordingsFor: aView [
	<gtView>
	^ aView forward
		title: 'Recordings';
		priority: 1;
		object: [ MemoryLogger withRecordings: (recordings ifNil: [ #() ]) ];
		view: #gtRecordingsFor:
]

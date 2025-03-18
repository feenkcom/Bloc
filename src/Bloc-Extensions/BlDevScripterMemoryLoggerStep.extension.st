Extension { #name : #BlDevScripterMemoryLoggerStep }

{ #category : #'*Bloc-Extensions' }
BlDevScripterMemoryLoggerStep >> gtActionStopMemoryLoggerFor: anAction [
	<gtAction>
	memoryLogger ifNil: [ ^ anAction noAction ].
	memoryLogger isRunning ifFalse: [ ^ anAction noAction ].

	^ anAction button
		icon: BrGlamorousVectorIcons stop;
		label: 'Logger';
		tooltip: 'Stop memory logger';
		action: [ :aButton | memoryLogger stop ]
]

{ #category : #'*Bloc-Extensions' }
BlDevScripterMemoryLoggerStep >> gtGroupedFor: aView [
	<gtView>
	^ aView forward
		title: 'Grouped recordings';
		priority: -9;
		object: [ memoryLogger ];
		view: #gtGroupedFor:
]

{ #category : #'*Bloc-Extensions' }
BlDevScripterMemoryLoggerStep >> gtInterestingAnnouncementsFor: aView [
	<gtView>
	^ aView forward
		title: 'Interesting announcements';
		priority: -5;
		object: [ memoryLogger ];
		view: #gtInterestingAnnouncementsFor:
]

{ #category : #'*Bloc-Extensions' }
BlDevScripterMemoryLoggerStep >> gtOrganizedRecordingsFor: aView [
	<gtView>
	memoryLogger ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Recordings per steps';
		priority: -7;
		object: [ BlDevScripterMemoryLoggerToStepOrganizer new
				steps: self substeps;
				recordings: memoryLogger recordings;
				organize ];
		view: #gtOrganizedRecordingsFor:
]

{ #category : #'*Bloc-Extensions' }
BlDevScripterMemoryLoggerStep >> gtRecordingsFor: aView [
	<gtView>
	^ aView forward
		title: 'Recordings';
		priority: -10;
		object: [ memoryLogger ];
		view: #gtRecordingsFor:
]

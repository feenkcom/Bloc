Extension { #name : #BlDevScripterMemoryLoggerStep }

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
BlDevScripterMemoryLoggerStep >> gtRecordingsFor: aView [
	<gtView>
	^ aView forward
		title: 'Recordings';
		priority: -10;
		object: [ memoryLogger ];
		view: #gtRecordingsFor:
]

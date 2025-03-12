Extension { #name : #BlBasicEventHandler }

{ #category : #'*Bloc-Extensions' }
BlBasicEventHandler >> gtEventsToHandleFor: aView [
	<gtView>
	self eventsToHandle ifEmpty: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Handled events';
		items: [ self eventsToHandle ifNil: [ #() ] ];
		column: 'Event' text: #yourself
]

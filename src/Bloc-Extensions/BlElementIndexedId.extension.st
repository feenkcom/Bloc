Extension { #name : #BlElementIndexedId }

{ #category : #'*Bloc-Extensions' }
BlElementIndexedId >> gtAllUniqueIdsFor: aView [
	<gtView>
	self prefixId ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'All unique ids';
		priority: 4;
		object: [ self prefixId ];
		view: #gtAllUniqueIdsFor:
]

{ #category : #'*Bloc-Extensions' }
BlElementIndexedId >> gtAllUsagesFor: aView [
	<gtView>
	self prefixId ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'All usages';
		priority: 2;
		object: [ self prefixId ];
		view: #gtAllUsagesFor:
]

{ #category : #'*Bloc-Extensions' }
BlElementIndexedId >> gtSimilarUniqueIdsFor: aView [
	<gtView>
	self prefixId ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Similar unique ids';
		priority: 3;
		object: [ self prefixId ];
		view: #gtSimilarUniqueIdsFor:
]

{ #category : #'*Bloc-Extensions' }
BlElementIndexedId >> gtUsagesFor: aView [
	<gtView>
	self prefixId ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Usages';
		priority: 1;
		object: [ self prefixId ];
		view: #gtUsagesFor:
]

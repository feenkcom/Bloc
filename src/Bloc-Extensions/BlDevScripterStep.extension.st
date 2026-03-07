Extension { #name : #BlDevScripterStep }

{ #category : #'*Bloc-Extensions' }
BlDevScripterStep >> gtTargetsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Targets';
		items: [ Array streamContents: [ :aStream | self target putTargetsInto: aStream ] ];
		column: 'Target' text: #gtDisplayText
]

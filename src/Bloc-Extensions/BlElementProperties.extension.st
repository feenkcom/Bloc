Extension { #name : #BlElementProperties }

{ #category : #'*Bloc-Extensions' }
BlElementProperties >> gtPropertiesFor: aView [
	<gtView>
	
	self isEmpty
		ifTrue: [ ^ aView empty ].
	
	^ aView list
		title: 'Properties';
		priority: 5;
		items: [
			(Array streamContents: [ :s | self do: [ :each | s nextPut: each ] ])
				sorted: [ :a :b | a printString < b printString ] ]
]

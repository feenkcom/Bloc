Extension { #name : #BlChildrenWrappingGeometry }

{ #category : #'*Bloc-Extensions' }
BlChildrenWrappingGeometry >> gtFreeRectanglesFor: aView [
	<gtView>
	rectangles ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Free rectangles';
		priority: 15;
		items: [ (self freeRectanglesExclucingGroups: self groupsFromIntersectingPairs) asOrderedCollection ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #'*Bloc-Extensions' }
BlChildrenWrappingGeometry >> gtGroupsFor: aView [
	<gtView>
	rectangles ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Groups';
		priority: 12;
		object: [ self groupsFromIntersectingPairs ];
		view: #gtTreeFor:context:
]

{ #category : #'*Bloc-Extensions' }
BlChildrenWrappingGeometry >> gtIntersectingPairsFor: aView [
	<gtView>
	rectangles ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Intersecting Pairs';
		priority: 11;
		items: [ self intersectingPairs ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'First rectangle' text: [ :each | each first ];
		column: 'Second rectangle' text: [ :each | each second ]
]

{ #category : #'*Bloc-Extensions' }
BlChildrenWrappingGeometry >> gtRectanglesFor: aView [
	<gtView>
	rectangles ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Rectangles';
		priority: 10;
		items: [ rectangles ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'In group'
			text: [ :aRectangle | 
				| aGroupIndex |
				aGroupIndex := '-'.
				self groupsFromIntersectingPairs
					doWithIndex: [ :eachGroup :anIndex | 
						(eachGroup identityIncludes: aRectangle)
							ifTrue: [ aGroupIndex := 'No. ' , anIndex asString ] ].
				aGroupIndex ]
			width: 60;
		column: 'Is free'
			text: [ :aRectangle | 
				((self freeRectanglesExclucingGroups: self groupsFromIntersectingPairs)
					identityIncludes: aRectangle) ifTrue: [ 'free' ] ifFalse: [ '-' ] ]
			width: 50;
		column: 'Rectangle' text: [ :each | each gtDisplayString ]
]

Class {
	#name : #BlChildrenWrappingGeometry,
	#superclass : #BlElementGeometry,
	#instVars : [
		'rectangles',
		'cornerRadius',
		'pathCache',
		'rectangleEnlargement'
	],
	#category : #'Bloc-Core-Geometries'
}

{ #category : #'instance creation' }
BlChildrenWrappingGeometry class >> cornerRadius: aNumber [
	^ self new
		cornerRadius: aNumber;
		yourself
]

{ #category : #'instance creation' }
BlChildrenWrappingGeometry class >> cornerRadius: aNumber enlargedBy: aScalarOrPoint [
	^ self new
		cornerRadius: aNumber;
		enlargement: aScalarOrPoint;
		yourself
]

{ #category : #'geometry testing' }
BlChildrenWrappingGeometry >> containsPoint: aPoint in: aBlElement [
	^ rectangles anySatisfy: [ :e | e containsPoint: aPoint ]
]

{ #category : #accessing }
BlChildrenWrappingGeometry >> cornerRadius [
	^ cornerRadius
]

{ #category : #accessing }
BlChildrenWrappingGeometry >> cornerRadius: anObject [
	cornerRadius := anObject
]

{ #category : #testing }
BlChildrenWrappingGeometry >> dependsOnElementChildren [
	^ true
]

{ #category : #accessing }
BlChildrenWrappingGeometry >> enlargement [
	^ rectangleEnlargement
]

{ #category : #accessing }
BlChildrenWrappingGeometry >> enlargement: aScalarOrPoint [
	rectangleEnlargement := aScalarOrPoint
]

{ #category : #geometry }
BlChildrenWrappingGeometry >> freeRectanglesExclucingGroups: groups [
	| freeRectangles |
	freeRectangles := rectangles asIdentitySet.
	groups do: [ :eachGroup | freeRectangles removeAllFoundIn: eachGroup ].
	^ freeRectangles
]

{ #category : #'api - bounds' }
BlChildrenWrappingGeometry >> geometryBounds: aBounds of: aBlElement [
	aBounds
		origin: 0.0@0.0
		extent: aBlElement extent.
	^ aBounds
]

{ #category : #geometry }
BlChildrenWrappingGeometry >> groupsFromIntersectingPairs [
	| intersectingPairs |
	intersectingPairs := self intersectingPairs.
	^ self groupsFromIntersectingPairs: intersectingPairs
]

{ #category : #geometry }
BlChildrenWrappingGeometry >> groupsFromIntersectingPairs: intersectingPairs [
	| groups |
	groups := OrderedCollection new.
	intersectingPairs
		do: [ :eachPair | 
			groups
				detect: [ :eachSet | (eachSet includes: eachPair first) or: [ eachSet includes: eachPair second ] ]
				ifFound: [ :eachSet | eachSet addAll: eachPair ]
				ifNone: [ groups add: eachPair asIdentitySet ] ].
	^ groups
]

{ #category : #initialization }
BlChildrenWrappingGeometry >> initialize [
	super initialize.
	
	rectangles := #().
	cornerRadius := 0.
	rectangleEnlargement := 0@0.
	pathCache := BlPathCache on: self
]

{ #category : #geometry }
BlChildrenWrappingGeometry >> intersectingPairs [
	| intersectingPairs |
	intersectingPairs := OrderedCollection new.
	rectangles
		combinations: 2
		atATimeDo: [ :combination | 
			((combination first blocEnlargedBy: rectangleEnlargement)
				intersects: (combination second blocEnlargedBy: rectangleEnlargement))
				ifTrue: [ intersectingPairs add: combination copy ] ].
	^ intersectingPairs
]

{ #category : #geometry }
BlChildrenWrappingGeometry >> matchElement: anElement [
	rectangles := anElement children
		collect: [ :e | e bounds inParent asRectangle "blocEnlargedBy: rectangleEnlargement" ]
]

{ #category : #geometry }
BlChildrenWrappingGeometry >> pathOnSpartaCanvas: aCanvas of: aBlElement [
	"Computes boundaries according to https://stackoverflow.com/questions/289779/calculating-a-boundary-around-several-linked-rectangles.
	Assumes bounds are overlapping or touching, gaps will lead to only parts included in geometry."

	| path groups freeRectangles |
	groups := self groupsFromIntersectingPairs.
	path := aCanvas path.
	freeRectangles := self freeRectanglesExclucingGroups: groups.
	groups
		do: [ :eachGroup | self pathOnSpartaCanvas: path overlappingRectangles: eachGroup asArray ].
	freeRectangles
		do: [ :each | self pathOnSpartaCanvas: path overlappingRectangles: {each} ].
	^ path build
]

{ #category : #geometry }
BlChildrenWrappingGeometry >> pathOnSpartaCanvas: path overlappingRectangles: bounds [
	| vertices xs ys areas corners points directions initialCursor cursor direction |
	"1. compute areas covered by children bounds"
	vertices := bounds
		flatCollect: [ :e | 
			{e origin.
			e corner} ].
	xs := (vertices collect: #x) "asSet" asOrderedCollection sorted.
	ys := (vertices collect: #y) "asSet" asOrderedCollection sorted.
	areas := (Array2D
		rows: ys size - 1
		columns: xs size - 1
		element: false)
		withIndicesCollect: [ :e :i :j | 
			bounds
				anySatisfy: [ :f | 
					f
						containsRect:
							(Rectangle
								origin: (xs at: j) @ (ys at: i)
								corner: (xs at: j + 1) @ (ys at: i + 1)) ] ].
	"2. detect corners around covered area"
	corners := (Array2D rows: ys size columns: xs size element: false)
		withIndicesCollect: [ :e :i :j | 
			| topLeft topRight bottomLeft bottomRight neighbours |
			topLeft := areas at: i - 1 at: j - 1 ifInvalid: false.
			topRight := areas at: i - 1 at: j ifInvalid: false.
			bottomLeft := areas at: i at: j - 1 ifInvalid: false.
			bottomRight := areas at: i at: j ifInvalid: false.
			neighbours := ({topLeft.
			topRight.
			bottomLeft.
			bottomRight} select: #yourself) size.
			neighbours odd
				ifTrue: [ true ]
				ifFalse: [ (neighbours = 0 or: [ neighbours = 4 ])
						ifTrue: [ false ]
						ifFalse: [ topLeft = bottomRight ] ] ].
	"3. collect corner points and direction on which they were detected"
	points := OrderedCollection new.
	directions := OrderedCollection new.
	initialCursor := ((corners atRow: 1)
		detectIndex: #yourself
		ifNone: [ ^ self ]) @ 1.
	cursor := initialCursor.
	direction := 0 @ 1.
	points add: (xs at: cursor x) @ (ys at: cursor y).
	directions add: 0 @ -1.
	[ | backtrackingCursor |
	backtrackingCursor := cursor.
	direction := direction y negated @ direction x.
	[ cursor := cursor + direction ]
		doWhileFalse: [ (cursor <= corners extent and: [ cursor >= (1 @ 1) ])
				ifTrue: [ corners at: cursor y at: cursor x ]
				ifFalse: [ "backtrack to original cursor, rotate direction"
					cursor := backtrackingCursor.
					direction := direction y negated @ direction x.
					false ] ].
	points add: (xs at: cursor x) @ (ys at: cursor y).
	directions add: direction.
	direction := direction negated ]
		doWhileFalse: [ cursor = initialCursor ].
		

	"4. compute path with rounded corners"
	path
		moveTo: points first + (cornerRadius @ cornerRadius * directions second).
	"last points is same as first, remove it"
	points removeFirst.
	directions removeFirst.
	points
		withIndexDo: [ :e :i | 
			| directionIncoming directionOutgoing previous next before after |
			directionIncoming := directions at: i.
			directionOutgoing := directions at: i \\ points size + 1.
			previous := points at: (i - 2 + points size) \\ points size + 1.
			next := points at: i \\ points size + 1.
			before := e
				-
					((cornerRadius min: (e - previous) r / 2.0) asPoint * directionIncoming).
			after := e
				+ ((cornerRadius min: (e - next) r / 2.0) asPoint * directionOutgoing).
			path lineTo: before.
			(directionIncoming crossProduct: directionOutgoing) < 0
				ifTrue: [ path ccwArcTo: after ]
				ifFalse: [ path cwArcTo: after ] ].
				
	path close
]

{ #category : #'visual bounds' }
BlChildrenWrappingGeometry >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	^ anElement outskirts
		strokedBounds: aBlBounds
		of: anElement
		on: aCanvas
]

{ #category : #'visual bounds' }
BlChildrenWrappingGeometry >> strokedBoundsCentered: aBlBounds of: anElement on: aCanvas [
	^ (self geometryBounds: aBlBounds of: anElement)
		expandBy: anElement border width / 2.0
]

{ #category : #'visual bounds' }
BlChildrenWrappingGeometry >> strokedBoundsInside: aBlBounds of: anElement on: aCanvas [
	"Stroked inside bounds property is equal to geometry bounds"
	<return: #BlBounds>

	^ self geometryBounds: aBlBounds of: anElement
]

{ #category : #'visual bounds' }
BlChildrenWrappingGeometry >> strokedBoundsOutside: aBlBounds of: anElement on: aCanvas [
	^ (self geometryBounds: aBlBounds of: anElement)
		expandBy: anElement border width
]

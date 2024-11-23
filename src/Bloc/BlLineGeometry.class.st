"
I define a geometry of a straight line

"
Class {
	#name : #BlLineGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'from',
		'to'
	],
	#category : #'Bloc-Core-Geometries'
}

{ #category : #'instance creation' }
BlLineGeometry class >> from: aFromPoint to: aToPoint [
	<return: #BlLineGeometry>
	
	^ self new from: aFromPoint to: aToPoint
]

{ #category : #private }
BlLineGeometry >> compute2PointsBasedIn: width from: pointFrom to: pointTo [
	| magicWidth vector u left right |
	vector := pointFrom - pointTo.
	u := vector normal.
	left := pointFrom - (u * width).
	right := pointFrom + (u * width).

	^ { left. right }
]

{ #category : #private }
BlLineGeometry >> computeRectangleFor: aCollectionOfPoints in: aBlLineElement [
	| points width |
	points := OrderedCollection new.
	width := aBlLineElement border width/2.
	2 to: aCollectionOfPoints size do: [ :i |
		| p1 p2 |
		p1 := aCollectionOfPoints at: i - 1.
		p2 := aCollectionOfPoints at: i.
		points 
			addAll: (self compute2PointsBasedIn: width from: p1 to: p2);
			addAll: (self compute2PointsBasedIn: width from: p2 to: p1).
	 ].
	^ Rectangle encompassing: points.
]

{ #category : #'geometry testing' }
BlLineGeometry >> containsPoint: aPoint in: anElement on: aSpartaCanvas [
	"Note: I am a fallback method to determine if a point lies within a geometry path
	when geometry is complex and it is mathematically difficult to compute manually"
	<return: #Boolean>
	| aPath |
	
	aPath := pathCache pathOnSpartaCanvas: aSpartaCanvas.
	^ aSpartaCanvas stroke
		path: aPath;
		width: (anElement border width max: 6);
		containsPoint: aPoint
]

{ #category : #accessing }
BlLineGeometry >> from [
	"Return start location of the line in owner element's local coordinate system"
	<return: #Point>

	^ from
]

{ #category : #accessing }
BlLineGeometry >> from: aPoint [
	self from: aPoint to: to
]

{ #category : #initialization }
BlLineGeometry >> from: aFromPoint to: aToPoint [

	(from = aFromPoint and: [ to = aToPoint ])
		ifFalse: [ self releaseCache ].

	from := aFromPoint.
	to := aToPoint
]

{ #category : #geometry }
BlLineGeometry >> geometryBounds: aBounds [
	^ (aBounds rectangle: (Rectangle encompassing: { self from . self to}))
]

{ #category : #'api - bounds' }
BlLineGeometry >> geometryBounds: aBounds of: aBlElement [
	"Load my geometry bounds for a given element in a mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>
	
	^ aBounds rectangle: (self computeRectangleFor: {self from. self to} in: aBlElement)
]

{ #category : #initialization }
BlLineGeometry >> initialize [
	super initialize.

	from := 0@0.
	to := 0@0
]

{ #category : #accessing }
BlLineGeometry >> intersectionWith: anotherSegment [
	"Copied from LineSegment>>intersectionWith:"
	| det deltaPt alpha beta pt1Dir pt2Dir |
	pt1Dir := to - from.
	pt2Dir := anotherSegment to - anotherSegment from.
	det := (pt1Dir x * pt2Dir y) - (pt1Dir y * pt2Dir x).
	deltaPt := anotherSegment from - from.
	alpha := (deltaPt x * pt2Dir y) - (deltaPt y * pt2Dir x).
	beta := (deltaPt x * pt1Dir y) - (deltaPt y * pt1Dir x).
	det = 0 ifTrue:[^nil]. "no intersection"
	alpha * det < 0 ifTrue:[^nil].
	beta * det < 0 ifTrue:[^nil].
	det > 0 
		ifTrue:[(alpha > det or:[beta > det]) ifTrue:[^nil]]
		ifFalse:[(alpha < det or:[beta < det]) ifTrue:[^nil]].
	"And compute intersection"
	^from + (alpha * pt1Dir / (det@det))
]

{ #category : #geometry }
BlLineGeometry >> matchExtent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
BlLineGeometry >> to [
	"Return end location of the line in owner element's local coordinate system"
	<return: #Point>

	^ to
]

{ #category : #accessing }
BlLineGeometry >> to: aPoint [
	self from: from to: aPoint
]

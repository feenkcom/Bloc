"
To be used by elements that wish to support children-only transformations.
Default element's transformations are applied on the eleent itself, meaning that an element with x2 scale transformation will appear twice as larged within its parent. Children-only transformation is applied on direct children without affecting how the parent element is rendered.

Because children-only transformation is a quite rare use-case we decided to only offer it as a Trait.
"
Trait {
	#name : #TBlWithChildrenTransformation,
	#instVars : [
		'childrenTransformation'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #'geometry bounds convertion' }
TBlWithChildrenTransformation >> childrenBoundsToLocal: aBounds [
	"In-place transform bounds from my childrens' coordinates to my local coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #BlBounds>

	^ self childrenTransformation transformBounds: aBounds
]

{ #category : #'geometry position convertion' }
TBlWithChildrenTransformation >> childrenPointToLocal: aPoint [
	"Transform a given point from the local coordinates of my children to my local coordinates"
	<return: #Point>

	^ self childrenTransformation transformPoint: aPoint
]

{ #category : #transformations }
TBlWithChildrenTransformation >> childrenTransformDo: aBlock [
	| aTransformationBuilder |

	aTransformationBuilder := BlTransformationBuilder on: self.
	aBlock value: aTransformationBuilder.
	aTransformationBuilder applyOnChildren
]

{ #category : #transformations }
TBlWithChildrenTransformation >> childrenTransformation [
	<return: #BlElementTransformation>

	^ childrenTransformation ifNil: [ childrenTransformation := self defaultChildrenTransformation ]
]

{ #category : #transformations }
TBlWithChildrenTransformation >> childrenTransformation: anElementTransformation [
	childrenTransformation := anElementTransformation asCachedTransformation
		bounds: self bounds inLocal asRectangle.

	self layout isInfluencedByTransformation
		ifTrue: [ self requestLayout ].

	self boundsCache invalidateBoundsInSpace.
	self invalidate.

	self onTransformationChanged
]

{ #category : #initialization }
TBlWithChildrenTransformation >> defaultChildrenTransformation [
	"Return an instance of BlTransformation that plays a role of my children transformation"
	<return: #BlElementTransformation>

	^ BlElementIdentityTransformation uniqueInstance asCachedTransformation
]

{ #category : #'geometry bounds' }
TBlWithChildrenTransformation >> invalidationBounds [
	^ (self invalidationBounds: BlBounds new) asRectangle
]

{ #category : #'geometry bounds' }
TBlWithChildrenTransformation >> invalidationBounds: aBounds [
	| anInvalidationBounds |

	anInvalidationBounds := (super invalidationBounds: aBounds).
	anInvalidationBounds merge: (self childrenTransformation inverseTransformBounds: aBounds copy).
	
	^ anInvalidationBounds
]

{ #category : #'geometry bounds convertion' }
TBlWithChildrenTransformation >> localBoundsToChildren: aBounds [
	"In-place transform bounds from my local coordinates to my childrens' coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #BlBounds>

	^ self childrenTransformation inverseTransformBounds: aBounds
]

{ #category : #'geometry position convertion' }
TBlWithChildrenTransformation >> localPointToChildren: aPoint [
	"Transform a given point from my local coordinates to the local coordinates of my children."
	<return: #Point>

	^ self childrenTransformation inverseTransformPoint: aPoint
]

{ #category : #transformations }
TBlWithChildrenTransformation >> updateTransformationBounds [
	"Update the bounds of the cached transformation in order to recompute its matrix
	since transformation origin depends on the element's bounds"
	super updateTransformationBounds.
	
	self childrenTransformation bounds: self bounds inLocal asRectangle
]

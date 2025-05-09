Class {
	#name : #BlElementBoundsUpdater,
	#superclass : #Object,
	#instVars : [
		'changes',
		'viewport'
	],
	#category : #'Bloc-Core-Bounds'
}

{ #category : #'api - changes' }
BlElementBoundsUpdater >> changeExtentFrom: aPreviousExtent to: aNewExtent of: anElement [
	(changes
		at: anElement
		ifAbsentPut: [ BlElementBoundsUpdaterChange new element: anElement ])
			changeExtentFrom: aPreviousExtent to: aNewExtent
]

{ #category : #'api - changes' }
BlElementBoundsUpdater >> changePositionFrom: aPreviousPosition to: aNewPosition of: anElement [
	(changes
		at: anElement
		ifAbsentPut: [ BlElementBoundsUpdaterChange new element: anElement ])
			changePositionFrom: aPreviousPosition to: aNewPosition
]

{ #category : #'change reporting' }
BlElementBoundsUpdater >> commitChanges [
	| theAssociations theElements theRoots parentsWhoseChildrenMovedOrResized|
	
	theAssociations := (changes associations sorted: [ :a :b | a key compositionDepth > b key compositionDepth ]).
	
	theAssociations ifNotEmpty: [
		BlFrameTelemetry
			time: [ 'commitChanges' ]
			during: [ 
				theAssociations do: [ :eachAssociation | eachAssociation value commitLocalChanges ].
				
				parentsWhoseChildrenMovedOrResized := IdentitySet new.
				theAssociations do: [ :eachAssociation | eachAssociation key parent ifNotNil: [ :aParentElement |
					parentsWhoseChildrenMovedOrResized add: aParentElement ] ].
				
				parentsWhoseChildrenMovedOrResized do: [ :eachParent | eachParent onChildMovedOrResized ].
				
				theElements := theAssociations
					select: [ :eachAssociation | eachAssociation value isPositionChanged ]
					thenCollect: [ :eachAssociation | eachAssociation key ].

				theRoots := BlSpace extractRoots: theElements.
				theRoots do: [ :eachRootElement |
					BlFrameTelemetry
						time: [ 'onPositionInSpaceChanged ', eachRootElement class name ]
						during: [ eachRootElement withAllChildrenBreadthFirstDo: [ :eachChild | eachChild onPositionInSpaceChanged ] ] ]  ] ]
]

{ #category : #'as yet unclassified' }
BlElementBoundsUpdater >> copyWithViewport: aBlElementBounds [
	^ self copy viewport: aBlElementBounds
]

{ #category : #initialization }
BlElementBoundsUpdater >> initialize [
	super initialize.
	
	changes := IdentityDictionary new.
]

{ #category : #accessing }
BlElementBoundsUpdater >> viewport [
	^ viewport
]

{ #category : #accessing }
BlElementBoundsUpdater >> viewport: anObject [
	viewport := anObject
]

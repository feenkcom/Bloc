Class {
	#name : #BlSteppedLayoutState,
	#superclass : #Object,
	#instVars : [
		'containerWidth',
		'containerHeight',
		'anchorBounds',
		'preferredChildWeight',
		'preferredDirection',
		'occupiedAreas',
		'occupiedBounds'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #accessing }
BlSteppedLayoutState >> anchorBounds [
	^ anchorBounds
]

{ #category : #accessing }
BlSteppedLayoutState >> anchorBounds: anObject [
	self assert: [ containerHeight isNotNil ] description:  [ 'Container height must be setup first' ].
	self assert: [ containerWidth isNotNil ] description:  [ 'Container width must be setup first' ].

	anchorBounds := anObject.
	occupiedBounds := (anchorBounds origin max: 0@0) corner: (anchorBounds corner min: containerWidth @ containerHeight)
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutState >> availableAreas [
	| areasToTheRight areasToTheLeft aPreviousArea|

	occupiedAreas
		ifEmpty: [ ^ self initialAvailableAreas ].
	
	aPreviousArea := occupiedAreas last.
	
	areasToTheRight := {
		BlSteppedLayoutArea new
			direction: #right;
			alignTopLeft;
			bounds: (aPreviousArea right @ aPreviousArea top corner: containerWidth @ containerHeight).
			
		BlSteppedLayoutArea new
			direction: #right;
			alignBottomLeft;
			bounds: (aPreviousArea right @ 0 corner: containerWidth @ containerHeight).
	}.
	
	areasToTheLeft := {
		BlSteppedLayoutArea new
			direction: #left;
			alignTopRight;
			bounds: (0 @aPreviousArea top corner: aPreviousArea left @ containerHeight).
			
		BlSteppedLayoutArea new
			direction: #left;
			alignBottomRight;
			bounds: (0 @0 corner: aPreviousArea left @ containerHeight).
	}.


	^ preferredDirection = #undefined
		ifTrue: [ areasToTheRight, areasToTheLeft ]
		ifFalse: [
			preferredDirection = #left
				ifTrue: [ areasToTheLeft, areasToTheRight ]
				ifFalse: [ areasToTheRight, areasToTheLeft ] ]
]

{ #category : #accessing }
BlSteppedLayoutState >> containerHeight [
	^ containerHeight
]

{ #category : #accessing }
BlSteppedLayoutState >> containerHeight: anObject [
	containerHeight := anObject
]

{ #category : #accessing }
BlSteppedLayoutState >> containerWidth [
	^ containerWidth
]

{ #category : #accessing }
BlSteppedLayoutState >> containerWidth: anObject [
	containerWidth := anObject
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutState >> estimateHeightSpecOf: aLayoutChildNode [
	<return: #BlMeasurementSpec>
	| aPreferredChildHeight |
	
	aPreferredChildHeight := containerHeight.
	
	^ aLayoutChildNode verticalResizer measurementAtMostWith: aPreferredChildHeight
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutState >> estimateWidthSpecOf: aLayoutChildNode [
	<return: #BlMeasurementSpec>
	| aPreferredChildWidth |
	
	aPreferredChildWidth := containerWidth * preferredChildWeight.
	
	^ aLayoutChildNode horizontalResizer measurementAtMostWith: aPreferredChildWidth
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutState >> gtAreasPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 4;
		stencil: [ | container |
			container := BlElement new.
			container outskirts: BlOutskirts outside.
			container border: (BlBorder paint: Color lightGray width: 2).
			container margin: (BlInsets all: 6).
			
			self containerWidth isInfinite
				ifTrue: [ container constraintsDo: [ :c | c horizontal matchParent ] ]
				ifFalse: [ container width: self containerWidth ].

			self containerHeight isInfinite
				ifTrue: [ container constraintsDo: [ :c | c vertical matchParent ] ]
				ifFalse: [ container height: self containerHeight ].

			container
				addChildren: ((self availableAreas first: 1)
						collect: [ :eachArea | 
							BlElement new
								relocate: eachArea bounds origin;
								size: eachArea bounds extent;
								border: BrGlamorousColors primaryBorderColor;
								background: (BrGlamorousColors primaryBorderColor alpha: 0.4) ]).

			container
				addChildren: (occupiedAreas
						withIndexCollect: [ :eachArea :index | 
							BrHorizontalPane new
								alignCenter;
								relocate: eachArea bounds origin;
								exact: eachArea bounds extent;
								border: BrGlamorousColors failureBackgroundColor;
								background: (BrGlamorousColors failureBackgroundColor alpha: 0.4);
								addChild: (BrLabel new
									aptitude: BrGlamorousLabelAptitude;
									text: index asRopedText) ]).

			container
				addChild: (BlElement new
						relocate: anchorBounds origin;
						size: anchorBounds extent;
						border: BrGlamorousColors errorBackgroundColor;
						background: (BrGlamorousColors errorBackgroundColor alpha: 0.4)).

			container ];
		actionUpdateButton
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutState >> gtAvailableAreasFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Available areas';
		priority: 6;
		items: [ self availableAreas ];
		column: 'Bounds' text: #bounds;
		column: 'Direction' text: #direction;
		actionUpdateButton
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutState >> gtInfoFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Info';
		priority: 5;
		items: [ {
			'Container width' -> containerWidth.
			'Container height' -> containerHeight.
			'Anchor bounds' -> anchorBounds.
			'Occupied bounds' -> occupiedBounds.
			'Occupied areas' -> occupiedAreas.
			'Preferred child weight' -> preferredChildWeight.
			'Preferred direction' -> preferredDirection.
		} ];
		column: 'Name' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutState >> initialAvailableAreas [
	^ {
		"bottom right"
		BlSteppedLayoutArea new
			direction: #right;
			alignTopLeft;
			bounds: (occupiedBounds corner corner: containerWidth @ containerHeight).
		
		"all to the right"
		BlSteppedLayoutArea new
			direction: #right;
			alignBottomLeft;
			bounds: (occupiedBounds right @ 0 corner: containerWidth @ containerHeight).

		"bottom left"
		BlSteppedLayoutArea new
			direction: #left;
			alignTopRight;
			bounds: (0 @ occupiedBounds bottom corner: occupiedBounds left @ containerHeight).
		
		"all to the left"
		BlSteppedLayoutArea new
			direction: #left;
			alignBottomRight;
			bounds: (0 @ 0 corner: occupiedBounds left @ containerHeight).
	}
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutState >> initialize [
	super initialize.

	preferredDirection := #undefined.
	occupiedAreas := OrderedCollection new
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutState >> measureAndPlaceChild: aLayoutChildNode [
	| estimatedWidth estimatedHeight childPosition |
	estimatedWidth := self estimateWidthSpecOf: aLayoutChildNode.
	estimatedHeight := self estimateHeightSpecOf: aLayoutChildNode.

	aLayoutChildNode
		measure: (BlExtentMeasurementSpec new
				widthSpec: estimatedWidth;
				heightSpec: estimatedHeight).

	childPosition := self placeMeasuredChild: aLayoutChildNode.
	aLayoutChildNode position: childPosition
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutState >> placeMeasuredChild: aLayoutChildNode [
	self availableAreas
		detect: [ :eachArea | eachArea hasEnoughSpaceFor: aLayoutChildNode ]
		ifFound: [ :anArea |
			| childPosition childBounds |
			
			childPosition := anArea positionOfMeasuredChild: aLayoutChildNode.
			childBounds := childPosition extent: aLayoutChildNode extent.
			occupiedBounds := occupiedBounds
				merge: childBounds.
			
			occupiedAreas add: (anArea copy bounds: childBounds).
			occupiedAreas size >= 2
				ifTrue: [ preferredDirection := anArea direction. ].

			^ childPosition
		]
		ifNone:  [
			self error: #TODO
		]
]

{ #category : #accessing }
BlSteppedLayoutState >> preferredChildWeight [
	^ preferredChildWeight
]

{ #category : #accessing }
BlSteppedLayoutState >> preferredChildWeight: anObject [
	preferredChildWeight := anObject
]

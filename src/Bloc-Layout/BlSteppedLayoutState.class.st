"
I represent a {{gtClass:BlSteppedLayout}} state. When {{gtMethod:BlSteppedLayout>>#measure: | label=#selector}} is called, a state is created and children nodes measured and placed.
# Example
{{gtExample: BlSteppedLayoutExamples >> #elementWithTwoRelativeChildren | codeExpanded=false | previewExpanded=true | previewHeight=800}}
"
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
		'occupiedBounds',
		'handle',
		'initialAvailableAreaBuilders',
		'padding',
		'suboptimalAreaFinder'
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

{ #category : #measure }
BlSteppedLayoutState >> availableAreasFor: aLayoutChildNode [
	| areasToTheRight areasToTheLeft isAltLeft |
	occupiedAreas ifEmpty: [ ^ self initialAvailableAreas ].

	isAltLeft := false.
	areasToTheRight := self availableAreasToTheRightFor: aLayoutChildNode.
	areasToTheLeft := self availableAreasToTheLeftFor: aLayoutChildNode.
	
	(areasToTheRight isEmpty and: [ areasToTheLeft isEmpty ]) 
		ifTrue: [ 
			areasToTheRight := self availableAreasToTheAltRightFor: aLayoutChildNode.
			areasToTheLeft := self availableAreasToTheAltLeftFor: aLayoutChildNode. ]
		ifFalse: [ 
			(areasToTheLeft isEmpty and: [ (preferredDirection = #left) not ])
				ifTrue: [
					"Relevant examples:
					- BlSteppedLayoutExamples>>#atMostNodeWithFirstWideChild_lessRight_layoutState_measureSecondChild
					- BlSteppedLayoutExamples>>#atMostNodeWithFirstWideChild_moreRight_layoutState_measureSecondChild"
					areasToTheLeft := self availableAreasToTheAltRightFor: aLayoutChildNode ].
			(areasToTheLeft isEmpty and: [ (preferredDirection = #left) ])
				ifTrue: [
					isAltLeft := true.
					areasToTheLeft := self availableAreasToTheAltLeftFor: aLayoutChildNode ] ].
	
	^ preferredDirection = #undefined
		ifTrue: [ areasToTheRight , areasToTheLeft ]
		ifFalse: [ preferredDirection = #left
				ifTrue: [
					isAltLeft
						ifFalse: [ areasToTheLeft , areasToTheRight ]
						ifTrue: [ 
							"We do not want to prioritize alternative to-the-left areas.
							Relevant examples:
							- BlSteppedLayoutExamples>>#atMostNodeWithSecondWideChild_layoutState_measureThirdChild
							- BlSteppedLayoutExamples>>#atMostNodeWithSecondAndThirdWideChildren_layoutState_measureThirdChild"
							areasToTheRight , areasToTheLeft ] ]
				ifFalse: [ areasToTheRight , areasToTheLeft ] ]
]

{ #category : #measure }
BlSteppedLayoutState >> availableAreasToTheAltLeftFor: aLayoutChildNode [
	| aPreviousArea aRelativeBounds firstBounds firstArea secondBounds secondArea |
	
	aPreviousArea := occupiedAreas last.
	aRelativeBounds := aLayoutChildNode constraints stepped relativeBounds.

	firstBounds := aRelativeBounds 
		ifNil: [
			self containerPositionXWithPadding @ aPreviousArea top
				corner: self containerExtentWithPadding ]
		ifNotNil: [ :aRectangle |
			(self containerPositionXWithPadding @ (aPreviousArea top + aRectangle top)
				corner: self containerExtentWithPadding) ].

	firstArea := BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark bottomRight;
				direction: #right;
				alignTopLeft;
				bounds: firstBounds.

	secondBounds := self containerPositionWithPadding corner: self containerExtentWithPadding.
	secondArea := BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark allToRight;
				direction: #right;
				alignBottomLeft;
				bounds: secondBounds.
				
	^ { firstArea. secondArea }
]

{ #category : #measure }
BlSteppedLayoutState >> availableAreasToTheAltRightFor: aLayoutChildNode [
	| previousArea relativeBounds firstBounds firstArea secondBounds secondArea |
	
	previousArea := occupiedAreas last.
	relativeBounds := aLayoutChildNode constraints stepped relativeBounds.

	firstBounds := relativeBounds 
		ifNil: [
			self containerPositionXWithPadding @ previousArea top
				corner: previousArea right @ self containerHeightWithPadding ]
		ifNotNil: [ :aRectangle |
			(self containerPositionXWithPadding @ (previousArea top + aRectangle top)
				corner: previousArea right @ self containerHeightWithPadding) ].

	firstArea := BlSteppedLayoutArea new
		mark: BlSteppedLayoutMark bottomLeft;
		direction: #left;
		alignTopRight;
		bounds: firstBounds.

	secondBounds := self containerPositionWithPadding 
		corner: previousArea right @ self containerHeightWithPadding.
	
	secondArea := BlSteppedLayoutArea new
		mark: BlSteppedLayoutMark allToLeft;
		direction: #left;
		alignBottomRight;
		bounds: secondBounds.
	
	^ { firstArea. secondArea }
]

{ #category : #measure }
BlSteppedLayoutState >> availableAreasToTheLeftFor: aLayoutChildNode [
	| aPreviousArea aRelativeBounds firstBounds firstArea secondBounds secondArea |
	
	aPreviousArea := occupiedAreas last.
	aRelativeBounds := aLayoutChildNode constraints stepped relativeBounds.

	firstBounds := aRelativeBounds 
		ifNil: [ 
			self containerPositionXWithPadding @ aPreviousArea top 
				corner: aPreviousArea left @ self containerHeightWithPadding ]
		ifNotNil: [ :aRectangle | 
			(self containerPositionXWithPadding @ (aPreviousArea top + aRectangle top)
				corner: aPreviousArea left @ self containerHeightWithPadding) ].

	firstBounds area isZero 
		ifFalse: [
			firstArea := BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark bottomLeft;
				direction: #left;
				alignTopRight;
				bounds: firstBounds ].

	secondBounds := self containerPositionWithPadding 
		corner: aPreviousArea left @ self containerHeightWithPadding.
	
	secondBounds area isZero 
		ifFalse: [ 
			secondArea := BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark allToLeft;
				direction: #left;
				alignBottomRight;
				bounds: secondBounds ].
	
	^ { firstArea. secondArea } reject: #isNil
]

{ #category : #measure }
BlSteppedLayoutState >> availableAreasToTheRightFor: aLayoutChildNode [
	| previousArea relativeBounds firstBounds firstArea secondBounds secondArea |
	
	previousArea := occupiedAreas last.
	relativeBounds := aLayoutChildNode constraints stepped relativeBounds.

	firstBounds := relativeBounds 
		ifNil: [ 
			previousArea right @ previousArea top
				corner: self containerExtentWithPadding ]
		ifNotNil: [ :aRectangle | 
			(previousArea right @ (previousArea top + aRectangle top)
				corner: self containerExtentWithPadding) ].

	firstBounds area isZero 
		ifFalse: [
			firstArea := BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark bottomRight;
				direction: #right;
				alignTopLeft;
				bounds: firstBounds ].

	secondBounds := previousArea right @ (self containerPositionYWithPadding) 
		corner: self containerExtentWithPadding.
	
	secondBounds area isZero 
		ifFalse: [ 
			secondArea := BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark allToRight;
				direction: #right;
				alignBottomLeft;
				bounds: secondBounds ].

	^ { firstArea. secondArea } reject: #isNil
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> containerCornerWithPadding [
	^ self containerExtentWithPadding - self containerPositionWithPadding
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> containerExtent [
	^ self containerWidth @ self containerHeight
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> containerExtentWithPadding [
	^ self containerWidthWithPadding @ self containerHeightWithPadding
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> containerHeight [
	^ containerHeight
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> containerHeight: anObject [
	containerHeight := anObject
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> containerHeightWithPadding [
	^ containerHeight - padding bottom
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> containerPositionWithPadding [
	^ padding left @ padding top
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> containerPositionXWithPadding [
	^ padding left
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> containerPositionYWithPadding [
	^ padding top
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> containerWidth [
	^ containerWidth
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> containerWidth: anObject [
	containerWidth := anObject
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> containerWidthWithPadding [
	^ containerWidth - padding right
]

{ #category : #measure }
BlSteppedLayoutState >> estimateHeightSpecOf: aLayoutChildNode [
	<return: #BlMeasurementSpec>
	| aPreferredChildHeight |
	
	aPreferredChildHeight := containerHeight.
	
	^ aLayoutChildNode verticalResizer measurementAtMostWith: aPreferredChildHeight
]

{ #category : #measure }
BlSteppedLayoutState >> estimateWidthSpecOf: aLayoutChildNode [
	<return: #BlMeasurementSpec>
	| aPreferredChildWidth |
	
	aPreferredChildWidth := containerWidth * preferredChildWeight.
	
	^ aLayoutChildNode horizontalResizer measurementAtMostWith: aPreferredChildWidth
]

{ #category : #accessing }
BlSteppedLayoutState >> handle [
	<return: #BlSteppedLayoutHandle>
	^ handle
]

{ #category : #accessing }
BlSteppedLayoutState >> handle: anObject [
	handle := anObject
]

{ #category : #accessing }
BlSteppedLayoutState >> initialAvailableAreaBuilders [
	<return: #Collection of: #BlSteppedLayoutAreaBuilder>
	^ initialAvailableAreaBuilders
]

{ #category : #accessing }
BlSteppedLayoutState >> initialAvailableAreaBuilders: aCollectionOfAreaBuilders [
	initialAvailableAreaBuilders := aCollectionOfAreaBuilders
]

{ #category : #measure }
BlSteppedLayoutState >> initialAvailableAreas [
	| someAreas |
	someAreas := self initialAvailableAreaBuilders
			collect: [ :eachBuilder | eachBuilder buildFor: self ]
			thenReject: [ :eachArea | eachArea bounds area isZero ].

	^ someAreas ifEmpty: [ 
		BlSteppedLayoutArea new
			mark: BlSteppedLayoutMark allToRight;
			direction: #right;
			alignTopLeft;
			bounds: (0 @ 0 corner: containerWidth @ containerHeight) ]
]

{ #category : #initialization }
BlSteppedLayoutState >> initialize [
	super initialize.

	preferredDirection := #undefined.
	occupiedAreas := OrderedCollection new
]

{ #category : #measure }
BlSteppedLayoutState >> measureAndPlaceChild: aLayoutChildNode [
	| childPosition tentativeChild |
	tentativeChild := BlSteppedLayoutTentativeChildNode new childNode: aLayoutChildNode.
	self measureChild: tentativeChild.
	
	"Reset (and therefore ignore) custom set position."
	tentativeChild position: 0@0.
	
	childPosition := self placeMeasuredChild: tentativeChild.
	tentativeChild consolidateMeasurement.
	aLayoutChildNode position: childPosition
]

{ #category : #measure }
BlSteppedLayoutState >> measureAndPlaceChildren: aCollectionOfLayoutChildNode [
	handle state: self measure: aCollectionOfLayoutChildNode.
]

{ #category : #measure }
BlSteppedLayoutState >> measureChild: aLayoutChildNode [
	| estimatedWidth estimatedHeight |
	estimatedWidth := self estimateWidthSpecOf: aLayoutChildNode.
	estimatedHeight := self estimateHeightSpecOf: aLayoutChildNode.

	aLayoutChildNode
		measure: (BlExtentMeasurementSpec new
				widthSpec: estimatedWidth;
				heightSpec: estimatedHeight).
]

{ #category : #accessing }
BlSteppedLayoutState >> occupiedAreas [
	^ occupiedAreas
]

{ #category : #accessing }
BlSteppedLayoutState >> occupiedBounds [
	^ occupiedBounds
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> padding [
	^ padding
]

{ #category : #'api - container bounds' }
BlSteppedLayoutState >> padding: anObject [
	padding := anObject
]

{ #category : #measure }
BlSteppedLayoutState >> placeMeasuredChild: aLayoutChildNode [
	| availableAreas selectedArea requestedChildExtent childPosition childBounds occupiedArea |
	
	"1. Define available areas for the given child node."
	availableAreas := self availableAreasFor: aLayoutChildNode.
	
	self 
		assert: [ availableAreas isNotEmpty ] 
		description: [ 'Available areas must include items' ].
	
	"2. Find the first layout area which has enough space for the given child node."
	availableAreas
		detect: [ :eachArea | eachArea hasEnoughSpaceFor: aLayoutChildNode ]
		ifFound: [ :anArea |
			selectedArea := anArea ]
		ifNone:  [
			selectedArea := nil ].
			
	selectedArea ifNil: [ 
		"3. There is not enough space for the child node."
		
		"3a. Find best available area"
		selectedArea := suboptimalAreaFinder findIn: availableAreas forNode: aLayoutChildNode.
			
		"3b. Shrink the child node. We also need to reset the position
		since a previous element position could be used."
		requestedChildExtent := aLayoutChildNode extent.
		aLayoutChildNode
			measure: (BlExtentMeasurementSpec new
					widthSpec: (aLayoutChildNode horizontalResizer measurementShrinkWith: selectedArea width);
					heightSpec: (aLayoutChildNode verticalResizer measurementShrinkWith: selectedArea height));
			position: 0@0. ].
			
	self 
		assert: [ selectedArea isNotNil ]
		description: [ 'Selected are must be non-nil' ].
	
	"3. Compute child node position and bounds."
	childPosition := selectedArea positionOfMeasuredChild: aLayoutChildNode.
	childBounds := childPosition extent: aLayoutChildNode extent.
	
	"4. Update stepped constraint mark which indicates where the child is placed."
	aLayoutChildNode constraints stepped mark: selectedArea mark.

	"5. Update internal values"
	occupiedArea := BlSteppedLayoutOccupiedArea new
		availableAreas: availableAreas;
		selectedArea: selectedArea;
		bounds: childBounds.
	requestedChildExtent ifNotNil: [ :anExtent |
		occupiedArea requestedExtent: anExtent ].
	occupiedAreas ifNotEmpty: [ :theAreas | 
		occupiedArea previousArea: theAreas last ].
	occupiedBounds := occupiedBounds merge: childBounds.
	occupiedAreas add: occupiedArea.
	occupiedAreas size >= 2
		ifTrue: [ preferredDirection := selectedArea direction. ].
	
	^ childPosition
]

{ #category : #accessing }
BlSteppedLayoutState >> preferredChildWeight [
	^ preferredChildWeight
]

{ #category : #accessing }
BlSteppedLayoutState >> preferredChildWeight: anObject [
	preferredChildWeight := anObject
]

{ #category : #accessing }
BlSteppedLayoutState >> suboptimalAreaFinder [
	^ suboptimalAreaFinder
]

{ #category : #accessing }
BlSteppedLayoutState >> suboptimalAreaFinder: anObject [
	suboptimalAreaFinder := anObject
]

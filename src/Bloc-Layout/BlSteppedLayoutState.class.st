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
		'initialAvailableAreaBuilders'
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
			0 @ aPreviousArea top
				corner: containerWidth @ containerHeight ]
		ifNotNil: [ :aRectangle |
			(0 @ (aPreviousArea top + aRectangle top)
				corner: containerWidth @ containerHeight) ].

	firstArea := BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark bottomRight;
				direction: #right;
				alignTopLeft;
				bounds: firstBounds.

	secondBounds := 0 @ 0 corner: containerWidth @ containerHeight.
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
			0 @ previousArea top
				corner: previousArea right @ containerHeight ]
		ifNotNil: [ :aRectangle |
			(0 @ (previousArea top + aRectangle top)
				corner: previousArea right @ containerHeight) ].

	firstArea := BlSteppedLayoutArea new
		mark: BlSteppedLayoutMark bottomLeft;
		direction: #left;
		alignTopRight;
		bounds: firstBounds.

	secondBounds := 0 @ 0 corner: previousArea right @ containerHeight.
	
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
			0 @ aPreviousArea top 
				corner: aPreviousArea left @ containerHeight ]
		ifNotNil: [ :aRectangle | 
			(0 @ (aPreviousArea top + aRectangle top)
				corner: aPreviousArea left @ containerHeight) ].

	firstBounds area isZero 
		ifFalse: [
			firstArea := BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark bottomLeft;
				direction: #left;
				alignTopRight;
				bounds: firstBounds ].

	secondBounds := 0 @ 0 corner: aPreviousArea left @ containerHeight.
	
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
				corner: containerWidth @ containerHeight ]
		ifNotNil: [ :aRectangle | 
			(previousArea right @ (previousArea top + aRectangle top)
				corner: containerWidth @ containerHeight) ].

	firstBounds area isZero 
		ifFalse: [
			firstArea := BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark bottomRight;
				direction: #right;
				alignTopLeft;
				bounds: firstBounds ].

	secondBounds := previousArea right @ 0 corner: containerWidth @ containerHeight.
	
	secondBounds area isZero 
		ifFalse: [ 
			secondArea := BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark allToRight;
				direction: #right;
				alignBottomLeft;
				bounds: secondBounds ].

	^ { firstArea. secondArea } reject: #isNil
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

{ #category : #initialization }
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
BlSteppedLayoutState >> occupiedBounds [
	^ occupiedBounds
]

{ #category : #measure }
BlSteppedLayoutState >> placeMeasuredChild: aLayoutChildNode [
	| availableAreas selectedArea childPosition childBounds |
	availableAreas := self availableAreasFor: aLayoutChildNode.
	
	self 
		assert: [ availableAreas isNotEmpty ] 
		description: [ 'Available areas must include items' ].
	
	availableAreas
		detect: [ :eachArea | eachArea hasEnoughSpaceFor: aLayoutChildNode ]
		ifFound: [ :anArea |
			selectedArea := anArea ]
		ifNone:  [
			selectedArea := nil ].
			
	selectedArea ifNil: [ 
		"There is not enough space for a child node."
		
		"1. Find best available area"
		selectedArea := BlSteppedLayoutAvailableAreaWidthPriorityFinder new
			nextFinder: BlSteppedLayoutAvailableAreaHeightPriorityFinder new;
			findIn: availableAreas forNode: aLayoutChildNode.
			
		"2. Shrink the child node. We also need to reset the position
		since a previous element position could be used."
		aLayoutChildNode
			measure: (BlExtentMeasurementSpec new
					widthSpec: (aLayoutChildNode horizontalResizer measurementShrinkWith: selectedArea width);
					heightSpec: (aLayoutChildNode verticalResizer measurementShrinkWith: selectedArea height));
			position: 0@0. ].
			
	self 
		assert: [ selectedArea isNotNil ]
		description: [ 'Selected are must be non-nil' ].
	
	childPosition := selectedArea positionOfMeasuredChild: aLayoutChildNode.
	childBounds := childPosition extent: aLayoutChildNode extent.
	aLayoutChildNode constraints stepped mark: selectedArea mark.

	occupiedAreas ifNotEmpty: [ :theAreas | 
		selectedArea previousArea: theAreas last ].
	occupiedBounds := occupiedBounds
		merge: childBounds.
	occupiedAreas add: (selectedArea copy bounds: childBounds).
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

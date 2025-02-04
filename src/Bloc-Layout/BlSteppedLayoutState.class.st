"
I represent a {{gtClass:BlSteppedLayout}} state. When {{gtMethod:BlSteppedLayout>>#measure: | label=#selector}} is called, a state is created and children nodes measured and placed.
# Example
{{gtExample: BlSteppedLayoutExamples >> #elementWithTwoThreeRelativeChildren | codeExpanded=false | previewExpanded=true | previewHeight=800}}
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
	| aPreviousArea anchoredAreasToTheRight areasToTheRight anchoredAreasToTheLeft areasToTheLeft |

	occupiedAreas
		ifEmpty: [ ^ self initialAvailableAreas ].
	
	aPreviousArea := occupiedAreas last.
	
	anchoredAreasToTheRight := aLayoutChildNode constraints stepped relativeBounds
		ifNil: [ {
			BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark bottomRight;
				direction: #right;
				alignTopLeft;
				bounds: (aPreviousArea right @ aPreviousArea top corner: containerWidth @ containerHeight).
		} ]
		ifNotNil: [ :aRectangle | {
			BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark bottomRight;
				direction: #right;
				alignTopLeft;
				bounds: (aPreviousArea right @ (aPreviousArea top + aRectangle top) corner: containerWidth @ containerHeight).
		} ].
	
	areasToTheRight := anchoredAreasToTheRight, {
		BlSteppedLayoutArea new
			mark: BlSteppedLayoutMark allToRight;
			direction: #right;
			alignBottomLeft;
			bounds: (aPreviousArea right @ 0 corner: containerWidth @ containerHeight).
	}.
	
	anchoredAreasToTheLeft := aLayoutChildNode constraints stepped relativeBounds
		ifNil: [ {
			BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark bottomLeft;
				direction: #left;
				alignTopRight;
				bounds: (0 @aPreviousArea top corner: aPreviousArea left @ containerHeight).
		} ]
		ifNotNil: [ :aRectangle | {
			BlSteppedLayoutArea new
				mark: BlSteppedLayoutMark bottomLeft;
				direction: #left;
				alignTopRight;
				bounds: (0 @ (aPreviousArea top + aRectangle top) corner: aPreviousArea left @ containerHeight).
		} ].
	
	areasToTheLeft := anchoredAreasToTheLeft, {
		BlSteppedLayoutArea new
			mark: BlSteppedLayoutMark allToLeft;
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
	<return: #BlSteppedHandle>
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
	^ self initialAvailableAreaBuilders collect: [ :eachBuilder |
		eachBuilder buildFor: self ]
]

{ #category : #initialization }
BlSteppedLayoutState >> initialize [
	super initialize.

	preferredDirection := #undefined.
	occupiedAreas := OrderedCollection new
]

{ #category : #measure }
BlSteppedLayoutState >> measureAndPlaceChild: aLayoutChildNode [
	| childPosition |
	self measureChild: aLayoutChildNode.
	
	"Reset (and therefore ignore) custom set position."
	aLayoutChildNode position: 0@0.
	
	childPosition := self placeMeasuredChild: aLayoutChildNode.
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
	
	availableAreas
		detect: [ :eachArea | eachArea hasEnoughSpaceFor: aLayoutChildNode ]
		ifFound: [ :anArea |
			selectedArea := anArea ]
		ifNone:  [
			"There is not enough space for a child node.
			Note: We should select best available area 
			and shrink the child node.
			Current solution is just a workaround."
			selectedArea := availableAreas anyOne ].
			
	selectedArea ifNil: [ self error: #TODO ].
	aLayoutChildNode constraints stepped mark: selectedArea mark.

	occupiedAreas ifNotEmpty: [ :theAreas | 
		selectedArea previousArea: theAreas last ].
	childPosition := selectedArea positionOfMeasuredChild: aLayoutChildNode.
	childBounds := childPosition extent: aLayoutChildNode extent.
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

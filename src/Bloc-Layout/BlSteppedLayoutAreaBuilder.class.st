"
I build {{gtClass:BlSteppedLayoutArea}} instances for a particular {{gtClass:BlSteppedLayoutState}}. 
The {{gtMethod:BlSteppedLayoutAreaBuilder>>#buildFor: | label=#selector}} method is used to create new instances.
The area {{gtMethod:BlSteppedLayoutAreaBuilder>>#bounds:}} are computed when a {{gtClass:BlSteppedLayoutState | label=layout state}} is known. 
Other values are set immediately.
#Preview
{{gtClass:BlSteppedLayoutAreaBuilder | show=#gtAreaBuildersFor: | expanded=true | height=550}}
"
Class {
	#name : #BlSteppedLayoutAreaBuilder,
	#superclass : #Object,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#instVars : [
		'area',
		'boundsBlock'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> allToBottom [
	^ self new
		mark: BlSteppedLayoutMark allToBottom;
		direction: #right;
		alignTopLeft;
		bounds: [ :aState | 
			aState containerPositionXWithPadding @ aState occupiedBounds bottom
				corner: aState containerExtentWithPadding ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> allToLeft [
	^ self new
		mark: BlSteppedLayoutMark allToLeft;
		direction: #left;
		alignBottomRight;
		bounds: [ :aState | aState containerPositionWithPadding 
			corner: aState occupiedBounds left @ aState containerHeightWithPadding ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> allToRight [
	^ self new
		mark: BlSteppedLayoutMark allToRight;
		direction: #right;
		alignBottomLeft;
		bounds: [ :aState | 
			aState occupiedBounds right @ (aState containerPositionYWithPadding)
				corner: aState containerExtentWithPadding ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> allToUp [
	^ self new
		mark: BlSteppedLayoutMark allToUp;
		direction: #right;
		alignBottomLeft;
		bounds: [ :aState | aState containerPositionWithPadding 
			corner: aState containerWidthWithPadding @ aState occupiedBounds top ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> contextMenuBottomLeft [
	^ self new
		mark: BlSteppedLayoutMark bottomLeft;
		direction: #left;
		alignTopRight;
		bounds: [ :aState | 
			aState containerPositionXWithPadding @ aState occupiedBounds bottom
				corner: aState occupiedBounds left @ aState containerHeightWithPadding ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> contextMenuBottomRight [
	^ self new
		mark: BlSteppedLayoutMark bottomRight;
		direction: #right;
		alignTopLeft;
		bounds: [ :aState | 
			aState occupiedBounds corner
				corner: aState containerExtentWithPadding ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> dropdownBottomLeft [
	^ self new
		mark: BlSteppedLayoutMark bottomLeft;
		direction: #left;
		alignTopRight;
		bounds: [ :aState | 
			"Hot patch: we do `bottom - 1` due to BlChildrenWrappingGeometry."
			aState containerPositionXWithPadding @ (aState occupiedBounds bottom - 1)
				corner: aState occupiedBounds right @ aState containerHeightWithPadding ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> dropdownBottomRight [
	^ self new
		mark: BlSteppedLayoutMark bottomRight;
		direction: #right;
		alignTopLeft;
		bounds: [ :aState | 
			"Hot patch: we do `bottom - 1` due to BlChildrenWrappingGeometry."
			(aState occupiedBounds bottomLeft - (0@1))
				corner: aState containerExtentWithPadding ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> dropdownUpLeft [
	^ self new
		mark: BlSteppedLayoutMark upLeft;
		direction: #left;
		alignBottomRight;
		bounds: [ :aState | 
			aState containerPositionWithPadding 
				corner: aState occupiedBounds right @ aState occupiedBounds top ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> dropdownUpRight [
	^ self new
		mark: BlSteppedLayoutMark upRight;
		direction: #right;
		alignBottomLeft;
		bounds: [ :aState | 
			aState occupiedBounds left @ aState containerPositionYWithPadding
				corner: aState containerWidthWithPadding @ aState occupiedBounds top ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> tooltipAllToBottom [
	^ self new
		mark: BlSteppedLayoutMark allToBottom;
		direction: #right;
		alignTopRight;
		bounds: [ :aState | 
			aState containerPositionXWithPadding @ aState occupiedBounds bottom 
				corner: aState containerExtentWithPadding. ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> tooltipBottomAlmostLeft [
	^ self new
		mark: BlSteppedLayoutMark bottomLeft;
		direction: #left;
		alignTopRight;
		bounds: [ :aState | 
			| aMinSpace |
			aMinSpace := BlSteppedLayoutTooltipAreaBoundsBuilder new
					layoutState: aState;
					minProtrudingWidth.
			
			aState containerPositionXWithPadding @ (aState occupiedBounds bottom)
				corner: aState occupiedBounds right + aMinSpace @ aState containerHeightWithPadding ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> tooltipBottomAlmostRight [
	^ self new
		mark: BlSteppedLayoutMark bottomRight;
		direction: #right;
		alignTopLeft;
		bounds: [ :aState | 
			| aMinSpace |
			aMinSpace := BlSteppedLayoutTooltipAreaBoundsBuilder new
					layoutState: aState;
					minProtrudingWidth.
			
			(aState occupiedBounds bottomLeft - (aMinSpace @ 0))
				corner: aState containerExtentWithPadding ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> tooltipBottomCenter [
	^ self new
		mark: BlSteppedLayoutMark allToBottom;
		direction: #right;
		alignTopCenter;
		bounds: [ :aState | 
			| aMinSpace |
			aMinSpace := BlSteppedLayoutTooltipAreaBoundsBuilder new
					layoutState: aState;
					minProtrudingWidth.
			(aState anchorLeft - aMinSpace) @ aState occupiedBounds bottom
				corner: (aState anchorRight + aMinSpace) @ aState containerHeightWithPadding ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> tooltipBottomLeft [
	^ self new
		mark: BlSteppedLayoutMark allToLeft;
		direction: #left;
		alignTopRight;
		bounds: [ :aState | 
			(0 @ aState occupiedBounds top)
				corner: (aState occupiedBounds left @ aState containerHeightWithPadding) ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> tooltipBottomRight [
	^ self new
		mark: BlSteppedLayoutMark allToRight;
		direction: #right;
		alignTopLeft;
		bounds: [ :aState | 
			(aState occupiedBounds topRight)
				corner: aState containerExtentWithPadding ]
]

{ #category : #deprecated }
BlSteppedLayoutAreaBuilder class >> tooltipLeftBottom [
	self
		deprecated: 'Please use #tooltipBottomLeft instead.'
		transformWith: '`@receiver tooltipLeftBottom' -> '`@receiver tooltipBottomLeft'.
	^ self tooltipBottomLeft
]

{ #category : #deprecated }
BlSteppedLayoutAreaBuilder class >> tooltipRightBottom [
	self
		deprecated: 'Please use #tooltipBottomRight instead.'
		transformWith: '`@receiver tooltipRightBottom' -> '`@receiver tooltipBottomRight'.
	^ self tooltipBottomRight
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> tooltipUpAlmostLeft [
	^ self new
		mark: BlSteppedLayoutMark upLeft;
		direction: #left;
		alignBottomRight;
		bounds: [ :aState | 
			| aMinSpace |
			aMinSpace := BlSteppedLayoutTooltipAreaBoundsBuilder new
					layoutState: aState;
					minProtrudingWidth.
			
			aState containerPositionWithPadding 
				corner: aState occupiedBounds right + aMinSpace @ aState occupiedBounds top ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> tooltipUpAlmostRight [
	^ self new
		mark: BlSteppedLayoutMark upRight;
		direction: #right;
		alignBottomLeft;
		bounds: [ :aState | 
			| aMinSpace |
			aMinSpace := BlSteppedLayoutTooltipAreaBoundsBuilder new
					layoutState: aState;
					minProtrudingWidth.
			
			aState occupiedBounds left - aMinSpace @ aState containerPositionYWithPadding
				corner: aState containerWidthWithPadding @ aState occupiedBounds top ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> tooltipUpCenter [
	^ self new
		mark: BlSteppedLayoutMark allToUp;
		direction: #right;
		alignBottomCenter;
		bounds: [ :aState | 
			| aMinSpace |
			aMinSpace := BlSteppedLayoutTooltipAreaBoundsBuilder new
					layoutState: aState;
					minProtrudingWidth.
			
			aState occupiedBounds left - aMinSpace @ aState containerPositionYWithPadding
				corner: (aState anchorRight + aMinSpace) @ aState occupiedBounds top ]
]

{ #category : #accessing }
BlSteppedLayoutAreaBuilder >> bounds [
	^ boundsBlock
]

{ #category : #accessing }
BlSteppedLayoutAreaBuilder >> bounds: aBlock [
	"Block that computes area bounds (`Rectangle`) for a given `BlSteppedLayoutState`.
	It has one argument: [ :aState | ... ].
	Note: The provided boundsBlock must consider state padding while computing are bounds."

	boundsBlock := aBlock
]

{ #category : #'api - building' }
BlSteppedLayoutAreaBuilder >> buildFor: aState [
	<return: #BlSteppedLayoutArea>
	| aNewArea aBounds |
	aNewArea := area copy.

	aBounds := boundsBlock cull: aState.
	self 
		assert: [ aBounds isNotNil ]
		description: [ 'Area bounds must be non-nil: {1}' format: { boundsBlock } ].
	aNewArea bounds: aBounds.
	
	^ aNewArea
]

{ #category : #'api - direction' }
BlSteppedLayoutAreaBuilder >> direction: aSymbol [
	area direction: aSymbol
]

{ #category : #'api - direction' }
BlSteppedLayoutAreaBuilder >> directionLeft [
	area direction: #left
]

{ #category : #'api - direction' }
BlSteppedLayoutAreaBuilder >> directionRight [
	area direction: #right
]

{ #category : #accessing }
BlSteppedLayoutAreaBuilder >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ area horizontalAlignment
]

{ #category : #accessing }
BlSteppedLayoutAreaBuilder >> horizontalAlignment: aBlElementAlignment [
	area horizontalAlignment: aBlElementAlignment
]

{ #category : #initialization }
BlSteppedLayoutAreaBuilder >> initialize [
	super initialize.
	area := BlSteppedLayoutArea new.
	boundsBlock := [ :aState | (aState occupiedBounds corner corner: aState containerWidth @ aState containerHeight) ]
]

{ #category : #'api - direction' }
BlSteppedLayoutAreaBuilder >> mark: aSymbol [
	area mark: aSymbol
]

{ #category : #accessing }
BlSteppedLayoutAreaBuilder >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ area verticalAlignment
]

{ #category : #accessing }
BlSteppedLayoutAreaBuilder >> verticalAlignment: aBlElementAlignment [
	area verticalAlignment: aBlElementAlignment
]

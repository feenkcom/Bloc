Class {
	#name : #BlSteppedLayout,
	#superclass : #BlNodeBasedLayout,
	#instVars : [
		'anchorBounds',
		'handle',
		'availableAreaBuilders'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #constraints }
BlSteppedLayout class >> constraints [
	^ BlSteppedLayoutConstraints new
]

{ #category : #accessing }
BlSteppedLayout >> anchorBounds [
	<return: #Rectangle>
	^ anchorBounds
]

{ #category : #accessing }
BlSteppedLayout >> anchorBounds: aRectangle [
	anchorBounds := aRectangle
]

{ #category : #'as yet unclassified' }
BlSteppedLayout >> beDropdown [
	availableAreaBuilders := {
		"bottom right"
		BlSteppedLayoutAreaBuilder new
			direction: #right;
			alignTopLeft;
			bounds: [ :aState | (aState occupiedBounds bottomLeft corner: aState containerWidth @ aState containerHeight) ].
			
		"bottom left"
		BlSteppedLayoutAreaBuilder new
			direction: #left;
			alignTopRight;
			bounds: [ :aState | (0 @ aState occupiedBounds bottom corner: aState occupiedBounds right @ aState containerHeight) ].
		
		"all to the bottom"
		BlSteppedLayoutAreaBuilder new
			direction: #right;
			alignBottomLeft;
			bounds: [ :aState | (0 @ aState occupiedBounds bottom corner: aState containerWidth @ aState containerHeight) ].
		
		"up right"
		BlSteppedLayoutAreaBuilder new
			direction: #right;
			alignBottomLeft;
			bounds: [ :aState | (aState occupiedBounds left @ 0 corner: aState containerWidth @ aState occupiedBounds top) ].
			
		"up left"
		BlSteppedLayoutAreaBuilder new
			direction: #left;
			alignBottomRight;
			bounds: [ :aState | (0 @ 0 corner: aState occupiedBounds right @ aState occupiedBounds top) ].
			
		"all to the up"
		BlSteppedLayoutAreaBuilder new
			direction: #right;
			alignBottomLeft;
			bounds: [ :aState | (0 @ 0 corner: aState containerWidth @ aState occupiedBounds top) ].
		
		"all to the right"
		BlSteppedLayoutAreaBuilder new
			direction: #right;
			alignBottomLeft;
			bounds: [ :aState | (aState occupiedBounds right @ 0 corner: aState containerWidth @ aState containerHeight) ].

		"all to the left"
		BlSteppedLayoutAreaBuilder new
			direction: #left;
			alignBottomRight;
			bounds: [ :aState | (0 @ 0 corner: aState occupiedBounds left @ aState containerHeight). ]
	}
]

{ #category : #measure }
BlSteppedLayout >> createStateFor: aParentLayoutNode [
	| containerWidth containerHeight |
	containerWidth := aParentLayoutNode extentSpec widthSpec
			sizeFor: Float infinity.
	containerHeight := aParentLayoutNode extentSpec heightSpec
			sizeFor: Float infinity.

	^ BlSteppedLayoutState new
		handle: handle;
		containerWidth: containerWidth;
		containerHeight: containerHeight;
		anchorBounds: anchorBounds;
		preferredChildWeight: 0.3;
		initialAvailableAreaBuilders: availableAreaBuilders
]

{ #category : #initialization }
BlSteppedLayout >> initialize [
	super initialize.
	
	anchorBounds := 0@0 extent: 1@1.
	handle := BlSteppedHandle null.
	availableAreaBuilders := self newInitialAvailableAreaBuilders
]

{ #category : #measure }
BlSteppedLayout >> measure: aParentLayoutNode [
	| state |
	
	state := self createStateFor: aParentLayoutNode.
	
	state measureAndPlaceChildren: aParentLayoutNode children.

	self measureParentNode: aParentLayoutNode
]

{ #category : #measure }
BlSteppedLayout >> measureParentNode: aParentLayoutNode [
	"Compute the measured extent of the parent node based on the measured bounds of the children"
	| boundingBox width height |

	boundingBox := aParentLayoutNode children boundingBox.

	width := boundingBox width + aParentLayoutNode padding width.
	height := boundingBox height + aParentLayoutNode padding height.

	aParentLayoutNode extent: (aParentLayoutNode extentSpec sizeFor: width @ height)
]

{ #category : #initialization }
BlSteppedLayout >> newInitialAvailableAreaBuilders [
	^ {
		"bottom right"
		BlSteppedLayoutAreaBuilder new
			direction: #right;
			alignTopLeft;
			bounds: [ :aState | (aState occupiedBounds corner corner: aState containerWidth @ aState containerHeight) ].
		
		"all to the right"
		BlSteppedLayoutAreaBuilder new
			direction: #right;
			alignBottomLeft;
			bounds: [ :aState | (aState occupiedBounds right @ 0 corner: aState containerWidth @ aState containerHeight) ].

		"bottom left"
		BlSteppedLayoutAreaBuilder new
			direction: #left;
			alignTopRight;
			bounds: [ :aState | (0 @ aState occupiedBounds bottom corner: aState occupiedBounds left @ aState containerHeight) ].
		
		"all to the left"
		BlSteppedLayoutAreaBuilder new
			direction: #left;
			alignBottomRight;
			bounds: [ :aState | (0 @ 0 corner: aState occupiedBounds left @ aState containerHeight). ]
	}
]

{ #category : #accessing }
BlSteppedLayout >> withCenterHandle [
	"Treat the first child as a (context menu) handle, placing it to the center of anchor bounds."

	handle := BlSteppedHandle center
]

{ #category : #accessing }
BlSteppedLayout >> withTopLeftHandle [
	"Treat the first child as a (context menu) handle, placing it to anchor bounds origin."

	handle := BlSteppedHandle topLeft
]

{ #category : #accessing }
BlSteppedLayout >> withoutHandle [
	"Treat the first child as a regular (context menu) element."

	handle := BlSteppedHandle null
]

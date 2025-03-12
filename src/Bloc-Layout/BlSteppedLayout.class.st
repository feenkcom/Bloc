"
I layout element children next to each other, treating them as a context (or dropdown) menu.
# Example
{{gtExample: BlSteppedLayoutExamples >> #elementWithTwoRelativeChildren | codeExpanded=false | previewExpanded=true | previewHeight=800}}
"
Class {
	#name : #BlSteppedLayout,
	#superclass : #BlNodeBasedLayout,
	#instVars : [
		'anchorBounds',
		'handle',
		'areaBuilders',
		'suboptimalAreaFinder',
		'analyzer'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #constraints }
BlSteppedLayout class >> constraints [
	^ BlSteppedLayoutConstraints new
]

{ #category : #'api - analysis' }
BlSteppedLayout >> analyzer [
	^ analyzer
]

{ #category : #'api - analysis' }
BlSteppedLayout >> analyzer: anObject [
	"Analyzer is used to analyze layout state computation.
	It can be any object that understands `#layoutState:`."

	analyzer := anObject
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

{ #category : #'api - areas' }
BlSteppedLayout >> areaBuilders [
	"Get a collection of area builders that are used to find a best
	place for a first (non-handle) element."

	<return: #Collection of: #BlSteppedLayoutAreaBuilder>
	^ areaBuilders
]

{ #category : #'api - areas' }
BlSteppedLayout >> areaBuilders: aCollection [
	"Set a collection of area builders that are used to find a best
	place for a first (non-handle) element."

	self
		assert: [ aCollection isNotNil ]
		description: [ 'Area builders must be non-nil' ].

	areaBuilders := aCollection
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
		padding: aParentLayoutNode constraints padding;
		preferredChildWeight: 0.3;
		initialAvailableAreaBuilders: areaBuilders;
		suboptimalAreaFinder: suboptimalAreaFinder
]

{ #category : #initialization }
BlSteppedLayout >> defaultAreaBuilders [
	^ {
		BlSteppedLayoutAreaBuilder contextMenuBottomRight.
		BlSteppedLayoutAreaBuilder allToRight.
		BlSteppedLayoutAreaBuilder contextMenuBottomLeft.
		BlSteppedLayoutAreaBuilder allToLeft.
		BlSteppedLayoutAreaBuilder allToBottom.
		BlSteppedLayoutAreaBuilder allToUp}
]

{ #category : #initialization }
BlSteppedLayout >> defaultSuboptimalAreaFinder [
	^ BlSteppedLayoutSuboptimalAreaWidthPriorityFinder new
		nextFinder: BlSteppedLayoutSuboptimalAreaHeightPriorityFinder new
]

{ #category : #initialization }
BlSteppedLayout >> initialize [
	super initialize.

	anchorBounds := 0 @ 0 extent: 1 @ 1.
	handle := BlSteppedLayoutHandle null.
	areaBuilders := self defaultAreaBuilders.
	suboptimalAreaFinder := self defaultSuboptimalAreaFinder.
	
	"Analyzer is anything that understands `#layoutState:`."
	analyzer := nil.
]

{ #category : #measure }
BlSteppedLayout >> measure: aParentLayoutNode [
	| state |
	
	state := self createStateFor: aParentLayoutNode.
	
	state measureAndPlaceChildren: aParentLayoutNode children.

	self measureParentNode: aParentLayoutNode.
	
	analyzer ifNotNil: [ :anAnalyzer | anAnalyzer layoutState: state ].
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

{ #category : #accessing }
BlSteppedLayout >> suboptimalAreaFinder [
	<return: #BlSteppedLayoutSuboptimalAreaFinder>
	^ suboptimalAreaFinder
]

{ #category : #accessing }
BlSteppedLayout >> suboptimalAreaFinder: anAreaFinder [
	"Set area finder that is used when there is not an available area 
	with enough space for a given child node.
	See {{gtMethod:BlSteppedLayoutState>>#placeMeasuredChild:}} for more details."
	
	self
		assert: [ anAreaFinder isNotNil ] 
		description: [ 'Suboptimal area finder must be non-nil' ].
	
	suboptimalAreaFinder := anAreaFinder
]

{ #category : #accessing }
BlSteppedLayout >> withCenteredHandle [
	"Treat the first child as a (context menu) handle, placing it to the center of anchor bounds."

	handle := BlSteppedLayoutHandle center
]

{ #category : #'api - areas' }
BlSteppedLayout >> withContextMenuAreas [
	self areaBuilders: self defaultAreaBuilders
]

{ #category : #'api - areas' }
BlSteppedLayout >> withDownUpDropdownAreas [
	"Place dropdowns only down or up"

	self areaBuilders: {
			BlSteppedLayoutAreaBuilder dropdownBottomRight.
			BlSteppedLayoutAreaBuilder dropdownBottomLeft.
			BlSteppedLayoutAreaBuilder dropdownAllToBottom.
			BlSteppedLayoutAreaBuilder dropdownUpRight.
			BlSteppedLayoutAreaBuilder dropdownUpLeft.
			BlSteppedLayoutAreaBuilder dropdownAllToUp. }
]

{ #category : #'api - areas' }
BlSteppedLayout >> withDropdownAreas [
	self areaBuilders: {
			BlSteppedLayoutAreaBuilder dropdownBottomRight.
			BlSteppedLayoutAreaBuilder dropdownBottomLeft.
			BlSteppedLayoutAreaBuilder dropdownAllToBottom.
			BlSteppedLayoutAreaBuilder dropdownUpRight.
			BlSteppedLayoutAreaBuilder dropdownUpLeft.
			BlSteppedLayoutAreaBuilder dropdownAllToUp.
			BlSteppedLayoutAreaBuilder allToRight.
			BlSteppedLayoutAreaBuilder allToLeft}
]

{ #category : #'api - areas' }
BlSteppedLayout >> withTooltipAreas [
	"Place dropdowns only down or up"

	self areaBuilders: {
			BlSteppedLayoutAreaBuilder dropdownBottomRight.
			BlSteppedLayoutAreaBuilder dropdownBottomLeft.
			BlSteppedLayoutAreaBuilder dropdownAllToBottom.
			BlSteppedLayoutAreaBuilder dropdownUpRight.
			BlSteppedLayoutAreaBuilder dropdownUpLeft.
			BlSteppedLayoutAreaBuilder dropdownAllToUp. }
]

{ #category : #accessing }
BlSteppedLayout >> withTopLeftHandle [
	"Treat the first child as a (context menu) handle, placing it to anchor bounds origin."

	handle := BlSteppedLayoutHandle topLeft
]

{ #category : #accessing }
BlSteppedLayout >> withoutHandle [
	"Treat the first child as a regular (context menu) element."

	handle := BlSteppedLayoutHandle null
]

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
		'areaBuilders'
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
		preferredChildWeight: 0.3;
		initialAvailableAreaBuilders: areaBuilders
]

{ #category : #initialization }
BlSteppedLayout >> defaultAreaBuilders [
	^ {
		BlSteppedLayoutAreaBuilder contextMenuBottomRight.
		BlSteppedLayoutAreaBuilder allToRight.
		BlSteppedLayoutAreaBuilder contextMenuBottomLeft.
		BlSteppedLayoutAreaBuilder allToLeft}
]

{ #category : #initialization }
BlSteppedLayout >> initialize [
	super initialize.
	
	anchorBounds := 0@0 extent: 1@1.
	handle := BlSteppedHandle null.
	areaBuilders := self defaultAreaBuilders
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

{ #category : #accessing }
BlSteppedLayout >> withCenteredHandle [
	"Treat the first child as a (context menu) handle, placing it to the center of anchor bounds."

	handle := BlSteppedHandle center
]

{ #category : #'api - areas' }
BlSteppedLayout >> withContextMenuAreas [
	self areaBuilders: self defaultAreaBuilders
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

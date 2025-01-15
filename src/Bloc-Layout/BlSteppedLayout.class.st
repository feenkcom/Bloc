Class {
	#name : #BlSteppedLayout,
	#superclass : #BlNodeBasedLayout,
	#instVars : [
		'anchorBounds',
		'handle'
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
		preferredChildWeight: 0.3
]

{ #category : #initialization }
BlSteppedLayout >> initialize [
	super initialize.
	
	anchorBounds := 0@0 extent: 1@1.
	handle := BlSteppedHandle null.
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

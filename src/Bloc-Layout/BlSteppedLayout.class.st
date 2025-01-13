Class {
	#name : #BlSteppedLayout,
	#superclass : #BlNodeBasedLayout,
	#instVars : [
		'anchorBounds'
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
		containerWidth: containerWidth;
		containerHeight: containerHeight;
		anchorBounds: anchorBounds;
		preferredChildWeight: 0.3
]

{ #category : #initialization }
BlSteppedLayout >> initialize [
	super initialize.
	
	anchorBounds := 0@0 extent: 1@1.
]

{ #category : #measure }
BlSteppedLayout >> measure: aParentLayoutNode [
	| state |
	
	state := self createStateFor: aParentLayoutNode.
	
	aParentLayoutNode children do: [ :eachChild |
		state measureAndPlaceChild: eachChild ].

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

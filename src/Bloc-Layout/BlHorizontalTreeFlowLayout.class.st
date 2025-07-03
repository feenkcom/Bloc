Class {
	#name : #BlHorizontalTreeFlowLayout,
	#superclass : #BlNodeBasedLayout,
	#instVars : [
		'properties',
		'allowedToScroll',
		'snapAnimation',
		'snapDelay'
	],
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #accessing }
BlHorizontalTreeFlowLayout class >> constraints [
	^ BlHorizontalTreeFlowLayoutConstraints new
]

{ #category : #accessing }
BlHorizontalTreeFlowLayout >> cellSpacing [
	^ properties cellSpacing
]

{ #category : #accessing }
BlHorizontalTreeFlowLayout >> cellSpacing: aNumber [
	properties cellSpacing: aNumber
]

{ #category : #measure }
BlHorizontalTreeFlowLayout >> createStateFor: aParentLayoutNode [
	| containerWidth containerHeight childrenGrid |
	containerWidth := aParentLayoutNode extentSpec widthSpec
			sizeFor: Float infinity.
	containerHeight := aParentLayoutNode extentSpec heightSpec
			sizeFor: Float infinity.

	childrenGrid := BlHorizontalTreeFlowLayoutGrid
		fromLayoutNodes: aParentLayoutNode children.

	^ BlHorizontalTreeFlowLayoutState new
		containerWidth: containerWidth;
		containerHeight: containerHeight;
		layoutProperties: properties;
		initializeWithGrid: childrenGrid;
		yourself
]

{ #category : #accessing }
BlHorizontalTreeFlowLayout >> fillEntireColumnHeight [
	"Each column height is equally filled by available children"

	self rowCount: BlHorizontalTreeFlowLayoutCellCount new
]

{ #category : #accessing }
BlHorizontalTreeFlowLayout >> fillRowHeight [
	"Each child in a given column occupies just its row height.
	In other words, the column height might not be used completely."

	self rowCount: BlHorizontalTreeFlowLayoutRowGrowingCount new
]

{ #category : #accessing }
BlHorizontalTreeFlowLayout >> firstVisibleColumn [
	^ properties firstVisibleColumn
]

{ #category : #accessing }
BlHorizontalTreeFlowLayout >> firstVisibleColumn: anInteger [
	properties firstVisibleColumn: anInteger
]

{ #category : #accessing }
BlHorizontalTreeFlowLayout >> growingRowCount [
	self rowCount: BlHorizontalTreeFlowLayoutRowGrowingCount new
]

{ #category : #accessing }
BlHorizontalTreeFlowLayout >> horizontalOffset [
	^ properties horizontalOffset
]

{ #category : #accessing }
BlHorizontalTreeFlowLayout >> horizontalOffset: aNumber [
	properties horizontalOffset: aNumber
]

{ #category : #initialization }
BlHorizontalTreeFlowLayout >> initialize [
	super initialize.
	
	properties := BlHorizontalTreeFlowLayoutProperties new.
	allowedToScroll := false
]

{ #category : #measure }
BlHorizontalTreeFlowLayout >> measure: aParentLayoutNode [
	| aState |

	aState := self createStateFor: aParentLayoutNode.
	aState measureAndPlaceChildren.

	self measureParentNode: aParentLayoutNode
]

{ #category : #measure }
BlHorizontalTreeFlowLayout >> measureParentNode: aParentLayoutNode [
	"Compute the measured extent of the parent node based on the measured bounds of the children"
	| boundingBox width height |

	boundingBox := aParentLayoutNode children boundingBox.

	width := boundingBox width + aParentLayoutNode padding width.
	height := boundingBox height + aParentLayoutNode padding height.

	aParentLayoutNode extent: (aParentLayoutNode extentSpec sizeFor: width @ height)
]

{ #category : #'mouse handlers' }
BlHorizontalTreeFlowLayout >> mouseWheelEvent: anEvent [
	snapAnimation ifNotNil: [ :anAnimation | anAnimation stopIfRunning ].
	snapDelay ifNotNil: [ :aDelay | aDelay stop ].

	anEvent phase = WinitEventTouchPhase Started
		ifTrue: [
			allowedToScroll := true.
			anEvent consumed: true.
			^ self ].
	
	anEvent phase = WinitEventTouchPhase Ended
		ifTrue: [
			allowedToScroll := false.
			anEvent consumed: true.
			
			snapDelay := BlDelayedTaskAction new
				delay: 100 milliseconds;
				action: [ anEvent currentTarget
					layoutDo: [ :l | l snapTo: anEvent currentTarget ] ].
			
			anEvent currentTarget enqueueTask: snapDelay.
			
			^ self ].
	
	allowedToScroll
		ifFalse: [ ^ self ].
	
	anEvent isPrimarilyHorizontal
		ifFalse: [ ^ self ].

	anEvent consumed: true.
	self horizontalOffset: self horizontalOffset + (anEvent vector x / anEvent currentTarget width)
]

{ #category : #accessing }
BlHorizontalTreeFlowLayout >> numberOfVisibleColumns [
	^ properties numberOfVisibleColumns
]

{ #category : #accessing }
BlHorizontalTreeFlowLayout >> numberOfVisibleColumns: aNumber [
	properties numberOfVisibleColumns: aNumber
]

{ #category : #accessing }
BlHorizontalTreeFlowLayout >> rowCount [
	<return: #BlHorizontalTreeFlowLayoutRowCount>
	^ properties rowCount
]

{ #category : #accessing }
BlHorizontalTreeFlowLayout >> rowCount: anObject [
	properties rowCount: anObject
]

{ #category : #'mouse handlers' }
BlHorizontalTreeFlowLayout >> snapTo: anElement [
	| visibleChildren firstChild firstVisibleColumn childrenGrid maxVisibleColumn|
	self assert: [ anElement layout == self ].
	
	visibleChildren := anElement children select: [ :each | each isVisibleInParent ].
	visibleChildren ifEmpty: [
		self firstVisibleColumn: 1.
		self horizontalOffset: 0.
		^ self ].

	childrenGrid := BlHorizontalTreeFlowLayoutGrid
		fromLayoutNodes: anElement children.
	
	maxVisibleColumn := (childrenGrid numberOfColumns - self numberOfVisibleColumns + 1) max: 1.
	
	firstChild := visibleChildren detectMin: [ :each | each constraints horizontalTreeFlow depth ].
	firstVisibleColumn := firstChild position x >= (firstChild width negated / 2.0)
		ifTrue: [ (firstChild constraints horizontalTreeFlow depth) min: maxVisibleColumn ]
		ifFalse: [ (firstChild constraints horizontalTreeFlow depth + 1) min: maxVisibleColumn ].
	
	self firstVisibleColumn: firstVisibleColumn.
	
	childrenGrid
		anyCellInColumn: firstVisibleColumn
		ifPresent: [ :aChild |
			| initialOffset |
			
			initialOffset := (aChild position x / anElement width) negated.
			snapAnimation := (BlNumberTransition new
				onStepDo: [ :eachOffset | anElement layoutDo: [ :l | l horizontalOffset: eachOffset ] ];
				from: initialOffset;
				to: 0;
				duration: 150 milliSeconds).
			
			self horizontalOffset: initialOffset.
			anElement addAnimation: snapAnimation ]
		ifEmpty:  [ self horizontalOffset: 0 ]
]

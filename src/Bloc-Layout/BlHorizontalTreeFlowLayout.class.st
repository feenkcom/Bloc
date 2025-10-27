Class {
	#name : #BlHorizontalTreeFlowLayout,
	#superclass : #BlNodeBasedLayout,
	#instVars : [
		'properties',
		'snapAnimation',
		'snapDelay'
	],
	#classVars : [
		'IsAnimationEnabled'
	],
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #accessing }
BlHorizontalTreeFlowLayout class >> constraints [
	^ BlHorizontalTreeFlowLayoutConstraints new
]

{ #category : #'api - animation' }
BlHorizontalTreeFlowLayout class >> disableAnimation [
	IsAnimationEnabled := false
]

{ #category : #'api - animation' }
BlHorizontalTreeFlowLayout class >> enableAnimation [
	IsAnimationEnabled := true
]

{ #category : #'api - animation' }
BlHorizontalTreeFlowLayout class >> isAnimationEnabled [
	^ IsAnimationEnabled ifNil: [ true ]
]

{ #category : #private }
BlHorizontalTreeFlowLayout >> basicNumberOfVisibleColumns: aColumnsCount in: anElement [
	anElement
		layoutDo: [ :l | 
			l numberOfVisibleColumns: aColumnsCount ]
]

{ #category : #private }
BlHorizontalTreeFlowLayout >> basicScrollToColumn: aColumn in: anElement [
	| initPosition |
	initPosition := anElement children
			detect: [ :eachChild | eachChild constraints horizontalTreeFlow depth = aColumn ]
			ifFound: [ :aChild | aChild position x ]
			ifNone: [ 0 ].

	anElement
		layoutDo: [ :l | 
			l firstVisibleColumn: aColumn.
			l horizontalOffset: 0 ].
	
	anElement eventDispatcher dispatchScrolled: initPosition negated @ 0
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> cellSpacing: aNumberOrPoint [
	"Set both #horizontalCellSpacing: and #verticalCellSpacing:"

	properties cellSpacing: aNumberOrPoint
]

{ #category : #'api - scrolling' }
BlHorizontalTreeFlowLayout >> computeHorizontalScrollExtentIn: anElement [
	self assert: [ anElement layout == self ].

	^ anElement width
]

{ #category : #'api - scrolling' }
BlHorizontalTreeFlowLayout >> computeHorizontalScrollOffsetIn: anElement [
	| minLeft |
	self assert: [ anElement layout == self ].

	minLeft := nil.
	anElement children accountedByLayout
		do: [ :eachChild | 
			minLeft
				ifNil: [ minLeft := eachChild bounds inParent left ]
				ifNotNil: [ minLeft := minLeft min: eachChild bounds inParent left ] ].

	minLeft ifNil: [ ^ 0 ].

	minLeft := minLeft - self horizontalCellSpacing.

	^ minLeft abs
]

{ #category : #'api - scrolling' }
BlHorizontalTreeFlowLayout >> computeHorizontalScrollRangeIn: anElement [
	| minLeft maxRight |
	self assert: [ anElement layout == self ].

	minLeft := nil.
	maxRight := nil.
	anElement children accountedByLayout
		do: [ :eachChild | 
			minLeft
				ifNil: [ minLeft := eachChild bounds inParent left ]
				ifNotNil: [ minLeft := minLeft min: eachChild bounds inParent left ].
			maxRight
				ifNil: [ maxRight := eachChild bounds inParent right ]
				ifNotNil: [ maxRight := maxRight max: eachChild bounds inParent right ] ].

	minLeft ifNil: [ ^ 0 ].
	maxRight ifNil: [ ^ 0 ].

	minLeft := minLeft - self horizontalCellSpacing.
	maxRight := maxRight + self horizontalCellSpacing.

	^ maxRight - minLeft
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

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> fillEntireColumnHeight [
	"Each column height is equally filled by available children"

	self rowCount: BlHorizontalTreeFlowLayoutCellCount new
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> fillRowHeight [
	"Each child in a given column occupies just its row height.
	In other words, the column height might not be used completely."

	self rowCount: BlHorizontalTreeFlowLayoutRowGrowingCount new
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> firstVisibleColumn [
	^ properties firstVisibleColumn
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> firstVisibleColumn: anInteger [
	properties firstVisibleColumn: anInteger
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> growingRowCount [
	self rowCount: BlHorizontalTreeFlowLayoutRowGrowingCount new
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> horizontalCellSpacing [
	^ properties horizontalCellSpacing
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> horizontalCellSpacing: aNumber [
	properties horizontalCellSpacing: aNumber
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> horizontalOffset [
	^ properties horizontalOffset
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> horizontalOffset: aNumber [
	properties horizontalOffset: aNumber
]

{ #category : #initialization }
BlHorizontalTreeFlowLayout >> initialize [
	super initialize.
	
	properties := BlHorizontalTreeFlowLayoutProperties new.
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

	width := boundingBox width + aParentLayoutNode padding width + (self horizontalCellSpacing * 2).
	height := boundingBox height + aParentLayoutNode padding height + (self verticalCellSpacing * 2).

	aParentLayoutNode extent: (aParentLayoutNode extentSpec sizeFor: width @ height)
]

{ #category : #'mouse handlers' }
BlHorizontalTreeFlowLayout >> mouseWheelEvent: anEvent [
	"WinitEventTouchPhase is only emitted on mac when using touchpad.
	The idea behind this experiment was to see if it is possible to implement snapping.
	We therefore disable most of the code for now."

	| aScrollDiff |
	self stopAnimation.	
	"anEvent phase = WinitEventTouchPhase Started
		ifTrue: [
			allowedToScroll := true.
			anEvent consumed: true.
			^ self ]."	"anEvent phase = WinitEventTouchPhase Ended
		ifTrue: [
			allowedToScroll := false.
			anEvent consumed: true.
			
			snapDelay := BlDelayedTaskAction new
				delay: 100 milliseconds;
				action: [ anEvent currentTarget
					layoutDo: [ :l | l snapTo: anEvent currentTarget ] ].
			
			anEvent currentTarget enqueueTask: snapDelay.
			
			^ self ]."	"allowedToScroll
		ifFalse: [ ^ self ]."

	anEvent isPrimarilyHorizontal ifFalse: [ ^ self ].

	anEvent consumed: true.

	aScrollDiff := anEvent vector x / anEvent currentTarget width.
	self horizontalOffset: self horizontalOffset + aScrollDiff.
	anEvent currentTarget eventDispatcher dispatchScrolled: aScrollDiff @ 0
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> numberOfVisibleColumns [
	^ properties numberOfVisibleColumns
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> numberOfVisibleColumns: anInteger [
	properties numberOfVisibleColumns: anInteger
]

{ #category : #'api - visible columns' }
BlHorizontalTreeFlowLayout >> numberOfVisibleColumns: aColumnsCount in: anElement [
	self assert: [ anElement layout == self ].

	self basicNumberOfVisibleColumns: aColumnsCount in: anElement
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> rowCount [
	<return: #BlHorizontalTreeFlowLayoutRowCount>
	^ properties rowCount
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> rowCount: anObject [
	properties rowCount: anObject
]

{ #category : #'api - scrolling' }
BlHorizontalTreeFlowLayout >> scrollHorizontallyBy: aNumber in: anElement [
	"Scroll horizontally by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."

	self assert: [ anElement layout == self ].
	
	self stopAnimation.
	self horizontalOffset: self horizontalOffset + (aNumber / anElement width).
	anElement requestLayout.
	
	anElement eventDispatcher dispatchScrolled: aNumber @ 0
]

{ #category : #'api - scrolling' }
BlHorizontalTreeFlowLayout >> scrollToColumn: aColumn in: anElement [
	self assert: [ anElement layout == self ].
	self stopAnimation.

	self basicScrollToColumn: aColumn in: anElement.
]

{ #category : #'api - visible columns' }
BlHorizontalTreeFlowLayout >> smoothNumberOfVisibleColumns: aColumnsCount in: anElement [
	| initialValue |
	self assert: [ anElement layout == self ].
	
	self class isAnimationEnabled ifFalse: [
		self basicNumberOfVisibleColumns: aColumnsCount in: anElement.
		^ self ].
	
	self stopAnimation.

	self numberOfVisibleColumns = aColumnsCount ifTrue: [ ^ self ].

	anElement width isZero
		ifTrue: [ self basicNumberOfVisibleColumns: aColumnsCount in: anElement.
			^ self ].

	initialValue := self numberOfVisibleColumns.

	snapAnimation := BlNumberTransition new
			onStepDo: [ :eachOffset | self basicNumberOfVisibleColumns: eachOffset in: anElement ];
			from: self numberOfVisibleColumns;
			to: aColumnsCount;
			by: 0.1;
			duration: 300 milliSeconds.
	anElement addAnimation: snapAnimation
]

{ #category : #'api - scrolling' }
BlHorizontalTreeFlowLayout >> smoothScrollToColumn: aColumn in: anElement [
	| childrenGrid |
	self assert: [ anElement layout == self ].
	self class isAnimationEnabled ifFalse: [
		self scrollToColumn: aColumn in: anElement.
		^ self ].
	self stopAnimation.
	
	anElement width isZero
		ifTrue: [ self basicScrollToColumn: aColumn in: anElement.
			^ self ].
	
	childrenGrid := BlHorizontalTreeFlowLayoutGrid
			fromLayoutNodes: anElement children accountedByLayout.
	childrenGrid
		anyCellInColumn: aColumn
		ifPresent: [ :aChild | 
			| initialOffset finalOffset |
			initialOffset := anElement layout horizontalOffset.
			finalOffset := initialOffset
					+ ((aChild position x - self horizontalCellSpacing) / anElement width).
			snapAnimation := BlNumberTransition new
					onStepDo: [ :eachOffset | anElement layoutDo: [ :l | l horizontalOffset: eachOffset ] ];
					from: initialOffset;
					to: finalOffset;
					duration: 300 milliSeconds;
					onFinishedDo: [ self basicScrollToColumn: aColumn in: anElement ].
			anElement addAnimation: snapAnimation ]
		ifEmpty: [ self basicScrollToColumn: aColumn in: anElement ]
]

{ #category : #private }
BlHorizontalTreeFlowLayout >> snapTo: anElement [
	| visibleChildren firstChild firstVisibleColumn childrenGrid maxVisibleColumn|
	self assert: [ anElement layout == self ].
	
	visibleChildren := anElement children select: [ :each | each isVisibleInParent ].
	visibleChildren ifEmpty: [
		self firstVisibleColumn: 1.
		self horizontalOffset: 0.
		^ self ].

	childrenGrid := BlHorizontalTreeFlowLayoutGrid
		fromLayoutNodes: anElement children accountedByLayout.
	
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

{ #category : #private }
BlHorizontalTreeFlowLayout >> stopAnimation [
	snapAnimation ifNotNil: [ :anAnimation | anAnimation stopIfRunning ].
	snapDelay ifNotNil: [ :aDelay | aDelay stop ]
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> verticalCellSpacing [
	^ properties verticalCellSpacing
]

{ #category : #'api - properties' }
BlHorizontalTreeFlowLayout >> verticalCellSpacing: aNumber [
	properties verticalCellSpacing: aNumber
]

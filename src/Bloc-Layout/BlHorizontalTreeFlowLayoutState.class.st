Class {
	#name : #BlHorizontalTreeFlowLayoutState,
	#superclass : #Object,
	#instVars : [
		'grid',
		'containerWidth',
		'containerHeight',
		'layoutProperties',
		'currentNumberOfRow',
		'minLeftChildNode',
		'maxRightChildNode',
		'maxInitialRight'
	],
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #measure }
BlHorizontalTreeFlowLayoutState >> adjustContainerInfinityHeight [
	| maxHeight |
	containerHeight isInfinite ifFalse: [ ^ self ].

	maxHeight := 0.
	grid
		allChildrenNodesDo: [ :eachChildNode | 
			| eachWidthSpec |
			eachWidthSpec := self
					estimateHeightSpecOf: eachChildNode
					numberOfRows: grid numberOfRows
					rowSpan: 1.
			eachWidthSpec isExact
				ifTrue: [ maxHeight := maxHeight max: eachWidthSpec size ].
			eachWidthSpec isAtMost
				ifTrue: [ maxHeight := maxHeight max: eachWidthSpec size ] ].

	maxHeight isZero ifTrue: [ maxHeight := 50 ].
	containerHeight := self verticalCellSpacing
			+ ((maxHeight + self verticalCellSpacing) * grid numberOfRows)
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutState >> adjustContainerInfinityWidth [
	| maxWidth |
	containerWidth isInfinite ifFalse: [ ^ self ].

	maxWidth := 0.
	grid
		allChildrenNodesDo: [ :eachChildNode | 
			| eachWidthSpec |
			eachWidthSpec := self
					estimateWidthSpecOf: eachChildNode
					numberOfColumns: self numberOfVisibleColumns.
			eachWidthSpec isExact
				ifTrue: [ maxWidth := maxWidth max: eachWidthSpec size ].
			eachWidthSpec isAtMost
				ifTrue: [ maxWidth := maxWidth max: eachWidthSpec size ] ].

	maxWidth isZero ifTrue: [ maxWidth := 50 ].
	containerWidth := self horizontalCellSpacing
			+ ((maxWidth + self horizontalCellSpacing) * self numberOfVisibleColumns)
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutState >> calculateX: column numberOfColumns: numberOfColumns [
	^ ((column - 1) max: 0) * containerWidth * 1.0 / numberOfColumns
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutState >> calculateY: row numberOfRows: numberOfRows [
	| positionY totalAvailableHeight|
	
	totalAvailableHeight := containerHeight - ((numberOfRows + 1) * self verticalCellSpacing).
	
	positionY := ((row - 1) max: 0) * totalAvailableHeight * 1.0 / numberOfRows.
	positionY := positionY + (row * self verticalCellSpacing).
	
	^ positionY
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutState >> computeLeftAndRightPositions [
	"Find left and right children"

	minLeftChildNode := nil.
	maxRightChildNode := nil.
	maxInitialRight := 0.
	grid allChildrenNodesDo: [ :eachChildNode |
		maxInitialRight < eachChildNode bounds right ifTrue: [
			maxInitialRight := eachChildNode bounds right.
			maxRightChildNode := eachChildNode ].
		minLeftChildNode 
			ifNil: [ minLeftChildNode := eachChildNode ]
			ifNotNil: [ eachChildNode bounds left < minLeftChildNode bounds left
				ifTrue: [ minLeftChildNode := eachChildNode ] ] ].
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> containerHeight [
	^ containerHeight
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> containerHeight: aNumber [
	containerHeight := aNumber
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> containerWidth [
	^ containerWidth
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> containerWidth: aNumber [
	containerWidth := aNumber
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutState >> estimateHeightSpecOf: aLayoutChildNode numberOfRows: aNumberOfRows rowSpan: rowSpan [
	<return: #BlMeasurementSpec>
	| totalAvailableHeight aPreferredChildHeight |

	totalAvailableHeight := containerHeight - ((aNumberOfRows + 1) * self verticalCellSpacing).
	aPreferredChildHeight := totalAvailableHeight * 1.0 / aNumberOfRows.
	aPreferredChildHeight := aPreferredChildHeight * rowSpan + (rowSpan - 1 * self verticalCellSpacing).

	^ aLayoutChildNode parent heightSpec mode
		measurement: aLayoutChildNode verticalResizer
		with: (aPreferredChildHeight max: 0)
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutState >> estimateWidthSpecOf: aLayoutChildNode numberOfColumns: aNumberOfColumns [
	<return: #BlMeasurementSpec>
	| totalAvailableWidth aPreferredChildWidth |

	totalAvailableWidth := containerWidth - ((aNumberOfColumns + 1) * self horizontalCellSpacing).
	aPreferredChildWidth := totalAvailableWidth * 1.0 / aNumberOfColumns.

	^ aLayoutChildNode parent widthSpec mode
		measurement: aLayoutChildNode horizontalResizer
		with: (aPreferredChildWidth max: 0)
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> firstDisplayedColumn [
	"Return the first displayed column.
	In case the first visible column leaves empty space to the right,
	the displayed column is the nearest column to the left which keeps
	the first visible column on the screen and fills empty space with
	previous columns."

	| displayedColumn |
	displayedColumn := (self firstVisibleColumn min: grid numberOfColumns) max: 1.
	^ displayedColumn + self numberOfVisibleColumns - 1 > (grid numberOfColumns + self numberOfExtraRightColumns)
		ifTrue: [ grid numberOfColumns + self numberOfExtraRightColumns - self numberOfVisibleColumns + 1 max: 1 ]
		ifFalse: [ displayedColumn ]
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> firstVisibleColumn [
	^ layoutProperties firstVisibleColumn
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> horizontalCellSpacing [
	^ layoutProperties horizontalCellSpacing
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> horizontalOffset [
	^ layoutProperties horizontalOffset
]

{ #category : #initialization }
BlHorizontalTreeFlowLayoutState >> initializeWithGrid: aGrid [
	grid := aGrid.
	currentNumberOfRow := aGrid numberOfRowsAtColumn: 1
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> layoutProperties [
	^ layoutProperties
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> layoutProperties: anObject [
	layoutProperties := anObject
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutState >> measureAndPlaceChildren [
	| previousColumnRight previousColumnBottom |
	self adjustContainerInfinityWidth.
	self adjustContainerInfinityHeight.
	
	previousColumnRight := 0.

	1
		to: grid numberOfColumns
		do: [ :column | 
			| positionX numberOfRowsInColumn cell |
			positionX := previousColumnRight + self horizontalCellSpacing.
			previousColumnBottom := 0.

			numberOfRowsInColumn := grid numberOfRowsAtColumn: column.
			currentNumberOfRow := self rowCount
					previousColumnRowCount: currentNumberOfRow
					grid: grid
					column: column.

			cell := 0.
			1
				to: grid numberOfRows
				do: [ :row | 
					grid
						cellAtRow: row
						column: column
						ifPresent: [ :aLayoutChildNode | 
							| eachChildX eachChildY eachChildRow eachChildSpan |
							cell := cell + 1.
							eachChildRow := self rowCount nodeRow: row cell: cell.
							eachChildSpan := self rowCount nodeSpan: aLayoutChildNode.

							self
								measureChild: aLayoutChildNode
								numberOfRows: currentNumberOfRow
								numberOfColumns: self numberOfVisibleColumns
								rowSpan: eachChildSpan.

							eachChildX := positionX.
							eachChildY := self
									calculateY: eachChildRow
									numberOfRows: currentNumberOfRow.

							aLayoutChildNode position: eachChildX @ eachChildY.

							previousColumnRight := previousColumnRight max: aLayoutChildNode right.
							previousColumnBottom := previousColumnBottom max: aLayoutChildNode bottom ]
						ifEmpty: [  ] ] ].

	self computeLeftAndRightPositions.
	self offsetChildrenToTheFirstDisplayedColumn.
	self offsetChildrenByHorizontalOffset.
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutState >> measureChild: aLayoutChildNode numberOfRows: numberOfRows numberOfColumns: numberOfColumns rowSpan: rowSpan [
	| estimatedWidth estimatedHeight |
	estimatedWidth := self
			estimateWidthSpecOf: aLayoutChildNode
			numberOfColumns: numberOfColumns.
	estimatedHeight := self
			estimateHeightSpecOf: aLayoutChildNode
			numberOfRows: numberOfRows
			rowSpan: rowSpan.

	aLayoutChildNode
		measure: (BlExtentMeasurementSpec new
				widthSpec: estimatedWidth;
				heightSpec: estimatedHeight)
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> numberOfExtraRightColumns [
	^ layoutProperties numberOfExtraRightColumns
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> numberOfVisibleColumns [
	^ layoutProperties numberOfVisibleColumns
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutState >> offsetChildrenByHorizontalOffset [
	"Horizontal offset is used to indicate scroll position."

	grid
		cellAtRow: 1
		column: self firstDisplayedColumn
		ifPresent: [ :aLayoutChildNode | 
			| globalOffsetX minX maxX |
			minX := minLeftChildNode bounds left - self horizontalCellSpacing.
			maxX := (maxRightChildNode bounds right + self horizontalCellSpacing) max: containerWidth.
			globalOffsetX := self horizontalOffset * containerWidth.
			globalOffsetX >= 0 
				ifTrue: [ maxX - globalOffsetX < containerWidth
					ifTrue: [ 
						globalOffsetX := maxX - containerWidth.
						globalOffsetX := (minX - globalOffsetX min: 0) max: globalOffsetX.
						layoutProperties horizontalOffset: (globalOffsetX / containerWidth) ] ] 
				ifFalse: [ minX - globalOffsetX > 0 
					ifTrue: [ 
						globalOffsetX := minX.
						layoutProperties horizontalOffset: (globalOffsetX / containerWidth) ] ].
			grid allChildrenNodesDo: [ :each | each offsetByX: globalOffsetX negated ] ]
		ifEmpty: [  ]
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutState >> offsetChildrenToTheFirstDisplayedColumn [
	grid
		cellAtRow: 1
		column: self firstDisplayedColumn
		ifPresent: [ :aLayoutChildNode | 
			| globalOffsetX maxX |
			globalOffsetX := aLayoutChildNode left - self horizontalCellSpacing.
			
			"Note: I'm not sure about the #numberOfExtraRightColumns condition.
			If we remove it, there might be an extra space to the right if visible columns
			occupy less width compared to the container width."
			self numberOfExtraRightColumns isZero ifTrue: [
				maxX := maxInitialRight + self horizontalCellSpacing.
				(maxX > containerWidth and: [ 
					maxX - globalOffsetX < containerWidth ]) 
						ifTrue: [
							globalOffsetX := maxX - containerWidth. ].
							
				maxX <= containerWidth ifTrue: [ globalOffsetX := 0 ] ].
			
			grid allChildrenNodesDo: [ :each | each offsetByX: globalOffsetX negated ] ]
		ifEmpty: [  ].
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> rowCount [
	<return: #BlHorizontalTreeFlowLayoutRowCount>
	^ layoutProperties rowCount
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> verticalCellSpacing [
	^ layoutProperties verticalCellSpacing
]

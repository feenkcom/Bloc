Class {
	#name : #BlHorizontalTreeFlowLayoutState,
	#superclass : #Object,
	#instVars : [
		'grid',
		'containerWidth',
		'containerHeight',
		'layoutProperties',
		'currentNumberOfRow'
	],
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutState >> calculateX: column numberOfColumns: numberOfColumns [
	^ ((column - 1) max: 0) * containerWidth * 1.0 / numberOfColumns
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutState >> calculateY: row numberOfRows: numberOfRows [
	| positionY totalAvailableHeight|
	
	totalAvailableHeight := containerHeight - ((numberOfRows + 1) * self cellSpacing).
	
	positionY := ((row - 1) max: 0) * totalAvailableHeight * 1.0 / numberOfRows.
	positionY := positionY + (row * self cellSpacing).
	
	^ positionY
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> cellSpacing [
	^ layoutProperties cellSpacing
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutState >> containerHeight: aNumber [
	containerHeight := aNumber
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutState >> containerWidth: aNumber [
	containerWidth := aNumber
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutState >> estimateHeightSpecOf: aLayoutChildNode numberOfRows: aNumberOfRows [
	<return: #BlMeasurementSpec>
	| totalAvailableHeight aPreferredChildHeight |

	totalAvailableHeight := containerHeight - ((aNumberOfRows + 1) * self cellSpacing).
	aPreferredChildHeight := totalAvailableHeight * 1.0 / aNumberOfRows.

	^ aLayoutChildNode parent heightSpec mode
		measurement: aLayoutChildNode verticalResizer
		with: (aPreferredChildHeight max: 0)
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutState >> estimateWidthSpecOf: aLayoutChildNode numberOfColumns: aNumberOfColumns [
	<return: #BlMeasurementSpec>
	| totalAvailableWidth aPreferredChildWidth |

	totalAvailableWidth := containerWidth - ((aNumberOfColumns + 1) * self cellSpacing).
	aPreferredChildWidth := totalAvailableWidth * 1.0 / aNumberOfColumns.

	^ aLayoutChildNode parent widthSpec mode
		measurement: aLayoutChildNode horizontalResizer
		with: (aPreferredChildWidth max: 0)
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> firstVisibleColumn [
	^ layoutProperties firstVisibleColumn
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> horizontalOffset [
	^ layoutProperties horizontalOffset
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutState >> measureAndPlaceChildren [
	| previousColumnRight |
	
	previousColumnRight := 0.
	
	1 to: grid numberOfColumns do: [ :column |
		| positionX numberOfRowsInColumn |
		
		positionX := previousColumnRight + self cellSpacing.
		
		numberOfRowsInColumn := grid numberOfRowsAtColumn: column.
		currentNumberOfRow := currentNumberOfRow max: numberOfRowsInColumn.
		
		1 to: grid numberOfRows do: [ :row |
			grid
				cellAtRow: row
				column: column
				ifPresent: [ :aLayoutChildNode |
					| eachChildX eachChildY |
					
					self
						measureChild: aLayoutChildNode
						numberOfRows: currentNumberOfRow
						numberOfColumns: self numberOfVisibleColumns.
					
					eachChildX := positionX.
					eachChildY := self calculateY: row numberOfRows: currentNumberOfRow.
					
					aLayoutChildNode position: eachChildX @ eachChildY.
					
					previousColumnRight := previousColumnRight max: aLayoutChildNode right ]
				ifEmpty: [  ] ] ].
	
	grid
		cellAtRow: 1
		column: self firstVisibleColumn
		ifPresent: [ :aLayoutChildNode |
			| globalOffsetX |
			
			globalOffsetX := aLayoutChildNode left - self cellSpacing.
			grid allChildrenNodesDo: [ :each |
				each offsetByX: globalOffsetX negated ] ]
		ifEmpty: [ ].
		
	grid
		cellAtRow: 1
		column: self firstVisibleColumn
		ifPresent: [ :aLayoutChildNode |
			| globalOffsetX |
			
			globalOffsetX := self horizontalOffset * containerWidth.
			grid allChildrenNodesDo: [ :each |
				each offsetByX: globalOffsetX negated ] ]
		ifEmpty: [ ]
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutState >> measureChild: aLayoutChildNode numberOfRows: numberOfRows numberOfColumns: numberOfColumns [
	| estimatedWidth estimatedHeight |
	estimatedWidth := self
		estimateWidthSpecOf: aLayoutChildNode
		numberOfColumns: numberOfColumns.
	estimatedHeight := self
		estimateHeightSpecOf: aLayoutChildNode
		numberOfRows: numberOfRows.

	aLayoutChildNode
		measure: (BlExtentMeasurementSpec new
				widthSpec: estimatedWidth;
				heightSpec: estimatedHeight).
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutState >> numberOfVisibleColumns [
	^ layoutProperties numberOfVisibleColumns
]

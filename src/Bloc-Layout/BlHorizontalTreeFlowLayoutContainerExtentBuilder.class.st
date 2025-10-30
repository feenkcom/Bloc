"
In case of unspecified container size, I try to estimate the container size based on its children.
"
Class {
	#name : #BlHorizontalTreeFlowLayoutContainerExtentBuilder,
	#superclass : #Object,
	#instVars : [
		'grid',
		'parentNode',
		'properties',
		'currentNumberOfRows',
		'maxWidth',
		'maxHeight',
		'maxHeightRows',
		'containerHeight',
		'containerWidth'
	],
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #building }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> build [
	self buildSpecified.

	(parentNode extentSpec widthSpec isUnspecified
		or: [ parentNode extentSpec heightSpec isUnspecified ])
		ifTrue: [ self buildUnspecified ]
]

{ #category : #building }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> buildSpecified [
	containerWidth := parentNode extentSpec widthSpec
			sizeFor: Float infinity.
	containerHeight := parentNode extentSpec heightSpec
			sizeFor: Float infinity.
]

{ #category : #building }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> buildUnspecified [
	maxWidth := 0.
	maxHeight := 0.
	maxHeightRows := 0.

	1
		to: grid numberOfColumns
		do: [ :column | 
			| cell |
			currentNumberOfRows := properties rowCount
					previousColumnRowCount: currentNumberOfRows
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
							| eachChildRow eachChildSpan |
							cell := cell + 1.

							self
								childNode: aLayoutChildNode
								ifUseful: [ eachChildRow := properties rowCount nodeRow: row cell: cell.
									eachChildSpan := properties rowCount nodeSpan: aLayoutChildNode.

									self
										measureChild: aLayoutChildNode
										numberOfRows: currentNumberOfRows
										numberOfColumns: properties numberOfVisibleColumns
										rowSpan: eachChildSpan.

									aLayoutChildNode width isInfinite
										ifFalse: [ maxWidth := maxWidth max: aLayoutChildNode width ].
									aLayoutChildNode height isInfinite
										ifFalse: [ | currentHeight |
											currentHeight := (aLayoutChildNode height
													+ properties verticalCellSpacing) * currentNumberOfRows
													+ properties verticalCellSpacing.
											maxHeight < currentHeight
												ifTrue: [ maxHeight := currentHeight.
													maxHeightRows := currentNumberOfRows ] ] ]
								ifNone: [  ] ]
						ifEmpty: [  ] ] ].

	parentNode extentSpec widthSpec isUnspecified
		ifTrue: [ maxWidth isZero
				ifFalse: [ containerWidth := (maxWidth + properties horizontalCellSpacing)
							* properties numberOfVisibleColumns + properties horizontalCellSpacing ]
				ifTrue: [ containerWidth := 50 ] ].

	parentNode extentSpec heightSpec isUnspecified
		ifTrue: [ maxHeight isZero
				ifFalse: [ containerHeight := maxHeight ]
				ifTrue: [ containerHeight := 50 ] ]
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> childNode: aLayoutChildNode ifUseful: aUsefulBlock ifNone: aNoneBlock [
	parentNode extentSpec widthSpec isUnspecified
		ifTrue: [ (aLayoutChildNode horizontalResizer isMatchParent
				or: [ aLayoutChildNode horizontalResizer isFitContentLimited ])
				ifFalse: [ ^ aUsefulBlock value ] ].

	parentNode extentSpec heightSpec isUnspecified
		ifTrue: [ (aLayoutChildNode verticalResizer isMatchParent
				or: [ aLayoutChildNode verticalResizer isFitContentLimited ])
				ifFalse: [ ^ aUsefulBlock value ] ].

	^ aNoneBlock value
]

{ #category : #'accessing - computed' }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> containerHeight [
	^ containerHeight ifNil: [ 50 ]
]

{ #category : #'accessing - computed' }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> containerWidth [
	^ containerWidth ifNil: [ 50 ]
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> estimateHeightSpecOf: aLayoutChildNode numberOfRows: aNumberOfRows rowSpan: rowSpan [
	<return: #BlMeasurementSpec>
	| totalAvailableHeight aPreferredChildHeight |

	totalAvailableHeight := containerHeight - ((aNumberOfRows + 1) * properties verticalCellSpacing).
	aPreferredChildHeight := totalAvailableHeight * 1.0 / aNumberOfRows.
	aPreferredChildHeight := aPreferredChildHeight * rowSpan + (rowSpan - 1 * properties verticalCellSpacing).

	^ aLayoutChildNode parent heightSpec mode
		measurement: aLayoutChildNode verticalResizer
		with: (aPreferredChildHeight max: 0)
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> estimateWidthSpecOf: aLayoutChildNode numberOfColumns: aNumberOfColumns [
	<return: #BlMeasurementSpec>
	| totalAvailableWidth aPreferredChildWidth |

	totalAvailableWidth := containerWidth - ((aNumberOfColumns + 1) * properties horizontalCellSpacing).
	aPreferredChildWidth := totalAvailableWidth * 1.0 / aNumberOfColumns.

	^ aLayoutChildNode parent widthSpec mode
		measurement: aLayoutChildNode horizontalResizer
		with: (aPreferredChildWidth max: 0)
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> grid [
	<return: #BlHorizontalTreeFlowLayoutGrid>
	^ grid
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> grid: aLayoutGrid [
	grid := aLayoutGrid.
	currentNumberOfRows := aLayoutGrid numberOfRowsAtColumn: 1
]

{ #category : #measure }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> measureChild: aLayoutChildNode numberOfRows: numberOfRows numberOfColumns: numberOfColumns rowSpan: rowSpan [
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
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> parentNode [
	<return: #BlLayoutParentNode>
	^ parentNode
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> parentNode: aLayoutParentNode [
	parentNode := aLayoutParentNode
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> properties [
	<return: #BlHorizontalTreeFlowLayoutProperties>
	^ properties
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutContainerExtentBuilder >> properties: aLayoutProperties [
	properties := aLayoutProperties
]

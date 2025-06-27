Class {
	#name : #BlHorizontalTreeFlowLayoutGrid,
	#superclass : #Object,
	#instVars : [
		'numberOfRows',
		'numberOfColumns',
		'grid',
		'childrenNodes'
	],
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #'instance creation' }
BlHorizontalTreeFlowLayoutGrid class >> fromLayoutNodes: childrenNodes [
	| grid maxRow maxColumn |
	
	maxRow := 0.
	maxColumn:= 0.
	
	grid := (AsyncSortedDictionary new: 2) sortByKeys: [ :a :b | a < b ].
	
	childrenNodes do: [ :eachNode |
		| eachColumn eachRow |

		eachColumn := eachNode constraints horizontalTreeFlow depth.
		eachRow := eachNode constraints horizontalTreeFlow row.
		maxRow := maxRow max: eachRow.
		maxColumn := maxColumn max: eachColumn.

		grid at: eachRow at: eachColumn put: eachNode ].

	^ (self new
		setGrid: grid
		numberOfRows: maxRow
		numberOfColumns: maxColumn)
			childrenNodes: childrenNodes;
			yourself
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutGrid >> allChildrenNodesDo: aBlock [
	childrenNodes do: aBlock
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutGrid >> anyCellInColumn: column ifPresent: aPresentBlock ifEmpty: anEmptyBlock [
	1 to: self numberOfRows do: [ :row |
		grid
			at: row
			at: column
			ifPresent:  [ :aValue | ^ aPresentBlock value: aValue ]
			ifAbsent: [ ] ].
	
	^ anEmptyBlock value
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutGrid >> cellAtRow: row column: column ifPresent: aPresentBlock ifEmpty: anEmptyBlock [
	^ grid
		at: row
		at: column
		ifPresent: aPresentBlock
		ifAbsent: anEmptyBlock
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutGrid >> childrenNodes [
	^ childrenNodes
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutGrid >> childrenNodes: anObject [
	childrenNodes := anObject
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutGrid >> numberOfCellsAtColumn: aColumn [
	| numberOfCellsAtColumn |
	
	numberOfCellsAtColumn := 0.
	1 to: self numberOfRows do: [ :row |
		grid
			at: row
			at: aColumn
			ifPresent: [ :aNode | numberOfCellsAtColumn := numberOfCellsAtColumn + 1 ]
			ifAbsent: [ ] ].
	^ numberOfCellsAtColumn
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutGrid >> numberOfColumns [
	^ numberOfColumns
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutGrid >> numberOfRows [
	^ numberOfRows
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutGrid >> numberOfRowsAtColumn: aColumn [
	| numberOfRowsAtColumn |
	
	numberOfRowsAtColumn := 0.
	1 to: self numberOfRows do: [ :row |
		grid
			at: row
			at: aColumn
			ifPresent: [ :aNode | numberOfRowsAtColumn := numberOfRowsAtColumn
							max: aNode constraints horizontalTreeFlow row ]
			ifAbsent: [ ] ].
	^ numberOfRowsAtColumn
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutGrid >> setGrid: aDictionary numberOfRows: aNumberOfRows numberOfColumns: aNumberOfColumns [
	grid := aDictionary.
	numberOfRows := aNumberOfRows.
	numberOfColumns := aNumberOfColumns
]

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

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutGrid >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Grid';
		priority: 5;
		stencil: [
			| aGridElement |
			
			aGridElement := BrVerticalPane new
				matchParent;
				cellSpacing: 20.
			
			1 to: numberOfRows do: [ :row |
				| currentRow |
				
				currentRow := BrHorizontalPane new
					matchParent;
					cellSpacing: 20.
				
				1 to: numberOfColumns do: [ :column |
					| eachCell |
					eachCell := grid
						at: row
						at: column
						ifPresent: [ :aNode |
							BrFrame new
								matchParent;
								background: Color veryVeryLightGray;
								when: BlClickEvent do: [ :anEvent |
									anEvent currentTarget phlow spawnObject: aNode
								] ]
						ifAbsent: [
							BrFrame new
								matchParent;
								background: Color white ].
								
					currentRow addChild: eachCell ].
				
				aGridElement addChild: currentRow ].
			
			aGridElement
			
		]
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutGrid >> numberOfColumns [
	^ numberOfColumns
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutGrid >> numberOfRows [
	^ numberOfRows
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutGrid >> numberOfRowsAtColumn: aColumn [
	| numberOfRowsAtColumn |
	
	numberOfRowsAtColumn := 0.
	1 to: self numberOfRows do: [ :row |
		grid
			at: row
			at: aColumn
			ifPresent: [ :_ | numberOfRowsAtColumn := numberOfRowsAtColumn + 1 ]
			ifAbsent: [ ] ].
	^ numberOfRowsAtColumn
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutGrid >> setGrid: aDictionary numberOfRows: aNumberOfRows numberOfColumns: aNumberOfColumns [
	grid := aDictionary.
	numberOfRows := aNumberOfRows.
	numberOfColumns := aNumberOfColumns
]

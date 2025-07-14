Class {
	#name : #BlHorizontalTreeFlowLayoutRowGrowingCount,
	#superclass : #BlHorizontalTreeFlowLayoutRowCount,
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #visiting }
BlHorizontalTreeFlowLayoutRowGrowingCount >> acceptVisitor: aVisitor [
	^ aVisitor visitBlHorizontalTreeFlowLayoutRowGrowingCount: self
]

{ #category : #computing }
BlHorizontalTreeFlowLayoutRowGrowingCount >> nodeRow: row cell: cell [
	^ row
]

{ #category : #computing }
BlHorizontalTreeFlowLayoutRowGrowingCount >> previousColumnRowCount: previousRowCount grid: grid column: columnIndex [
	| numberOfRowsInColumn |
	numberOfRowsInColumn := grid numberOfRowsAtColumn: columnIndex.
	^ previousRowCount max: numberOfRowsInColumn
]

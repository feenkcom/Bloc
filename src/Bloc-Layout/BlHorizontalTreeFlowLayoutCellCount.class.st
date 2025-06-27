Class {
	#name : #BlHorizontalTreeFlowLayoutCellCount,
	#superclass : #BlHorizontalTreeFlowLayoutRowCount,
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #computing }
BlHorizontalTreeFlowLayoutCellCount >> nodeRow: row cell: cell [
	^ cell
]

{ #category : #computing }
BlHorizontalTreeFlowLayoutCellCount >> previousColumnRowCount: previousRowCount grid: grid column: columnIndex [
	^ grid numberOfCellsAtColumn: columnIndex
]

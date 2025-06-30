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
BlHorizontalTreeFlowLayoutCellCount >> nodeSpan: aLayoutChildNode [
	"Return how many rows a given child node should occupy."

	<return: #Integer>
	^ 1
]

{ #category : #computing }
BlHorizontalTreeFlowLayoutCellCount >> previousColumnRowCount: previousRowCount grid: grid column: columnIndex [
	^ grid numberOfCellsAtColumn: columnIndex
]

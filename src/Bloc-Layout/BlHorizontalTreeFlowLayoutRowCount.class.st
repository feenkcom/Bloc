Class {
	#name : #BlHorizontalTreeFlowLayoutRowCount,
	#superclass : #Object,
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #computing }
BlHorizontalTreeFlowLayoutRowCount >> nodeRow: row cell: cell [
	"Return child node index in a given column."

	<return: #Integer>
	^ self subclassResponsibility
]

{ #category : #computing }
BlHorizontalTreeFlowLayoutRowCount >> previousColumnRowCount: previousRowCount grid: grid column: columnIndex [
	"Return number of rows in the given column"

	<return: #Integer>
	^ self subclassResponsibility
]

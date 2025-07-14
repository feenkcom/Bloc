Class {
	#name : #BlHorizontalTreeFlowLayoutRowCount,
	#superclass : #Object,
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #visiting }
BlHorizontalTreeFlowLayoutRowCount >> acceptVisitor: aVisitor [
	^ aVisitor visitBlHorizontalTreeFlowLayoutRowCount: self
]

{ #category : #computing }
BlHorizontalTreeFlowLayoutRowCount >> nodeRow: row cell: cell [
	"Return child node index in a given column."

	<return: #Integer>
	^ self subclassResponsibility
]

{ #category : #computing }
BlHorizontalTreeFlowLayoutRowCount >> nodeSpan: aLayoutChildNode [
	"Return how many rows a given child node should occupy."

	<return: #Integer>
	^ aLayoutChildNode constraints horizontalTreeFlow span
]

{ #category : #computing }
BlHorizontalTreeFlowLayoutRowCount >> previousColumnRowCount: previousRowCount grid: grid column: columnIndex [
	"Return number of rows in the given column"

	<return: #Integer>
	^ self subclassResponsibility
]

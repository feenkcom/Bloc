Class {
	#name : #BlHorizontalTreeFlowLayoutAllVisibleColumnsCount,
	#superclass : #BlHorizontalTreeFlowLayoutVisibleColumnsCount,
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #'api - accessing' }
BlHorizontalTreeFlowLayoutAllVisibleColumnsCount >> numberOfVisibleColumnsForGrid: grid [
	^ grid numberOfColumns
]

Class {
	#name : #BlHorizontalTreeFlowLayoutProperties,
	#superclass : #Object,
	#instVars : [
		'numberOfVisibleColumns',
		'cellSpacing',
		'firstVisibleColumn',
		'horizontalOffset',
		'rowCount'
	],
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> cellSpacing [
	^ cellSpacing
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> cellSpacing: anObject [
	cellSpacing := anObject
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> firstVisibleColumn [
	^ firstVisibleColumn
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> firstVisibleColumn: anObject [
	firstVisibleColumn := anObject
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> horizontalOffset [
	^ horizontalOffset
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> horizontalOffset: anObject [
	horizontalOffset := anObject
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutProperties >> initialize [
	super initialize.

	numberOfVisibleColumns := BlHorizontalTreeFlowLayoutExplicitVisibleColumnsCount
			new count: 2.
	cellSpacing := 0.
	firstVisibleColumn := 1.
	horizontalOffset := 0.
	rowCount := BlHorizontalTreeFlowLayoutRowGrowingCount new
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> numberOfVisibleColumns [
	<return: #BlHorizontalTreeFlowLayoutVisibleColumnsCount>
	^ numberOfVisibleColumns
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> numberOfVisibleColumns: anObject [
	numberOfVisibleColumns := anObject
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> rowCount [
	<return: #BlHorizontalTreeFlowLayoutRowCount>
	^ rowCount
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> rowCount: anObject [
	rowCount := anObject
]

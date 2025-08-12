Class {
	#name : #BlHorizontalTreeFlowLayoutProperties,
	#superclass : #Object,
	#instVars : [
		'numberOfVisibleColumns',
		'cellSpacing',
		'firstVisibleColumn',
		'horizontalOffset',
		'rowCount',
		'horizontalCellSpacing',
		'verticalCellSpacing'
	],
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> cellSpacing [
	"Deprecated. Use either #horizontalCellSpacing or #verticalCellSpacing"

	^ cellSpacing
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> cellSpacing: aNumber [
	"Set both #horizontalCellSpacing: and #verticalCellSpacing:"

	cellSpacing := aNumber max: 0.
	self horizontalCellSpacing: aNumber.
	self verticalCellSpacing: aNumber
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> firstVisibleColumn [
	^ firstVisibleColumn
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> firstVisibleColumn: anObject [
	firstVisibleColumn := anObject max: 1
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> horizontalCellSpacing [
	^ horizontalCellSpacing ifNil: [ cellSpacing ]
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> horizontalCellSpacing: aNumber [
	horizontalCellSpacing := aNumber max: 0
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

	numberOfVisibleColumns := 2.
	cellSpacing := 0.
	horizontalCellSpacing := 0.
	verticalCellSpacing := 0.
	firstVisibleColumn := 1.
	horizontalOffset := 0.
	rowCount := BlHorizontalTreeFlowLayoutRowGrowingCount new
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> numberOfVisibleColumns [
	<return: #Integer>
	^ numberOfVisibleColumns
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> numberOfVisibleColumns: anInteger [
	numberOfVisibleColumns := anInteger max: 1
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

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> verticalCellSpacing [
	^ verticalCellSpacing ifNil: [ cellSpacing ]
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> verticalCellSpacing: aNumber [
	verticalCellSpacing := aNumber max: 0
]

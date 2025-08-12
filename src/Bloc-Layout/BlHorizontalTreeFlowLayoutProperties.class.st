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
	<return: #Point>
	^ self horizontalCellSpacing @ self verticalCellSpacing
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> cellSpacing: aNumberOrPoint [
	"Set both #horizontalCellSpacing: and #verticalCellSpacing:"

	| aPoint |
	aPoint := aNumberOrPoint asPoint.
	self horizontalCellSpacing: aPoint x.
	self verticalCellSpacing: aPoint y
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
	<return: #Number>
	^ horizontalCellSpacing ifNil: [ 0 ]
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> horizontalCellSpacing: aNumber [
	horizontalCellSpacing := (aNumber max: 0) asFloat
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> horizontalOffset [
	^ horizontalOffset
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> horizontalOffset: aNumber [
	horizontalOffset := aNumber asFloat
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutProperties >> initialize [
	super initialize.

	numberOfVisibleColumns := 2.
	horizontalCellSpacing := 0.0.
	verticalCellSpacing := 0.0.
	firstVisibleColumn := 1.
	horizontalOffset := 0.0.
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
	<return: #Number>
	^ verticalCellSpacing ifNil: [ 0 ]
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> verticalCellSpacing: aNumber [
	verticalCellSpacing := (aNumber max: 0) asFloat
]

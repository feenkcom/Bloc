Class {
	#name : #BlHorizontalTreeFlowLayoutProperties,
	#superclass : #Object,
	#instVars : [
		'numberOfVisibleColumns',
		'cellSpacing',
		'firstVisibleColumn',
		'horizontalOffset'
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
	
	numberOfVisibleColumns := 2.
	cellSpacing := 0.
	firstVisibleColumn := 0.
	horizontalOffset := 0
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> numberOfVisibleColumns [
	^ numberOfVisibleColumns
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutProperties >> numberOfVisibleColumns: anObject [
	numberOfVisibleColumns := anObject
]

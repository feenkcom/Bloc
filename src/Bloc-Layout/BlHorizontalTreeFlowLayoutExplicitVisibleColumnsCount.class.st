Class {
	#name : #BlHorizontalTreeFlowLayoutExplicitVisibleColumnsCount,
	#superclass : #BlHorizontalTreeFlowLayoutVisibleColumnsCount,
	#instVars : [
		'count'
	],
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #'api - initialization' }
BlHorizontalTreeFlowLayoutExplicitVisibleColumnsCount >> count: aNumber [
	count := aNumber
]

{ #category : #'api - accessing' }
BlHorizontalTreeFlowLayoutExplicitVisibleColumnsCount >> numberOfVisibleColumnsForGrid: grid [
	^ count
]

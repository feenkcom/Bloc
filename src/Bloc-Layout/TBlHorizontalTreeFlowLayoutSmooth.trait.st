Trait {
	#name : #TBlHorizontalTreeFlowLayoutSmooth,
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #'api - scrolling' }
TBlHorizontalTreeFlowLayoutSmooth >> scrollToColumn: aColumn [
	self assert: [ self layout isKindOf: BlHorizontalTreeFlowLayout ].

	self layout scrollToColumn: aColumn in: self
]

{ #category : #'api - smoothing' }
TBlHorizontalTreeFlowLayoutSmooth >> smoothNumberOfVisibleColumns: aColumnsCount [
	self assert: [ self layout isKindOf: BlHorizontalTreeFlowLayout ].

	self layout smoothNumberOfVisibleColumns: aColumnsCount in: self
]

{ #category : #'api - scrolling' }
TBlHorizontalTreeFlowLayoutSmooth >> smoothScrollToColumn: aColumn [
	self assert: [ self layout isKindOf: BlHorizontalTreeFlowLayout ].

	self layout smoothScrollToColumn: aColumn in: self
]

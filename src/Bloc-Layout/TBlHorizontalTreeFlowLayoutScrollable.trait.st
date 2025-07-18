Trait {
	#name : #TBlHorizontalTreeFlowLayoutScrollable,
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #'api - scrolling' }
TBlHorizontalTreeFlowLayoutScrollable >> scrollToColumn: aColumn [
	self assert: [ self layout isKindOf: BlHorizontalTreeFlowLayout ].

	self layout scrollToColumn: aColumn in: self
]

{ #category : #'api - scrolling' }
TBlHorizontalTreeFlowLayoutScrollable >> smoothScrollToColumn: aColumn [
	self assert: [ self layout isKindOf: BlHorizontalTreeFlowLayout ].

	self layout smoothScrollToColumn: aColumn in: self
]

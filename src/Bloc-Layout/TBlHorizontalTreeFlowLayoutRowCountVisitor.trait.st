Trait {
	#name : #TBlHorizontalTreeFlowLayoutRowCountVisitor,
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #visiting }
TBlHorizontalTreeFlowLayoutRowCountVisitor >> visitBlHorizontalTreeFlowLayoutCellCount: aCount [
	self visitBlHorizontalTreeFlowLayoutRowCount: aCount
]

{ #category : #visiting }
TBlHorizontalTreeFlowLayoutRowCountVisitor >> visitBlHorizontalTreeFlowLayoutRowCount: aCount [
	
]

{ #category : #visiting }
TBlHorizontalTreeFlowLayoutRowCountVisitor >> visitBlHorizontalTreeFlowLayoutRowGrowingCount: aCount [
	self visitBlHorizontalTreeFlowLayoutRowCount: aCount
]

{ #category : #visiting }
TBlHorizontalTreeFlowLayoutRowCountVisitor >> visitLayoutRowCount: aCount [
	"Visitors start their visits using this method"

	^ aCount acceptVisitor: self
]

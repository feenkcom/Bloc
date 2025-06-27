Extension { #name : #BlHorizontalTreeFlowLayoutGrid }

{ #category : #'*Bloc-Extensions' }
BlHorizontalTreeFlowLayoutGrid >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Grid';
		priority: 5;
		stencil: [
			| aGridElement |
			
			aGridElement := BrVerticalPane new
				matchParent;
				cellSpacing: 20.
			
			1 to: numberOfRows do: [ :row |
				| currentRow |
				
				currentRow := BrHorizontalPane new
					matchParent;
					cellSpacing: 20.
				
				1 to: numberOfColumns do: [ :column |
					| eachCell |
					eachCell := grid
						at: row
						at: column
						ifPresent: [ :aNode |
							BrFrame new
								matchParent;
								background: Color veryVeryLightGray;
								when: BlClickEvent do: [ :anEvent |
									anEvent currentTarget phlow spawnObject: aNode
								] ]
						ifAbsent: [
							BrFrame new
								matchParent;
								background: Color white ].
								
					currentRow addChild: eachCell ].
				
				aGridElement addChild: currentRow ].
			
			aGridElement
			
		]
]

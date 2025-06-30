Extension { #name : #BlHorizontalTreeFlowLayoutGrid }

{ #category : #'*Bloc-Extensions' }
BlHorizontalTreeFlowLayoutGrid >> gtChildrenNodesFor: aView [
	<gtView>
	childrenNodes ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Children nodes';
		object: [ childrenNodes ];
		view: #gtChildrenFor:
]

{ #category : #'*Bloc-Extensions' }
BlHorizontalTreeFlowLayoutGrid >> gtOverview [
	^ Array
		streamContents: [ :aStream | 
			aStream
				nextPut: (GtPhlowOverviewItem new
						name: 'Number of columns';
						value: self numberOfColumns).
			aStream
				nextPut: (GtPhlowOverviewItem new
						name: 'Number of rows';
						value: self numberOfRows).
			1
				to: self numberOfColumns
				do: [ :eachIndex | 
					aStream
						nextPut: (GtPhlowOverviewItem new
								name: 'Number of rows at column ' , eachIndex asString;
								value: (self numberOfRowsAtColumn: eachIndex)) ].

			1
				to: self numberOfColumns
				do: [ :eachIndex | 
					aStream
						nextPut: (GtPhlowOverviewItem new
								name: 'Number of cells at column ' , eachIndex asString;
								value: (self numberOfCellsAtColumn: eachIndex)) ] ]
]

{ #category : #'*Bloc-Extensions' }
BlHorizontalTreeFlowLayoutGrid >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		items: [ self gtOverview ];
		column: 'Name' text: #name;
		column: 'Description' text: #description;
		send: #value
]

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

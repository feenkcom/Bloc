Extension { #name : #BlLayoutParentNode }

{ #category : #'*Bloc-Extensions' }
BlLayoutParentNode >> gtPreviewWithContourFor: aView [
	<gtView>

	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [
			| theNodes theEdges |
			
			theNodes := (self children collect: [ :eachChildNode |
				| aNodeElement |
				
				aNodeElement := BlElement new
					background: (Color gray alpha: 0.4);
					border: (BlBorder paint: Color gray width: 1);
					relocate: eachChildNode layoutBounds origin;
					size: eachChildNode layoutBounds extent.
					
				eachChildNode userData
					at: #label
					ifPresent: [ :aLabel |
						| aLabelElement |
						
						aLabelElement := BlTextElement new.
						aLabelElement text: aLabel asRopedText glamorousCodeFontAndSmallSize.
						aLabelElement constraintsDo: [ :c |
							c ignoreByLayout.
							c ignored horizontal alignCenter.
							c ignored vertical alignCenter ].
						
						aNodeElement addChild: aLabelElement ].
				
				eachChildNode transformationDo: [ :t | aNodeElement transformation: t ].
				
				eachChildNode -> aNodeElement ]) asOrderedDictionary.

			theEdges := self children flatCollect: [ :eachChildNode |
				(eachChildNode isKindOf: BlLayoutChildNodeWithEdges)
					ifTrue: [
						eachChildNode connectedEdges collect: [ :eachEdge |
							BlLineElement  new
								zIndex: 10;
								border: (BlBorder paint: (Color gray alpha: 0.8) width: 1);
								fromAnchor: (BlElementCenterAnchor element: (theNodes at: eachEdge fromNode));
								toAnchor: (BlElementCenterAnchor element: (theNodes at: eachEdge toNode));
								toHead: (BlArrowheadSimpleArrow new
									arrowLengthFraction: 7;
									border: (BlBorder builder paint: (Color gray alpha: 0.8); width: 1; build))
						]
					]
					ifFalse: [ #() ]
			].
			
			BlElement new
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ];
				"addChildren: theNodesTransformed;"
				addChildren: theNodes values;
				addChildren: theEdges ]
]

Extension { #name : #BlSteppedLayoutAreaBuilder }

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutAreaBuilder class >> gtAreaBuildersFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Area builders';
		priority: 15;
		items: [ ((self classSide methodsInProtocol: 'factory')
				collect: [ :each | each -> (each methodClass instanceSide perform: each selector) ])
				sort: [ :a :b | a key selector < b key selector ] ];
		column: 'Index'
			text: [ :_ :index | index asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
			width: 40;
		column: 'Selector' text: [ :each | each key selector ] weight: 1.5;
		column: 'Preview'
			stencil: [ :each | (each value gtPreviewForExtent: 100 @ 20) padding: (BlInsets all: 1) ];
		column: 'Direction'
			text: [ :each | (each value gtPreviewAreaForExtent: 100 @ 20) direction ]
			width: 65;
		column: 'Mark'
			text: [ :each | (each value gtPreviewAreaForExtent: 100 @ 20) mark ];
		column: 'Horizontal alignment'
			text: [ :each | (each value gtPreviewAreaForExtent: 100 @ 20) horizontalAlignment ]
			weight: 1.5;
		column: 'Vertical alignment'
			text: [ :each | (each value gtPreviewAreaForExtent: 100 @ 20) verticalAlignment ]
			weight: 1.5;
		contextItemLabel: 'Browse area builder'
			action: [ :anElement :anAssoc | anElement phlow spawnObject: anAssoc value ];
		contextItemLabel: 'Browse preview area'
			action: [ :anElement :anAssoc | anElement phlow spawnObject: (anAssoc value gtPreviewAreaForExtent: 100 @ 20) ];
		contextItemLabel: 'Browse defining method'
			action: [ :anElement :anAssoc | anElement phlow spawnTool: (GtMethodCoderTool compiledMethod: anAssoc key) ];
		contextItemLabel: 'Copy defining method'
			action: [ :anElement :anAssoc | 
				Clipboard default
					clipboardText: ('{1} {2}.'
							format: {anAssoc key methodClass instanceSide.
									anAssoc key selector}) ];
		send: [ :each | each value ]
]

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutAreaBuilder >> gtPreviewAreaForExtent: anExtent [
	| aLayout aState |
	aLayout := BlSteppedLayout new
			anchorBounds: (anExtent // 2 - (5 @ 5) extent: 10 @ 10).
	aState := aLayout
			createStateFor: (BlLayoutParentNode new
					constraints: BlLayoutCommonConstraints new;
					extentSpec: (BlExtentMeasurementSpec atMost: anExtent)).
	^ self buildFor: aState
]

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutAreaBuilder >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		stencil: [ (self gtPreviewForExtent: 400 @ 300) padding: (BlInsets all: 10) ]
]

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutAreaBuilder >> gtPreviewForExtent: anExtent [
	| anAnchorLength aLayout aState anArea aChildNode |
	anAnchorLength := anExtent min < 30
			ifTrue: [ anExtent min // 3 max: 1 ]
			ifFalse: [ 10 ].
	aLayout := BlSteppedLayout new
			anchorBounds: (anExtent // 2 - (anAnchorLength @ anAnchorLength // 2)
					extent: anAnchorLength @ anAnchorLength).
	aState := aLayout
			createStateFor: (BlLayoutParentNode new
					constraints: BlLayoutCommonConstraints new;
					extentSpec: (BlExtentMeasurementSpec atMost: anExtent)).
	anArea := self buildFor: aState.
	aChildNode := BlLayoutChildNode new
			constraints: BlLayoutCommonConstraints new;
			measurement: (BlLayoutNodeComputedMeasurement new
					position: 0 @ 0;
					extent: anAnchorLength @ anAnchorLength).
	aState measureAndPlaceChild: aChildNode.

	^ BrHorizontalPane new
		fitContent;
		addChild: (BlElement new
				size: anExtent;
				border: (BlBorder paint: BrGlamorousColors disabledButtonTextColor width: 1);
				addChild: (BlElement new
						id: #anchorBounds;
						relocate: aLayout anchorBounds origin;
						size: aLayout anchorBounds extent;
						background: (BrGlamorousColors errorBackgroundColor alpha: 0.4);
						border: (BlBorder paint: (BrGlamorousColors errorBorderColor alpha: 0.4) width: 1));
				addChild: (BlElement new
						layout: BlFrameLayout new;
						id: #area;
						size: anArea bounds extent;
						relocate: anArea bounds origin;
						background: (BrGlamorousColors selectedListItemColor alpha: 0.4);
						border: (BlBorder paint: (BrGlamorousColors hoveredButtonBorderColor alpha: 0.4));
						addChild: (BlElement new
								id: #alignment;
								size: anAnchorLength @ anAnchorLength;
								constraintsDo: [ :c | 
									c frame horizontal alignment: anArea horizontalAlignment.
									c frame vertical alignment: anArea verticalAlignment ];
								background: (BrGlamorousColors selectedListItemColor alpha: 0.4);
								border: (BlBorder paint: (BrGlamorousColors hoveredButtonBorderColor alpha: 0.4)))))
]

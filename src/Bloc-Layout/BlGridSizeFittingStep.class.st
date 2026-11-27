"
One actual feasibility decision in a grid size fitting computation. Records the search interval before testing, candidate scale and sizes, and feasibility. Selection is separate from feasibility.
"
Class {
	#name : #BlGridSizeFittingStep,
	#superclass : #Object,
	#instVars : [
		'scale',
		'sizes',
		'lower',
		'upper',
		'feasible',
		'phase',
		'algorithm',
		'evaluation'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #accessing }
BlGridSizeFittingStep >> algorithm [
	"The fitting computation that created this candidate."

	^ algorithm
]

{ #category : #accessing }
BlGridSizeFittingStep >> algorithm: aSizeFitting [
	algorithm := aSizeFitting
]

{ #category : #presentation }
BlGridSizeFittingStep >> allocationDiagramWithMaximum: maximum selected: selected [
	| canvas factor height capacity |
	factor := 600 / maximum.
	height := self diagramHeight.
	canvas := BlElement new size: 660 @ (height + 18).
	capacity := algorithm availableSpace.
	capacity
		ifNotNil: [ canvas
				addChild: (BlElement new
						relocate: 4 @ 20;
						size: (capacity * factor max: 0.5) @ (height - 4);
						background: BrAntColors gray4) ].
	sizes
		withIndexDo: [ :size :index | 
			| offset child |
			offset := algorithm childOffsetAt: index in: self.
			child := self
					childElementAt: index
					offset: offset
					factor: factor.
			child relocate: (4 + (offset * factor)) @ (algorithm childYAt: index).
			canvas addChild: child.
			(algorithm childMargins at: index) > 0
				ifTrue: [ canvas
						addChild: (self
								marginElementAt: index
								offset: offset
								factor: factor) ] ].
	capacity
		ifNotNil: [ canvas addChild: (self capacityLabelWithMaximum: maximum) ].
	^ canvas
]

{ #category : #presentation }
BlGridSizeFittingStep >> asElementWithMaximum: maximum selected: selected [
	| pane row diagram solverDiagram marker |
	pane := BrVerticalPane new
			fitContent;
			margin: (BlInsets all: 1).
	row := BrHorizontalPane new fitContent.
	solverDiagram := algorithm
			solverDiagramFor: self
			maximum: maximum
			selected: selected.
	marker := selected
			ifTrue: [ (BrGlamorousVectorIcons accept asElement
					size: 16 @ 16;
					background: BrAntColors blue) asScalableElement
					scaleStrategy: (BlScalableFixedStrategy zoom: 2);
					size: 32 @ 32 ]
			ifFalse: [ BlElement new size: 32 @ 32 ].
	marker
		margin: (BlInsets
				top: 0
				left: 0
				bottom: 18
				right: 4).
	marker constraintsDo: [ :c | c linear vertical alignCenter ].
	row addChild: marker.
	row addChild: self searchBoundsLabelsElement.
	row addChild: self searchBoundsElement.
	diagram := solverDiagram
			ifNil: [ self allocationDiagramWithMaximum: maximum selected: selected ].
	diagram margin: (BlInsets bottom: 18).
	row addChild: diagram.
	pane addChild: row.
	pane
		when: BlClickEvent
		do: [ :event | 
			event consumed: true.
			pane phlow spawnObject: self ].
	^ pane
]

{ #category : #presentation }
BlGridSizeFittingStep >> asTooltipElement [
	| pane lines offset |
	lines := (self descriptionForSelected: self == algorithm selectedStep) lines
			asOrderedCollection.
	lines := lines reject: [ :line | line beginsWith: 'Child ' ].
	lines
		addFirst: 'Solver: ' , (feasible ifTrue: [ 'feasible' ] ifFalse: [ 'infeasible' ])
				, ' | search interval before attempt: [' , lower printString , ', '
				, upper printString , ']'.
	lines
		add: 'Left vertical ruler: scale 0 at bottom, 1 at top; matches parent height.'.
	lines
		add: 'Black triangles: lower points up, upper points down. Larger: moved since the previous attempt.'.
	lines
		add: 'Blue: this decision finishes the search; no representable midpoint remains after updating the bounds. Marker positions show the interval before the decision.'.
	pane := algorithm tooltipElementTitled: 'Fitting attempt' lines: lines.
	offset := 0.
	sizes
		withIndexDo: [ :size :index | 
			algorithm isSequential ifFalse: [ offset := 0 ].
			pane addChild: (self tooltipElementForChildAt: index offset: offset).
			offset := offset + size + (algorithm childMargins at: index) ].
	^ pane
]

{ #category : #accessing }
BlGridSizeFittingStep >> attemptedSpace [
	^ sizes sum + algorithm childMargins sum
]

{ #category : #presentation }
BlGridSizeFittingStep >> capacityLabelWithMaximum: maximum [
	"Keep the label inside the canvas so clipping cannot hide it."

	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
				glamorousRegularSmallSize;
				foreground: BrAntColors gray5);
		text: algorithm availableSpace printString;
		size: (algorithm availableSpace * 600 / maximum max: 0.5) @ 18;
		alignCenter;
		relocate: 4 @ 2;
		preventMouseEvents
]

{ #category : #presentation }
BlGridSizeFittingStep >> childAt: index fitsFrom: offset [
	"Containment includes the complete occupied interval, including combined margins/spacing. Not a replacement for span solver feasibility."

	^ algorithm availableSpace
		ifNil: [ nil ]
		ifNotNil: [ :capacity | 
			offset >= 0
				and: [ offset + (sizes at: index) + (algorithm childMargins at: index) <= capacity ] ]
]

{ #category : #presentation }
BlGridSizeFittingStep >> childElementAt: index offset: offset factor: factor [
	| child fits |
	fits := self childAt: index fitsFrom: offset.
	child := BlElement new
			layout: BlFrameLayout new;
			size: ((sizes at: index) * factor max: 0.5) @ 20;
			background: (fits
					ifNil: [ Color gray ]
					ifNotNil: [ fits ifTrue: [ BrAntColors green3 ] ifFalse: [ BrAntColors red3 ] ]);
			geometry: ((self isChildRigidAt: index)
					ifTrue: [ BlRectangleGeometry new ]
					ifFalse: [ BlRoundedRectangleGeometry cornerRadius: 6 ]);
			border: (BlBorder
					paint: (fits
							ifNil: [ Color gray ]
							ifNotNil: [ fits ifTrue: [ BrAntColors green5 ] ifFalse: [ BrAntColors red5 ] ])
					width: 2);
			clipChildren: true.
	child
		addChild: (BlShrinkingTextElement new
				text: ((sizes at: index) printString asRopedText fontSize: 9);
				preventMouseEvents;
				constraintsDo: [ :c | 
					c horizontal fitContentLimited.
					c vertical fitContent.
					c frame horizontal alignCenter.
					c frame vertical alignCenter ]).
	^ child
]

{ #category : #presentation }
BlGridSizeFittingStep >> descriptionForSelected: selected [
	^ String
		streamContents: [ :stream | 
			stream
				nextPutAll: phase asString;
				nextPutAll: ' / ';
				nextPutAll: (selected
						ifTrue: [ 'selected' ]
						ifFalse: [ feasible ifTrue: [ 'feasible' ] ifFalse: [ 'infeasible' ] ]);
				nextPutAll: ' / scale ';
				print: scale.
			algorithm availableSpace
				ifNotNil: [ :capacity | 
					stream
						cr;
						nextPutAll: 'Capacity: ';
						print: capacity.
					algorithm isSequential
						ifTrue: [ stream
								nextPutAll: ' | attempted (including margins): ';
								print: self attemptedSpace;
								nextPutAll: ' | remaining: ';
								print: capacity - self attemptedSpace ]
						ifFalse: [ stream
								cr;
								nextPutAll: 'Separate requirement lanes, not solved placements. Border colors compare with whole-axis bounds, not span feasibility.' ] ].
			sizes
				withIndexDo: [ :size :index | 
					stream
						cr;
						nextPutAll: 'Child ';
						print: index;
						nextPutAll: ((algorithm limited at: index) ifTrue: [ ' limited: ' ] ifFalse: [ ' fixed: ' ]);
						print: size;
						nextPutAll: ' / minimum: ';
						print: (algorithm minimumSizes at: index) ] ]
]

{ #category : #presentation }
BlGridSizeFittingStep >> diagramHeight [
	^ algorithm diagramHeightFor: self
]

{ #category : #accessing }
BlGridSizeFittingStep >> evaluation [
	^ evaluation
]

{ #category : #accessing }
BlGridSizeFittingStep >> evaluation: anEvaluation [
	evaluation := anEvaluation
]

{ #category : #accessing }
BlGridSizeFittingStep >> feasible [
	^ feasible
]

{ #category : #'gt-views' }
BlGridSizeFittingStep >> gtAttemptFor: aView [
	"How does this candidate compare with capacity? Uses the algorithm-wide scale so attempts remain comparable. Zoom to inspect minimum markers and overflow."

	<gtView>
	algorithm ifNil: [ ^ aView empty ].
	^ aView canvassable
		title: 'Attempt';
		priority: 0;
		stencil: [ self
				asElementWithMaximum: algorithm figureMaximum
				selected: self == algorithm selectedStep ]
]

{ #category : #'gt-views' }
BlGridSizeFittingStep >> gtSizesFor: aView [
	"What child sizes were actually passed to the constraint solver in this attempt?"

	<gtView>
	^ aView columnedList
		title: 'Candidate sizes';
		priority: 1;
		items: [ 1 to: sizes size ];
		column: 'Child' text: #yourself;
		column: 'Size' text: [ :index | sizes at: index ]
]

{ #category : #presentation }
BlGridSizeFittingStep >> hasSearchBoundChanged: aSelector [
	"First attempt is regular. Each bound compares independently with the immediately preceding attempt."

	| index previous |
	index := algorithm steps identityIndexOf: self.
	index <= 1 ifTrue: [ ^ false ].
	previous := algorithm steps at: index - 1.
	^ (self perform: aSelector) ~= (previous perform: aSelector)
]

{ #category : #presentation }
BlGridSizeFittingStep >> isChildRigidAt: index [
	^ (algorithm limited at: index) not
		or: [ (sizes at: index) <= (algorithm minimumSizes at: index) ]
]

{ #category : #accessing }
BlGridSizeFittingStep >> lower [
	^ lower
]

{ #category : #presentation }
BlGridSizeFittingStep >> marginElementAt: index offset: offset factor: factor [
	"Combined leading/trailing margins and spacing are shown after content for this additive diagram, not as actual child placement."

	| fits |
	fits := self childAt: index fitsFrom: offset.
	^ BlElement new
		relocate: (4 + ((offset + (sizes at: index)) * factor)) @ (algorithm childYAt: index);
		size: ((algorithm childMargins at: index) * factor max: 0.5) @ 20;
		background: BrAntColors gray3;
		border: (BlBorder
				paint: (fits
						ifNil: [ BrAntColors gray5 ]
						ifNotNil: [ fits ifTrue: [ BrAntColors green6 ] ifFalse: [ BrAntColors red6 ] ])
				width: 1)
]

{ #category : #presentation }
BlGridSizeFittingStep >> movingSearchBound [
	"Compare the recorded pre-attempt interval with the preceding interval."

	| index previous |
	index := algorithm steps identityIndexOf: self.
	index <= 1 ifTrue: [ ^ #none ].
	previous := algorithm steps at: index - 1.
	lower ~= previous lower ifTrue: [ ^ #lower ].
	upper ~= previous upper ifTrue: [ ^ #upper ].
	^ #none
]

{ #category : #accessing }
BlGridSizeFittingStep >> phase [
	^ phase
]

{ #category : #accessing }
BlGridSizeFittingStep >> scale [
	^ scale
]

{ #category : #presentation }
BlGridSizeFittingStep >> searchBoundColor: aSelector [
	"Completion overrides movement. First and unchanged bounds are gray."

	self searchBoundsMeet ifTrue: [ ^ BrAntColors blue ].
	^ (self hasSearchBoundChanged: aSelector)
		ifTrue: [ Color black ]
		ifFalse: [ BrAntColors gray5 ]
]

{ #category : #presentation }
BlGridSizeFittingStep >> searchBoundMarkerExtent: aSelector [
	^ 8 @ 5
]

{ #category : #presentation }
BlGridSizeFittingStep >> searchBoundY: value [
	"Use the actual gray capacity region as the ruler's reference."

	^ (algorithm capacityTopFor: self)
		+ ((1 - value) * (algorithm capacityHeightFor: self))
]

{ #category : #presentation }
BlGridSizeFittingStep >> searchBoundsElement [
	| ruler extent centerX |
	extent := self searchBoundMarkerExtent: #lower.
	centerX := 8.5.
	ruler := BlElement new size: 18 @ ((self searchBoundY: 0) + 18).
	ruler
		addChild: (BlElement new
				relocate: 8 @ (self searchBoundY: 1);
				size: 1 @ (algorithm capacityHeightFor: self);
				background: BrAntColors gray5;
				zIndex: -1).
	ruler
		addChild: (BlElement new
				relocate: (centerX - (extent x / 2)) @ (self searchBoundY: lower);
				size: extent;
				geometry: BlTriangleGeometry new beTop;
				background: (self searchBoundColor: #lower)).
	ruler
		addChild: (BlElement new
				relocate: (centerX - (extent x / 2)) @ ((self searchBoundY: upper) - extent y);
				size: extent;
				geometry: BlTriangleGeometry new beBottom;
				background: (self searchBoundColor: #upper)).
	^ ruler
]

{ #category : #presentation }
BlGridSizeFittingStep >> searchBoundsLabelsElement [
	^ BlElement new
		size: 240 @ ((self searchBoundY: 0) + 18);
		margin: (BlInsets right: 2);
		addChild: (BrLabel new
				aptitude: (BrGlamorousLabelAptitude new
						glamorousRegularSmallSize;
						foreground: (self searchBoundColor: #upper));
				text: upper printString;
				size: 240 @ 18;
				alignCenterRight;
				relocate: 0 @ ((self searchBoundY: upper) - 18));
		addChild: (BrLabel new
				aptitude: (BrGlamorousLabelAptitude new
						glamorousRegularSmallSize;
						foreground: (self searchBoundColor: #lower));
				text: lower printString;
				size: 240 @ 18;
				alignCenterRight;
				relocate: 0 @ (self searchBoundY: lower))
]

{ #category : #presentation }
BlGridSizeFittingStep >> searchBoundsMeet [
	"Does this attempt's decision finish the binary search? Use exactly its midpoint stopping condition, not a display tolerance. Stored bounds describe the interval before the attempt."

	| low high middle |
	phase = #search ifFalse: [ ^ false ].
	low := feasible ifTrue: [ scale ] ifFalse: [ lower ].
	high := feasible ifTrue: [ upper ] ifFalse: [ scale ].
	middle := (low + high) / 2.
	^ (middle > low and: [ middle < high ]) not
]

{ #category : #accessing }
BlGridSizeFittingStep >> sizes [
	^ sizes
]

{ #category : #initialization }
BlGridSizeFittingStep >> sizes: anArray scale: aScale lower: low upper: high phase: aPhase feasible: aBoolean [
	sizes := anArray copy.
	scale := aScale.
	lower := low.
	upper := high.
	phase := aPhase.
	feasible := aBoolean
]

{ #category : #presentation }
BlGridSizeFittingStep >> tooltipElementForChildAt: index offset: offset [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: 'Child ' , index printString , ' — size: ' , (sizes at: index) printString
				, ' | limited: ' , (algorithm limited at: index) printString;
		margin: (BlInsets bottom: 3)
]

{ #category : #accessing }
BlGridSizeFittingStep >> upper [
	^ upper
]

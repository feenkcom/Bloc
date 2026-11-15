"
One meaningful grid measurement operation with before/after child-size snapshots. Locations are measured axis allocations, never final child positions. Fitting refers to the computation captured at that stage.
"
Class {
	#name : #BlGridMeasurementStep,
	#superclass : #Object,
	#instVars : [
		'algorithm',
		'name',
		'before',
		'after',
		'axisName',
		'locations',
		'fitting',
		'result'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #accessing }
BlGridMeasurementStep >> after [
	^ after
]

{ #category : #accessing }
BlGridMeasurementStep >> algorithm [
	^ algorithm
]

{ #category : #initialization }
BlGridMeasurementStep >> algorithm: aMeasurement name: aName before: sizes [
	algorithm := aMeasurement.
	name := aName.
	before := sizes copy.
	locations := #()
]

{ #category : #presentation }
BlGridMeasurementStep >> allocationForChild: index [
	| span xs ys |
	span := algorithm childSpans at: index.
	xs := self knownLocationsFor: #horizontal.
	ys := self knownLocationsFor: #vertical.
	^ {xs
			ifEmpty: [ nil ]
			ifNotEmpty: [ (xs at: span second + 1) - (xs at: span first + 1) ].
		ys
			ifEmpty: [ nil ]
			ifNotEmpty: [ (ys at: span fourth + 1) - (ys at: span third + 1) ]}
]

{ #category : #presentation }
BlGridMeasurementStep >> asGridSnapshotElement [
	"Measured sizes anchored at span starts, not final aligned child bounds. Unknown dimensions remain in lanes."

	| canvas scale right bottom xs ys |
	scale := algorithm figureScale.
	xs := self knownLocationsFor: #horizontal.
	ys := self knownLocationsFor: #vertical.
	right := 1.
	bottom := 1.
	canvas := BlElement new.
	after
		withIndexDo: [ :extent :index | 
			| origin allocation width height cell box changed |
			origin := self childFigureOriginAt: index.
			allocation := self allocationForChild: index.
			width := (allocation first ifNil: [ extent x ]) * scale max: 1.
			height := (allocation second ifNil: [ extent y ]) * scale max: 1.
			cell := BlElement new
					position: origin;
					size: width @ height;
					background: (BrAntColors gray3 alpha: 0.3);
					border: (BlBorder paint: BrAntColors gray5 width: 1).
			canvas addChild: cell.
			changed := (before at: index) ~= extent.
			box := BlElement new
					layout: BlFrameLayout new;
					position: origin;
					size: (extent x * scale max: 1) @ (extent y * scale max: 1);
					background: ((changed ifTrue: [ BrAntColors blue3 ] ifFalse: [ BrAntColors green3 ])
							alpha: 0.6);
					border: (BlBorder
							paint: (changed ifTrue: [ BrAntColors blue ] ifFalse: [ BrAntColors green6 ])
							width: 1);
					clipChildren: true.
			box
				addChild: (BlShrinkingTextElement new
						text: ((index printString , ': ' , extent printString) asRopedText fontSize: 9);
						preventMouseEvents;
						constraintsDo: [ :c | 
							c horizontal fitContentLimited.
							c vertical fitContent.
							c frame horizontal alignCenter.
							c frame vertical alignCenter ]).
			canvas addChild: box.
			right := right max: origin x + (width max: extent x * scale).
			bottom := bottom max: origin y + (height max: extent y * scale) ].
	canvas size: (right + 4) @ (bottom + 4).
	xs
		do: [ :x | 
			canvas
				addChild: (BlElement new
						position: (x * scale - 0.5) @ 0;
						size: 1 @ bottom;
						background: BrAntColors gray3;
						preventMouseEvents) ].
	ys
		do: [ :y | 
			canvas
				addChild: (BlElement new
						position: 0 @ (y * scale - 0.5);
						size: right @ 1;
						background: BrAntColors gray3;
						preventMouseEvents) ].
	^ canvas
]

{ #category : #presentation }
BlGridMeasurementStep >> asStageElement [
	| pane title header |
	title := name
			, (self axisName = #both
					ifTrue: [ '' ]
					ifFalse: [ ' (' , self axisName asString , ')' ]).
	pane := BrVerticalPane new
			fitContent;
			padding: (BlInsets all: 8);
			margin: (BlInsets bottom: 20).
	header := BrHorizontalPane new
			fitContent;
			margin: (BlInsets bottom: 12).
	header
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: title asRopedText bold;
				constraintsDo: [ :c | c linear vertical alignCenter ]).
	fitting
		ifNotNil: [ header
				addChild: (BrButton new
						aptitude: BrGlamorousButtonWithLabelAptitude;
						label: 'Inspect fitting';
						beSmallSize;
						margin: (BlInsets left: 8);
						constraintsDo: [ :c | c linear vertical alignCenter ];
						action: [ :button | button phlow spawnObject: fitting ]) ].
	pane addChild: header.
	pane addChild: self asGridSnapshotElement.
	^ pane
]

{ #category : #initialization }
BlGridMeasurementStep >> axis: aSymbol locations: anArray fitting: aFitting [
	axisName := aSymbol.
	locations := anArray copy.
	fitting := aFitting
]

{ #category : #accessing }
BlGridMeasurementStep >> axisName [
	^ axisName ifNil: [ #both ]
]

{ #category : #accessing }
BlGridMeasurementStep >> before [
	^ before
]

{ #category : #accessing }
BlGridMeasurementStep >> changedChildren [
	^ (1 to: after size)
		select: [ :index | (before at: index) ~= (after at: index) ]
]

{ #category : #presentation }
BlGridMeasurementStep >> childFigureOriginAt: index [
	"Use known grid coordinates. An unresolved axis uses spaced lanes, not invented cell coordinates."

	| span xs ys scale lane |
	span := algorithm childSpans at: index.
	xs := self knownLocationsFor: #horizontal.
	ys := self knownLocationsFor: #vertical.
	scale := algorithm figureScale.
	lane := 0.
	1
		to: index - 1
		do: [ :i | 
			lane := lane
					+ ((xs isEmpty and: [ ys isNotEmpty ])
							ifTrue: [ (after at: i) x * scale + 24 ]
							ifFalse: [ (after at: i) y * scale + 24 ]) ].
	^ (xs
		ifEmpty: [ ys ifEmpty: [ 0 ] ifNotEmpty: [ lane ] ]
		ifNotEmpty: [ (xs at: span first + 1) * scale ])
		@ (ys ifEmpty: [ lane ] ifNotEmpty: [ (ys at: span third + 1) * scale ])
]

{ #category : #initialization }
BlGridMeasurementStep >> completeWith: sizes result: aResult [
	after := sizes copy.
	result := aResult
]

{ #category : #accessing }
BlGridMeasurementStep >> fitting [
	^ fitting
]

{ #category : #'gt-views' }
BlGridMeasurementStep >> gtChildrenFor: aView [
	"Which measured child extents changed during this stage?"

	<gtView>
	^ aView columnedList
		title: 'Child measurements';
		priority: 1;
		items: [ 1 to: after size ];
		column: 'Child' text: #yourself;
		column: 'Before' text: [ :index | (before at: index) printString ];
		column: 'After' text: [ :index | (after at: index) printString ];
		column: 'Changed' text: [ :index | (before at: index) ~= (after at: index) ]
]

{ #category : #'gt-views' }
BlGridMeasurementStep >> gtFittingFor: aView [
	"Which candidate fitting decisions underlie this axis allocation?"

	<gtView>
	fitting ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Fitting';
		priority: 2;
		object: [ fitting ];
		view: #gtStepsFigureFor:
]

{ #category : #'gt-views' }
BlGridMeasurementStep >> gtStageFigureFor: aView [
	"Which measured child rectangles changed here, relative to known span allocations? Lanes are comparisons, not final placement."

	<gtView>
	^ aView canvassable
		title: 'Stage figure';
		priority: 0;
		stencil: [ self asStageElement ]
]

{ #category : #presentation }
BlGridMeasurementStep >> knownLocationsFor: anAxis [
	"Reuse only recorded allocations up to this stage; never ask a live axis to compute."

	| known |
	known := #().
	algorithm steps
		do: [ :step | 
			(step axisName = anAxis and: [ step locations isNotEmpty ])
				ifTrue: [ known := step locations ].
			step == self ifTrue: [ ^ known ] ].
	^ known
]

{ #category : #accessing }
BlGridMeasurementStep >> locations [
	^ locations
]

{ #category : #accessing }
BlGridMeasurementStep >> name [
	^ name
]

{ #category : #accessing }
BlGridMeasurementStep >> result [
	^ result
]

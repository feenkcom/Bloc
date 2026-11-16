"
General span-based fitting, including overlapping, gapped or out-of-order spans. Explains independent span requirements without summing children. Separate lanes are not solved placements; feasibility comes from the constraint solver.
"
Class {
	#name : #BlGridSpanningSizeFitting,
	#superclass : #BlGridSizeFitting,
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #presentation }
BlGridSpanningSizeFitting >> addChildRequirementsOf: step to: canvas locations: xs origin: origin factor: factor top: top [
	"One lane per child: actual span, content, combined margins, and applicable grouped inequalities."

	step sizes
		withIndexDo: [ :size :index | 
			| span start end margin fits color x y box |
			span := childSpans at: index.
			start := xs at: span first + 1.
			end := xs at: span second + 1.
			margin := self childMargins at: index.
			fits := self childRequirementsSatisfiedAt: index in: step.
			color := fits ifTrue: [ BrAntColors green6 ] ifFalse: [ BrAntColors red6 ].
			x := (start - origin) * factor + 4.
			y := top + ((index - 1) * 32).
			canvas
				addChild: (BlElement new
						position: x @ y;
						size: ((end - start) * factor max: 1) @ 24;
						border: (BlBorder paint: BrAntColors gray5 width: 1)).
			box := BlElement new
					layout: BlFrameLayout new;
					position: x @ (y + 2);
					size: (size * factor max: 0.5) @ 20;
					background: (fits ifTrue: [ BrAntColors green3 ] ifFalse: [ BrAntColors red3 ]);
					border: (BlBorder paint: color width: 1);
					clipChildren: true.
			box
				addChild: (BlShrinkingTextElement new
						text: ((index printString , ': ' , size printString) asRopedText fontSize: 9);
						constraintsDo: [ :c | 
							c horizontal fitContentLimited.
							c vertical fitContent.
							c frame horizontal alignCenter.
							c frame vertical alignCenter ]).
			canvas addChild: box.
			margin > 0
				ifTrue: [ canvas
						addChild: (BlElement new
								position: (x + (size * factor)) @ (y + 2);
								size: (margin * factor max: 0.5) @ 20;
								background: BrAntColors gray4;
								border: (BlBorder paint: color width: 1)) ].
			canvas
				addChild: (self
						conditionsLabelForChild: index
						in: step
						locations: xs
						origin: origin
						factor: factor
						y: y) ]
]

{ #category : #presentation }
BlGridSpanningSizeFitting >> capacityHeightFor: aStep [
	^ aStep evaluation
		ifNil: [ super capacityHeightFor: aStep ]
		ifNotNil: [ 14 + (aStep sizes size * 32) ]
]

{ #category : #presentation }
BlGridSpanningSizeFitting >> capacityTopFor: aStep [
	^ aStep evaluation ifNil: [ super capacityTopFor: aStep ] ifNotNil: [ 30 ]
]

{ #category : #presentation }
BlGridSpanningSizeFitting >> childOffsetAt: index in: aStep [
	^ 0
]

{ #category : #testing }
BlGridSpanningSizeFitting >> childRequirementsSatisfiedAt: index in: step [
	"Color by the recorded solver inequalities for this span, not raw child-size subtraction."

	^ (self constraintsForChild: index in: step)
		allSatisfy: [ :triple | step evaluation satisfies: triple ]
]

{ #category : #presentation }
BlGridSpanningSizeFitting >> childYAt: index [
	^ (index - 1) * 28 + 26
]

{ #category : #presentation }
BlGridSpanningSizeFitting >> conditionsLabelForChild: index in: step locations: xs origin: origin factor: factor y: y [
	"Child conditions remain beside the span, beyond any overflowing content and margins."

	| span start end occupiedRight |
	span := childSpans at: index.
	start := xs at: span first + 1.
	end := xs at: span second + 1.
	occupiedRight := end
			max: start + (step sizes at: index) + (self childMargins at: index).
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude new glamorousRegularSmallSize;
		text: (self conditionsText: (self constraintsForChild: index in: step) in: step);
		position: ((occupiedRight - origin) * factor + 12) @ y
]

{ #category : #presentation }
BlGridSpanningSizeFitting >> conditionsText: triples in: step [
	| text |
	text := '' asRopedText.
	triples
		withIndexDo: [ :triple :index | 
			index > 1 ifTrue: [ text append: ' ; ' asRopedText ].
			text
				append: (('L' , triple second printString , ' - L' , triple first printString , ' >= '
						, triple third printString) asRopedText
						foreground: ((step evaluation satisfies: triple)
								ifTrue: [ BrAntColors green6 ]
								ifFalse: [ BrAntColors red6 ])) ].
	^ text
]

{ #category : #presentation }
BlGridSpanningSizeFitting >> constraintsForChild: index in: step [
	"Constraints on the same pair of grid lines, in either direction. Shared/grouped constraints may apply to several children."

	| span |
	span := childSpans at: index.
	^ step evaluation constraints
		select: [ :triple | 
			(triple first = span first and: [ triple second = span second ])
				or: [ triple first = span second and: [ triple second = span first ] ] ]
]

{ #category : #presentation }
BlGridSpanningSizeFitting >> diagramHeightFor: aStep [
	^ aStep sizes size * 28 + 16
]

{ #category : #presentation }
BlGridSpanningSizeFitting >> explanation [
	^ 'General spans: each child constrains its own interval. Do not sum overlapping requirements. Separate lanes compare sizes with whole-axis bounds, not solved span placements. Feasibility is determined by the constraint solver.'
]

{ #category : #accessing }
BlGridSpanningSizeFitting >> isSequential [
	^ false
]

{ #category : #presentation }
BlGridSpanningSizeFitting >> remainingConstraintsFor: step [
	^ step evaluation constraints
		reject: [ :triple | 
			(1 to: step sizes size)
				anySatisfy: [ :index | (self constraintsForChild: index in: step) includes: triple ] ]
]

{ #category : #presentation }
BlGridSpanningSizeFitting >> requirementsTitle [
	^ 'Span requirements'
]

{ #category : #presentation }
BlGridSpanningSizeFitting >> sizesExpressionFor: aStep [
	^ self requirementsExpressionFor: aStep
]

{ #category : #presentation }
BlGridSpanningSizeFitting >> solverDiagramFor: step maximum: maximum selected: selected [
	"Child conditions beside their boxes; unmatched axis conditions together below the gray capacity box."

	| canvas xs factor origin width height remaining |
	step evaluation ifNil: [ ^ nil ].
	xs := step evaluation locations
			collect: [ :x | x - step evaluation locations first ].
	origin := xs min min: 0.
	width := (xs max max: availableSpace) - origin max: maximum.
	factor := 600 / (width max: 1).
	remaining := self remainingConstraintsFor: step.
	height := 36 + (step sizes size * 32) + 8.
	canvas := BlElement new
			size: 760 @ (height + 18 + (remaining ifEmpty: [ 0 ] ifNotEmpty: [ 24 ]));
			clipChildren: false.
	canvas
		addChild: (BlElement new
				position: ((0 - origin) * factor + 4) @ 30;
				size: (availableSpace * factor max: 1) @ (height - 30);
				background: BrAntColors gray3).
	xs
		withIndexDo: [ :x :index | 
			canvas
				addChild: (BlElement new
						position: ((x - origin) * factor + 4) @ 28;
						size: 1 @ (height - 28);
						background: BrAntColors gray5).
			canvas
				addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude new glamorousRegularSmallSize;
						text: (index - 1) printString , ': ' , x printString;
						position: ((x - origin) * factor + 4) @ ((index - 1) odd ifTrue: [ 0 ] ifFalse: [ 10 ])) ].
	self
		addChildRequirementsOf: step
		to: canvas
		locations: xs
		origin: origin
		factor: factor
		top: 36.
	remaining
		ifNotEmpty: [ canvas
				addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude new glamorousRegularSmallSize;
						text: (self conditionsText: remaining in: step);
						position: ((0 - origin) * factor + 4) @ (height + 18)) ].
	canvas
		addChild: (BrLabel new
				aptitude: (BrGlamorousLabelAptitude new
						glamorousRegularSmallSize;
						foreground: BrAntColors gray5);
				text: availableSpace printString;
				size: (availableSpace * factor max: 1) @ 18;
				alignCenter;
				position: ((0 - origin) * factor + 4) @ height).
	^ canvas
]

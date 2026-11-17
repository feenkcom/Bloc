"
I represent a horizontal or vertical axis of grid layout.

I compute and cache locations of cells within grid along corresponding axis.
I use Bellman-Ford algorithm to solve a set of inequalities in order to distribute indices such that cells of different sizes could fit on the grid within its bounds. 
I'm also responsible for calculation of grid's size based on children and grid resizing mode.

This internal class houses the algorithm for computing the locations of grid lines; along either the horizontal or vertical axis.
A GridLayout uses two instances of this class - distinguished by the ""horizontal"" flag which is true for the horizontal axis and false for the vertical one.

Public API and Key Messages

- applyLayoutIn: entrance point used to launch layout computation process within provided size along axis
- locations returns (creates,  computes and caches) cell locations and sizes along axis and used by GridLayout during measure: and layout:  
- measure: determines grid's size based on cells and grid's resizing mode along axis

   BlGridLayoutAxis new horizontal: true
 
Internal Representation and Key Implementation Points.

	Most instance variables are used to cache and store computation results between layout processes. Used to increase performance

    Instance Variables
	arcs:		<Object>
	arcsValid:		<Object>
	backwardLinks:		<Object>
	backwardLinksValid:		<Object>
	definedCount:		<Object>
	deltas:		<Object>
	element:		<Object>
	forwardLinks:		<Object>
	forwardLinksValid:		<Object>
	groupBounds:		<Object>
	groupBoundsValid:		<Object>
	hasWeights:		<Object>
	hasWeightsValid:		<Object>
	isHorizontal:		<Object>
	leadingMargins:		<Object>
	leadingMarginsValid:		<Object>
	locations:		<Object>
	locationsValid:		<Object>
	maxIndex:		<Object>
	orderPreserved:		<Object>
	parentMax:		<Object>
	parentMin:		<Object>
	trailingMargins:		<Object>
	trailingMarginsValid:		<Object>

"
Class {
	#name : #BlGridLayoutAxis,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'element',
		'layout',
		'isHorizontal',
		'maxIndex',
		'definedCount',
		'orderPreserved',
		'groupBounds',
		'groupBoundsValid',
		'deltas',
		'forwardLinks',
		'forwardLinksValid',
		'backwardLinks',
		'backwardLinksValid',
		'parentMin',
		'parentMax',
		'arcs',
		'arcsValid',
		'leadingMargins',
		'trailingMargins',
		'leadingMarginsValid',
		'trailingMarginsValid',
		'hasWeightsValid',
		'hasWeights',
		'locations',
		'locationsValid',
		'childConstraints',
		'sizeFitting'
	],
	#classVars : [
		'COMPLETE',
		'NEW',
		'PENDING'
	],
	#pools : [
		'BlGridLayoutConstants'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #'constraint solving' }
BlGridLayoutAxis class >> constraintFrom: start to: end by: offset in: locations ifViolated: aBlock [
	"Grid-line indices are zero-based. Preserve the solver's addition/comparison order. Report the candidate to allow relaxation without duplicating arithmetic."

	| candidate |
	candidate := (locations at: start + 1) + offset.
	candidate > (locations at: end + 1)
		ifTrue: [ aBlock value: candidate.
			^ false ].
	^ true
]

{ #category : #'class initialization' }
BlGridLayoutAxis class >> initialize [
	super initialize.
	
	NEW := 0.
	PENDING := 1.
	COMPLETE := 2.
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> addComponentSizesIn: theArcs links: links [
	"arcs is collection of BlGridLayoutArc
	links is BlGridPackedMap<Interval, BlMutableInteger>"
	
	links keysAndValuesDo: [ :span :size |
		self includeIn: theArcs span: span size: size ignoreIfPresent: false ]
]

{ #category : #measure }
BlGridLayoutAxis >> applyLayoutWithin: size [

	self parentConstraintsMin: size max: size.
	self locations
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> arcs [

	arcs
		ifNil: [ arcs := self createArcs ].
		
	arcsValid ifFalse: [ 
		self computeArcs.
		arcsValid := true ].
	
	^ arcs
]

{ #category : #'computing links' }
BlGridLayoutAxis >> backwardLinks [
	<return: #BlGridPackedMap key: #Interval value: #BlGridMutableInteger>
	
	backwardLinks
		ifNil: [ backwardLinks := self createLinks: false ].
	
	backwardLinksValid ifFalse: [ 
		self computeLinks: backwardLinks min: false.
		backwardLinksValid := true ].
	
	^ backwardLinks
]

{ #category : #computing }
BlGridLayoutAxis >> calculateMaxIndex [
	"return UNDEFINED when there are no children"
	<return: #Number>
	| aResult |

	aResult := -1.
	self element children accountedByLayout withIndexDo: [ :child :index |
		| spec span |
		spec := (childConstraints at: index) spec.
		span := spec span.
		aResult := aResult max: span min.
		aResult := aResult max: span max.
		aResult := aResult max: span size ].
	^ aResult = -1
		ifTrue: [ UNDEFINED ]
		ifFalse: [ aResult ]
]

{ #category : #'computing weights' }
BlGridLayoutAxis >> calculateTotalWeight [

	^ self element children accountedByLayout
		inject: 0.0
		into: [ :totalWeight :child | totalWeight + (self specOf: child) weight asFloat ]
]

{ #category : #private }
BlGridLayoutAxis >> canFitChildSizes: childSizes [
	^ (self evaluateFitChildSizes: childSizes) feasible
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> computeArcs [
	"getting the links validates the values that are shared by the arc list"

	self forwardLinks.
	self backwardLinks.
]

{ #category : #private }
BlGridLayoutAxis >> computeGroupBounds [
	self computeGroupBoundsFor: self measuredChildSizes
]

{ #category : #private }
BlGridLayoutAxis >> computeGroupBoundsFor: childSizes [
	groupBounds := self
			groupBoundsFor: (childSizes
					withIndexCollect: [ :size :index | 
						size
							+ ((childConstraints at: index) spec weight isZero
									ifTrue: [ 0 ]
									ifFalse: [ self deltas at: index ]) ]).
	groupBoundsValid := true
]

{ #category : #'computing weights' }
BlGridLayoutAxis >> computeHasWeights [
	
	^ self element children accountedByLayout anySatisfy: [ :child | (self specOf: child) weight isZero not ]
]

{ #category : #private }
BlGridLayoutAxis >> computeLinks: theLinks fromBounds: bounds min: isMin [
	theLinks valuesDo: [ :size | size reset ].
	bounds values
		withIndexDo: [ :bound :index | 
			| size link |
			size := bound size: isMin.
			link := theLinks at: index.
			link
				value: (link value max: (isMin ifTrue: [ size ] ifFalse: [ size negated ])) ]
]

{ #category : #private }
BlGridLayoutAxis >> computeLinks: theLinks min: isMin [
	self
		computeLinks: theLinks
		fromBounds: self groupBounds
		min: isMin
]

{ #category : #private }
BlGridLayoutAxis >> computeLocations: theLocations [
	| childSizes |
	childSizes := self fittingChildSizes: self measuredChildSizes.
	self invalidateValues.
	arcs := nil.
	self deltas atAllPut: 0.
	self computeGroupBoundsFor: childSizes.
	self hasWeights
		ifFalse: [ self solveLocations: theLocations ]
		ifTrue: [ self solveAndDistributeSpaceLocations: theLocations childSizes: childSizes ].

	self isOrderPreserved ifTrue: [ ^ self ].	"Solve returns the smallest solution to the constraint system for which all values are positive.
	One value is therefore zero - though if the row/col order is not preserved this may not be the first vertex.
	For consistency, translate all the values so that they measure the distance from theLocations[0]; the leading edge of the parent.
	After this transformation some values may be negative."
	theLocations
		withIndexDo: [ :location :index | theLocations at: index put: location - theLocations first ]
]

{ #category : #'computing margins' }
BlGridLayoutAxis >> computeMargins: isLeading [
	| margins |
	
	margins := isLeading
		ifTrue: [ leadingMargins ]
		ifFalse: [ trailingMargins ].

	self element children accountedByLayout withIndexDo: [ :child :anIndex |
		| spec span index margin |
		spec := (childConstraints at: anIndex) spec.
		span := spec span.
		index := (isLeading
			ifTrue: [ span min ]
			ifFalse: [ span max ]) + 1.
		margin := (margins at: index) max: (self layout measurer marginOf: child isHorizontal: self horizontal isLeading: isLeading).
		margins at: index put: margin ]
]

{ #category : #computing }
BlGridLayoutAxis >> count [
	<return: #Number>

	^ definedCount max: self maxIndex
]

{ #category : #computing }
BlGridLayoutAxis >> count: aNumber [
	self assert: aNumber isNotNil.
	"self
		assert: (aNumber ~= UNDEFINED and: [ aNumber < self maxIndex ])
		descriptionBlock: [ 'aNumber must be greater or equal to maxIndex (', self maxIndex asString, ') but is ', aNumber asString ]."

	definedCount := aNumber
]

{ #category : #private }
BlGridLayoutAxis >> createArcs [
	^ self
		createArcsWithForwardLinks: self forwardLinks
		backwardLinks: self backwardLinks
		min: parentMin
		max: parentMax
]

{ #category : #private }
BlGridLayoutAxis >> createArcsWithForwardLinks: minimumLinks backwardLinks: maximumLinks min: minimum max: maximum [
	| mins maxs n sMins sMaxs |
	mins := OrderedCollection new.
	maxs := OrderedCollection new.	"Add the minimum values from the components."
	self addComponentSizesIn: mins links: minimumLinks.	"Add the maximum values from the components."
	self addComponentSizesIn: maxs links: maximumLinks.	"Add ordering constraints to prevent row/col sizes from going negative"
	self isOrderPreserved
		ifTrue: [  "Add a constraint for every row/col"0
				to: self count - 1
				do: [ :i | 
					self
						includeIn: mins
						span: (BlGridLayoutInterval min: i max: i + 1)
						size: (BlGridMutableInteger value: 0) ] ].	"Add the container constraints. Use the version of include that allows duplicate entries in case a child spans the entire grid."
	n := self count.
	self
		includeIn: mins
		span: (BlGridLayoutInterval min: 0 max: n)
		size: minimum
		ignoreIfPresent: false.
	self
		includeIn: maxs
		span: (BlGridLayoutInterval min: n max: 0)
		size: maximum
		ignoreIfPresent: false.	"sort"
	sMins := self topologicalSort: mins.
	sMaxs := self topologicalSort: maxs.

	^ sMins , sMaxs
]

{ #category : #'computing group bounds' }
BlGridLayoutAxis >> createGroupBounds [     
	<return: #BlGridPackedMap key: #BlGridLayoutSpec value: #BlGridLayoutBounds>      
	|assocs|
	
	assocs := OrderedCollection new.
	self element children accountedByLayout withIndexDo: [ :child :index |
		| spec bounds |
		spec := (childConstraints at: index) spec.
		bounds := (spec absoluteAlignment: self horizontal) bounds.
		assocs add: (spec -> bounds) ].
	^ BlGridPackedMap fromAssociations: assocs
]

{ #category : #'computing links' }
BlGridLayoutAxis >> createLinks: isMin [
	<return: #BlGridPackedMap key: #Interval value: #BlGridMutableInteger>
	| theLinks |

	theLinks := OrderedCollection new.
	self groupBounds keysDo: [ :spec |
		| span |
		span := isMin
			ifTrue: [ spec span ]
			ifFalse: [ spec span inversed ].
		theLinks add: (span -> BlGridMutableInteger new) ].

	^ BlGridPackedMap fromAssociations: theLinks
]

{ #category : #initialization }
BlGridLayoutAxis >> defaultOrderPreserved [
	^ true
]

{ #category : #computing }
BlGridLayoutAxis >> definedCount [
	^ definedCount
]

{ #category : #'computing deltas' }
BlGridLayoutAxis >> deltas [
	^ deltas ifNil: [ 
		deltas := Array new: self element children accountedByLayout size withAll: 0 ]
]

{ #category : #accessing }
BlGridLayoutAxis >> element [
	self assert: element isNotNil.
	
	^ element
]

{ #category : #accessing }
BlGridLayoutAxis >> element: anElement [
	self assert: anElement isNotNil.
	
	element := anElement
]

{ #category : #private }
BlGridLayoutAxis >> evaluateFitChildSizes: childSizes [
	| bounds candidateArcs candidateLocations fits |
	bounds := self groupBoundsFor: childSizes.
	candidateArcs := self
			createArcsWithForwardLinks: (self linksFor: bounds min: true)
			backwardLinks: (BlGridPackedMap fromAssociations: #())
			min: (BlGridMutableInteger value: 0)
			max: (BlGridMutableInteger value: parentMax value).
	candidateLocations := Array new: self count + 1 withAll: 0.
	fits := self
			solve: candidateArcs
			locations: candidateLocations
			modifyOnError: false.
	^ BlGridFittingEvaluation new
		feasible: fits
		locations: candidateLocations
		constraints: (candidateArcs
				collect: [ :arc | 
					{arc span min.
						arc span max.
						arc value value} ])
]

{ #category : #private }
BlGridLayoutAxis >> fittingChildSizes: preferredSizes [
	| children next sequential fittingClass |
	children := self element children accountedByLayout.
	next := 0.
	sequential := true.
	children
		do: [ :child | 
			| span |
			span := (self specOf: child) span.
			sequential := sequential and: [ span min = next ].
			next := span max ].
	sequential := sequential and: [ next = self count ].
	fittingClass := sequential
			ifTrue: [ BlGridSequentialSizeFitting ]
			ifFalse: [ BlGridSpanningSizeFitting ].
	sizeFitting := fittingClass new
			preferred: preferredSizes
			minima: (children collect: [ :child | self minimumSizeOf: child ])
			limited: (children collect: [ :child | self isLimited: child ])
			feasibility: [ :sizes | self evaluateFitChildSizes: sizes ].
	sizeFitting
		availableSpace: parentMax value negated
		margins: (children
				collect: [ :child | self layout measurer totalMarginOf: child isHorizontal: self horizontal ]).
	sizeFitting
		childSpans: (children
				collect: [ :child | 
					| span |
					span := (self specOf: child) span.
					{span min.
						span max} ])
		axis: (self horizontal ifTrue: [ #horizontal ] ifFalse: [ #vertical ]).
	sizeFitting run.
	^ sizeFitting result
]

{ #category : #'computing links' }
BlGridLayoutAxis >> forwardLinks [
	<return: #BlGridPackedMap key: #Interval value: #BlGridMutableInteger>
	
	forwardLinks
		ifNil: [ forwardLinks := self createLinks: true ].
	
	forwardLinksValid ifFalse: [ 
		self computeLinks: forwardLinks min: true.
		forwardLinksValid := true ].
	
	^ forwardLinks
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> groupArcsByFirstVertex: theArcs [
	"Group arcs by their first vertex, returning an array of arrays of Arcs.
	This is linear in the number of arcs.
	theArcs is collection of BlGridLayoutArc."
	<return: #Array of: #Array of: #BlGridLayoutArc>	
	| n groups sizes |

	n := self count + 1.

	groups := Array new: n.
	sizes := Array new: n withAll: 0.

	theArcs do: [ :arc |
		sizes at: (arc span min + 1) incrementBy: 1 ].
	
	sizes withIndexDo: [ :size :index |
		groups at: index put: (Array new: size) ].
	
	"reuse the sizes array to hold the current last elements as we insert each arc"
	sizes atAllPut: 0.
	theArcs do: [ :arc |
		| anIndex |
		anIndex := arc span min + 1.
		(groups at: anIndex) at: ((sizes at: anIndex) + 1) put: arc.
		sizes at: anIndex incrementBy: 1 ].
	^ groups
]

{ #category : #'computing group bounds' }
BlGridLayoutAxis >> groupBounds [
	<return: #BlGridPackedMap key: #BlGridLayoutSpec value: #BlGridLayoutBounds>  
	
	groupBounds
		ifNil: [ groupBounds := self createGroupBounds ].
	
	groupBoundsValid ifFalse: [ 
		self computeGroupBounds.
		groupBoundsValid := true ].
	
	^ groupBounds
]

{ #category : #private }
BlGridLayoutAxis >> groupBoundsFor: childSizes [
	| bounds |
	bounds := self createGroupBounds.
	self element children accountedByLayout
		withIndexDo: [ :child :index | 
			| spec size |
			spec := (childConstraints at: index) spec.
			size := (childSizes at: index)
					+ (self layout measurer totalMarginOf: child isHorizontal: self horizontal).
			(bounds at: index)
				includeElement: self element
				spec: spec
				axis: self
				size: size ].
	^ bounds
]

{ #category : #'gt-views' }
BlGridLayoutAxis >> gtSizeFittingFor: aView [
	"Why did the latest fitting computation choose these child sizes?"

	<gtView>
	sizeFitting ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Size fitting';
		priority: 1;
		object: [ sizeFitting ];
		view: #gtStepsFigureFor:
]

{ #category : #private }
BlGridLayoutAxis >> hasDroppedArcs [
	"Answer whether solving had to drop an inconsistent arc. #computeArcs refreshes the values of the arcs but not their validity, so a dropped arc stays dropped in later solves"
	^self arcs anySatisfy: [:each | each valid not]
]

{ #category : #'computing weights' }
BlGridLayoutAxis >> hasWeights [

	hasWeightsValid ifFalse: [ 
		hasWeights := self computeHasWeights.
		hasWeightsValid := true ].
	^ hasWeights
]

{ #category : #accessing }
BlGridLayoutAxis >> horizontal [
	^ isHorizontal
]

{ #category : #accessing }
BlGridLayoutAxis >> horizontal: anObject [
	isHorizontal := anObject
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> includeIn: theArcs span: span size: size [

	self includeIn: theArcs span: span size: size ignoreIfPresent: true
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> includeIn: theArcs span: aSpan size: aSize ignoreIfPresent: ignoreIfPresent [
	"Remove self referential links.
	These appear:
		- as parental constraints when GridLayout has no children
		- when components have been marked as GONE

	theArcs is collection of BlGridLayoutArc.
	aSpan is Interval
	aSize is BlGridMutableInteger
	ignoreIfPresent is Boolean"

	aSpan size isZero
		ifTrue: [ ^ self ].
	
	"this bit below should really be computed outside here - its just to stop default (row/col > 0) constraints obliterating valid entries"
	(ignoreIfPresent
		and: [ theArcs anySatisfy: [ :arc | arc span = aSpan ] ])
			ifTrue: [ ^ self ].

	theArcs add: (BlGridLayoutArc span: aSpan value: aSize )
]

{ #category : #'computing locations' }
BlGridLayoutAxis >> initLocations: theLocations [
	theLocations atAllPut: 0
]

{ #category : #initialization }
BlGridLayoutAxis >> initialize [
	super initialize.

	isHorizontal := false.

	maxIndex := UNDEFINED.
	definedCount := UNDEFINED.

	groupBounds := nil.
	groupBoundsValid := false.

	forwardLinks := nil.
	forwardLinksValid := false.

	backwardLinks := nil.
	backwardLinksValid := false.

	leadingMargins := nil.
	leadingMarginsValid := false.

	trailingMargins := nil.
	trailingMarginsValid := false.

	arcs := nil.
	arcsValid := false.

	locations := nil.
	locationsValid := false.

	hasWeights := false.
	hasWeightsValid := false.
	deltas := nil.

	orderPreserved := self defaultOrderPreserved.

	parentMin := BlGridMutableInteger value: 0.
	parentMax := BlGridMutableInteger value: SmallInteger minVal
]

{ #category : #private }
BlGridLayoutAxis >> invalidateStructure [
	maxIndex := UNDEFINED.

	groupBounds := nil.
	forwardLinks := nil.
	backwardLinks := nil.

	leadingMargins := nil.
	trailingMargins := nil.
	arcs := nil.

	locations := nil.

	deltas := nil.
	hasWeightsValid := false.

	self invalidateValues.

	element ifNil: [ ^ self ].

	childConstraints := self element children accountedByLayout
			collect: [ :child | 
				self horizontal
					ifTrue: [ child constraints grid horizontal ]
					ifFalse: [ child constraints grid vertical ] ]
]

{ #category : #invalidate }
BlGridLayoutAxis >> invalidateValues [
	groupBoundsValid := false.
	forwardLinksValid := false.
	backwardLinksValid := false.

	leadingMarginsValid := false.
	trailingMarginsValid := false.
	arcsValid := false.

	locationsValid := false
]

{ #category : #private }
BlGridLayoutAxis >> isLimited: aChild [
	^ (self horizontal
		ifTrue: [ aChild constraints horizontal ]
		ifFalse: [ aChild constraints vertical ]) resizer isFitContentLimited
]

{ #category : #private }
BlGridLayoutAxis >> isMatchingParent: aChild [
	"Answer whether aChild takes whatever size its cell gets on my axis"
	^(self horizontal
		ifTrue: [aChild constraints horizontal]
		ifFalse: [aChild constraints vertical]) resizer
		isMatchParent
]

{ #category : #testing }
BlGridLayoutAxis >> isOrderPreserved [
	^ orderPreserved
]

{ #category : #accessing }
BlGridLayoutAxis >> layout [
	^ layout
]

{ #category : #accessing }
BlGridLayoutAxis >> layout: aLayout [
	layout := aLayout
]

{ #category : #'computing margins' }
BlGridLayoutAxis >> leadingMargins [
	
	leadingMargins
		ifNil: [ leadingMargins := Array new: (self count + 1) withAll: 0 ].
		
	leadingMarginsValid ifFalse: [ 
		self computeMargins: true.
		leadingMarginsValid := true ].
	
	^ leadingMargins
]

{ #category : #private }
BlGridLayoutAxis >> linksFor: bounds min: isMin [
	| links |
	links := BlGridPackedMap
			fromAssociations: (bounds keys
					collect: [ :spec | 
						(isMin ifTrue: [ spec span ] ifFalse: [ spec span inversed ])
							-> BlGridMutableInteger new ]).
	self
		computeLinks: links
		fromBounds: bounds
		min: isMin.
	^ links
]

{ #category : #accessing }
BlGridLayoutAxis >> locations [
	<return: #Array of: #Integer>

	locations ifNil: [
		locations := Array new: self count + 1 withAll: 0 ].
	
	locationsValid ifFalse: [ 
		self computeLocations: locations.
		locationsValid := true ].
	
	^ locations
]

{ #category : #computing }
BlGridLayoutAxis >> maxIndex [
	<return: #Number>

	^ maxIndex == UNDEFINED
		ifTrue: [ maxIndex := (0 max: self calculateMaxIndex) ] "use zero when there are no children"
		ifFalse: [ maxIndex ]
]

{ #category : #measure }
BlGridLayoutAxis >> measure: aMeasurementSpec [
	| mode size |
	mode := aMeasurementSpec mode.
	size := aMeasurementSpec size.
	
	mode isUnspecified
		ifTrue: [ ^ self measureMin: 0 max: SmallInteger maxVal ].

	mode isExact
		ifTrue: [ ^ self measureMin: size max: size ].

	mode isAtMost
		ifTrue: [ ^ self measureMin: 0 max: size ].
	
	Warning signal: 'Unknown measurement spec mode: ', mode asString.
	
	^ 0
]

{ #category : #measure }
BlGridLayoutAxis >> measureMin: min max: max [

	self parentConstraintsMin: min max: max.
	^ self sizeLocations: self locations
]

{ #category : #private }
BlGridLayoutAxis >> measuredChildSizes [
	"A matchParent child requires only its minimum size. Its measured size is the cell size of the previous pass; using it would make the columns overflow when the grid is laid out narrower than it was measured"
	^self element children accountedByLayout collect: 
			[:child |
			(self isMatchingParent: child)
				ifTrue: [self minimumSizeOf: child]
				ifFalse: 
					[| size |
					size := self layout measurer measurementOf: child
								isHorizontal: self horizontal.
					(self isLimited: child)
						ifTrue: [size max: (self minimumSizeOf: child)]
						ifFalse: [size]]]
]

{ #category : #private }
BlGridLayoutAxis >> minimumSizeOf: aChild [
	^ self horizontal
		ifTrue: [ aChild constraints minWidth ]
		ifFalse: [ aChild constraints minHeight ]
]

{ #category : #computing }
BlGridLayoutAxis >> orderPreserved: aBoolean [
	self assert: aBoolean isNotNil.
	
	orderPreserved := aBoolean.
	self invalidateStructure
]

{ #category : #'accessing spec' }
BlGridLayoutAxis >> parentConstraintsMin: min max: max [

	parentMin value: min.
	parentMax value: max negated.
	locationsValid := false
]

{ #category : #private }
BlGridLayoutAxis >> relaxLocations: theLocations arc: arc [
	"Answer whether relaxation changed the destination."

	<return: #Boolean>
	arc valid ifFalse: [ ^ false ].
	^ (self class
		constraintFrom: arc span min
		to: arc span max
		by: arc value value
		in: theLocations
		ifViolated: [ :candidate | theLocations at: arc span max + 1 put: candidate ])
		not
]

{ #category : #'computing deltas' }
BlGridLayoutAxis >> shareOutDelta: totalDelta totalWeight: totalWeight [
	| mTotalDelta mTotalWeight |
	mTotalDelta := totalDelta.
	mTotalWeight := totalWeight.
	
	deltas atAllPut: 0.
	
	self element children accountedByLayout withIndexDo: [ :child :index |
		| spec weight |
		spec := (childConstraints at: index) spec.
		weight := spec weight asFloat.
		weight ~= 0 ifTrue: [ 
			| delta |
			delta := (weight * mTotalDelta / mTotalWeight) rounded.
			deltas at: index put: delta.
			"the two adjustments below are to counter the above rounding and avoid off-by-ones at the end"
			mTotalDelta := mTotalDelta - delta.
			mTotalWeight := mTotalWeight - weight ] ]
]

{ #category : #accessing }
BlGridLayoutAxis >> sizeFitting [
	"The latest fitting computation, not a history of all layout passes."

	^ sizeFitting
]

{ #category : #'computing locations' }
BlGridLayoutAxis >> sizeLocations: theLocations [

	^ theLocations at: self count + 1
]

{ #category : #'computing inequalities' }
BlGridLayoutAxis >> solve: theArcs locations: theLocations [
	"Bellman-Ford variant - modified to reduce typical running time from O(N^2) to O(N)
	
	GridLayout converts its requirements into a system of linear constraints of the
	form:

	x[i] - x[j] < a[k]

	Where the x[i] are variables and the a[k] are constants.

	For example, if the variables were instead labeled x, y, z we might have:

	    x - y < 17
	    y - z < 23
	    z - x < 42

	This is a special case of the Linear Programming problem that is, in turn,
	equivalent to the single-source shortest paths problem on a digraph, for
	which the O(n^2) Bellman-Ford algorithm the most commonly used general solution."

	^ self solve: theArcs locations: theLocations modifyOnError: true
]

{ #category : #'computing inequalities' }
BlGridLayoutAxis >> solve: theArcs locations: theLocations modifyOnError: modifyOnError [
	"See ${method:BlGridLayoutAxis>>#solve:locations:}$ for more information"
	| verticesCount originalCulprits |

	verticesCount := self count + 1. "The number of vertices is the number of columns/rows + 1."
	originalCulprits := nil.
	
	0 to: theArcs size - 1 do: [ :p |
		| culprits i break |
		
		self initLocations: theLocations.
		
		"We take one extra pass over traditional Bellman-Ford (and omit their final step)"
		verticesCount timesRepeat: [ 
			| changed |
			changed := false.
			
			"we intentionally use | (OR) instead of or: [] because relaxation function must always be called"
			theArcs do: [ :arc | changed := changed | (self relaxLocations: theLocations arc: arc ) ].
	
			changed ifFalse: [ 
				originalCulprits ifNotNil: [ "Warning signal: 'something is bad'" ].
				^ true ] ].
				
		modifyOnError ifFalse: [ ^ false ]. "cannot solve with these constraints"

		culprits := Array new: theArcs size withAll: false.
				
		verticesCount timesRepeat: [ 
			arcs withIndexDo: [ :arc :index |
				| culprit |
				culprit := culprits at: index.
				"we intentionally use | (OR) instead of or: [] because relaxation function must always be called"
				culprits at: index put: (culprit | ( self relaxLocations: theLocations arc: arc ) ) ] ].

		p = 0 ifTrue: [ originalCulprits := culprits ].
				
		i := 1.
		break := false.
				
		[ i <= theArcs size and: [ break not ] ] whileTrue: [ 
			(culprits at: i) ifTrue: [ 
				| arc |
				arc := theArcs at: i.
				
				"Only remove max values, min values alone cannot be inconsistent"
				(arc span min < arc span max) ifFalse: [
					arc valid: false.
					break := true ]	 ].
				i := i + 1 ] ].
	^ true
]

{ #category : #private }
BlGridLayoutAxis >> solveAndDistributeSpaceLocations: theLocations childSizes: childSizes [
	| deltaMax deltaMin totalWeight validDelta validSolution |
	self deltas atAllPut: 0.
	self computeGroupBoundsFor: childSizes.
	self solveLocations: theLocations.
	"The children do not fit and the grid's maximum was dropped. Without it every delta below would be valid and the weights would spread the grid width over each column again, so keep the overflowing solution"
	self hasDroppedArcs ifTrue: [^self].
	deltaMax := parentMin value asInteger
				* self element children accountedByLayout size + 1.	"exclusive"
	deltaMax < 2 ifTrue: [^self].	"don't have any delta to distribute"
	deltaMin := 0.	"inclusive"
	totalWeight := self calculateTotalWeight.
	validDelta := -1.	"delta for which a solution exists"
	validSolution := true.	" do a binary search to find the max delta that won't conflict with constraints"
	[deltaMin < deltaMax] whileTrue: 
			[| delta |
			delta := (deltaMin / 2.0 + (deltaMax / 2.0)) asInteger.
			self invalidateValues.
			self shareOutDelta: delta totalWeight: totalWeight.
			self computeGroupBoundsFor: childSizes.
			validSolution := self
						solve: self arcs
						locations: theLocations
						modifyOnError: false.
			validSolution
				ifTrue: 
					[validDelta := delta.
					deltaMin := delta + 1]
				ifFalse: [deltaMax := delta]].
	(validDelta > 0 and: [validSolution not])
		ifTrue: 
			[self invalidateValues.
			self shareOutDelta: validDelta totalWeight: totalWeight.
			self computeGroupBoundsFor: childSizes.
			self solveLocations: theLocations]
]

{ #category : #'computing inequalities' }
BlGridLayoutAxis >> solveLocations: theLocations [
	^ self solve: self arcs locations: theLocations
]

{ #category : #'accessing spec' }
BlGridLayoutAxis >> specOf: anElement [
	^ self horizontal
		ifTrue: [ anElement constraints grid columnSpec ]
		ifFalse: [ anElement constraints grid rowSpec ]
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> topologicalSort: theArcs [
	| result cursor arcsByVertex visited walk |

	result := Array new: theArcs size.
	cursor := result size - 1.

	arcsByVertex := self groupArcsByFirstVertex: theArcs.
	visited := Array new: self count + 1 withAll: 0.
	
	walk := nil.
	walk := [ :loc |
		"loc is an array index starting from 1"
		| status |
		
		status := visited at: loc.
		status = NEW
			ifTrue: [
				visited at: loc put: PENDING.
				(arcsByVertex at: loc) do: [ :arc |
					walk value: arc span max + 1.
					result at: (cursor + 1) put: arc.
					cursor := cursor - 1 ].
				visited at: loc put: COMPLETE ].
		status = PENDING
			ifTrue: [ Warning signal: 'Status of visited at ', loc asString, ' should not be PENDING' ] ].
	
	1 to: arcsByVertex size
		do: [ :loc | walk value: loc ].
	
	cursor = -1
		ifFalse: [ Warning signal: 'cursor value should be 0 but was ', cursor asString ].
	
	^ result
]

{ #category : #'computing margins' }
BlGridLayoutAxis >> trailingMargins [
	
	trailingMargins
		ifNil: [ trailingMargins := Array new: (self count + 1) withAll: 0 ].
		
	trailingMarginsValid ifFalse: [ 
		self computeMargins: false.
		trailingMarginsValid := true ].
	
	^ trailingMargins
]

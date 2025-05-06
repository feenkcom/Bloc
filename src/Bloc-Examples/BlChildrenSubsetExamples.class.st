"
I provide examples for subclasses of {{gtClass:BlChildrenSubset}}.

"
Class {
	#name : #BlChildrenSubsetExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Children'
}

{ #category : #'examples - acounted-by-layout' }
BlChildrenSubsetExamples >> accountedByLayout [
	<gtExample>
	<return: #BlChildrenAccountedByLayout>
	| childrenArray childrenIterator |
	childrenArray := self childrenArrayWith5Elements.
	childrenIterator := childrenArray accountedByLayout.

	self assert: childrenIterator size equals: 3.
	self assert: childrenIterator superset equals: childrenArray.
	self assert: (childrenIterator first userData at: #index) equals: 1.
	self assert: (childrenIterator second userData at: #index) equals: 3.
	self assert: (childrenIterator third userData at: #index) equals: 5.
	self
		assert: childrenIterator asArray
		equals: {childrenArray at: 1.
				childrenArray at: 3.
				childrenArray at: 5}.

	^ childrenIterator
]

{ #category : #'examples - acounted-by-layout' }
BlChildrenSubsetExamples >> accountedByLayoutAndIgnoredByLayout [
	<gtExample>
	<return: #BlChildrenAccountedByLayout>
	| childrenIterator childrenIteratorIgnoredByLayout |
	childrenIterator := self ignoredByLayout.
	childrenIteratorIgnoredByLayout := childrenIterator accountedByLayout.

	self assert: childrenIteratorIgnoredByLayout size equals: 0.
	self assert: childrenIteratorIgnoredByLayout superset equals: childrenIterator.

	^ childrenIteratorIgnoredByLayout
]

{ #category : #'examples - acounted-by-layout' }
BlChildrenSubsetExamples >> accountedByLayoutAndReversed [
	<gtExample>
	<return: #BlChildrenReversed>
	| childrenIterator childrenIteratorReversed |
	childrenIterator := self accountedByLayout.
	childrenIteratorReversed := childrenIterator reversed.

	self assert: childrenIteratorReversed size equals: 3.
	self assert: childrenIteratorReversed superset equals: childrenIterator.
	self assert: (childrenIteratorReversed first userData at: #index) equals: 5.
	self assert: (childrenIteratorReversed second userData at: #index) equals: 3.
	self assert: (childrenIteratorReversed third userData at: #index) equals: 1.

	^ childrenIteratorReversed
]

{ #category : #'examples - acounted-by-layout' }
BlChildrenSubsetExamples >> accountedByLayoutChildrenFromElement [
	<gtExample>
	<return: #BlChildrenAccountedByLayout>
	| element accountedByLayoutChildren |
	element := self elementWithChildren.
	accountedByLayoutChildren := element children accountedByLayout.

	self assert: accountedByLayoutChildren size equals: 3.
	^ accountedByLayoutChildren
]

{ #category : #'examples - acounted-by-layout' }
BlChildrenSubsetExamples >> accountedByLayoutTwice [
	<gtExample>
	<return: #BlChildrenAccountedByLayout>
	| childrenIterator childrenIteratorAccountedByLayout |
	childrenIterator := self accountedByLayout.
	childrenIteratorAccountedByLayout := childrenIterator accountedByLayout.

	self assert: childrenIteratorAccountedByLayout == childrenIterator.

	^ childrenIteratorAccountedByLayout
]

{ #category : #'examples - children' }
BlChildrenSubsetExamples >> childrenArrayWith5Elements [
	<gtExample>
	<return: #BlChildrenArray>
	| childrenArray zIndex |
	childrenArray := BlChildrenArray new.
	1 to: 5 do: [ :index | childrenArray add: (self newChildAt: index) at: index ].
	(childrenArray at: 2) constraints ignoreByLayout.
	(childrenArray at: 4) constraints ignoreByLayout.
	zIndex := #(1 5 3 2 4).
	zIndex
		withIndexDo: [ :aZIndex :index | (childrenArray at: index) zIndex: aZIndex ].

	self assert: childrenArray size equals: 5.
	self assert: childrenArray isNotEmpty.
	self assert: (childrenArray at: 1) constraints ignoredByLayout not.
	self assert: (childrenArray at: 3) constraints ignoredByLayout not.
	self assert: (childrenArray at: 5) constraints ignoredByLayout not.
	^ childrenArray
]

{ #category : #'examples - combined' }
BlChildrenSubsetExamples >> childrenWithMultipleCombinedSubsets [
	<gtExample>
	<return: #BlChildrenReversed>
	| element children |
	element := self elementWithChildren.
	children := element children accountedByLayout reversed sortedByElevation
			reversed.

	self assert: children size equals: 3.
	self assert: (children first userData at: #index) equals: 5.
	self assert: (children second userData at: #index) equals: 3.
	self assert: (children third userData at: #index) equals: 1.
	self
		assert: children superset superset superset superset
		equals: element children.

	^ children
]

{ #category : #'examples - element' }
BlChildrenSubsetExamples >> elementWithChildren [
	<gtExample>
	<return: #BlElement>
	| element |
	element := BlElement new.
	self childrenArrayWith5Elements do: [ :aChild | element addChild: aChild ].
	self assert: element children size equals: 5.
	^ element
]

{ #category : #'examples - ignored-by-layout' }
BlChildrenSubsetExamples >> ignoredByLayout [
	<gtExample>
	<return: #BlChildrenIgnoredByLayout>
	| childrenArray childrenIterator |
	childrenArray := self childrenArrayWith5Elements.
	childrenIterator := childrenArray ignoredByLayout.

	self assert: childrenIterator size equals: 2.
	self assert: childrenIterator superset equals: childrenArray.
	self assert: (childrenIterator first userData at: #index) equals: 2.
	self assert: (childrenIterator second userData at: #index) equals: 4.
	self
		assert: childrenIterator asArray
		equals: {childrenArray at: 2.
				childrenArray at: 4}.

	^ childrenIterator
]

{ #category : #'examples - ignored-by-layout' }
BlChildrenSubsetExamples >> ignoredByLayoutAndAcountedByLayout [
	<gtExample>
	<return: #BlChildrenAccountedByLayout>
	| childrenIterator childrenIteratorAcountedByLayout |
	childrenIterator := self ignoredByLayout.
	childrenIteratorAcountedByLayout := childrenIterator accountedByLayout.

	self assert: childrenIteratorAcountedByLayout size equals: 0.
	self assert: childrenIteratorAcountedByLayout superset equals: childrenIterator.

	^ childrenIteratorAcountedByLayout
]

{ #category : #'examples - ignored-by-layout' }
BlChildrenSubsetExamples >> ignoredByLayoutAndReverse [
	<gtExample>
	<return: #BlChildrenReversed>
	| childrenIterator childrenIteratorReversed |
	childrenIterator := self ignoredByLayout.
	childrenIteratorReversed := childrenIterator reversed.

	self assert: childrenIteratorReversed size equals: 2.
	self assert: childrenIteratorReversed superset equals: childrenIterator.
	self assert: (childrenIteratorReversed first userData at: #index) equals: 4.
	self assert: (childrenIteratorReversed second userData at: #index) equals: 2.

	^ childrenIteratorReversed
]

{ #category : #'examples - ignored-by-layout' }
BlChildrenSubsetExamples >> ignoredByLayoutExplicitCreation [
	<gtExample>
	<return: #BlChildrenIgnoredByLayout>
	| childrenArray childrenIterator |
	childrenArray := self childrenArrayWith5Elements.
	childrenIterator := BlChildrenIgnoredByLayout on: childrenArray.

	self assert: childrenIterator size equals: 2.
	self assert: childrenIterator superset equals: childrenArray.
	self assert: (childrenIterator first userData at: #index) equals: 2.
	self assert: (childrenIterator second userData at: #index) equals: 4.
	self
		assert: childrenIterator asArray
		equals: {childrenArray at: 2.
				childrenArray at: 4}.

	^ childrenIterator
]

{ #category : #'examples - ignored-by-layout' }
BlChildrenSubsetExamples >> ignoredByLayoutFromElement [
	<gtExample>
	<return: #BlChildrenIgnoredByLayout>
	| element ignoredByLayoutChildren |
	element := self elementWithChildren.
	ignoredByLayoutChildren := element children ignoredByLayout.

	self assert: ignoredByLayoutChildren size equals: 2.
	^ ignoredByLayoutChildren
]

{ #category : #'examples - ignored-by-layout' }
BlChildrenSubsetExamples >> ignoredByLayoutTwice [
	<gtExample>
	<return: #BlChildrenIgnoredByLayout>
	| childrenIterator childrenIteratorIgnoredByLayout |
	childrenIterator := self ignoredByLayout.
	childrenIteratorIgnoredByLayout := childrenIterator ignoredByLayout.

	self assert: childrenIteratorIgnoredByLayout == childrenIterator.

	^ childrenIteratorIgnoredByLayout
]

{ #category : #private }
BlChildrenSubsetExamples >> newChildAt: anIndex [
	| anElement |
	anElement := BlElement new.
	anElement userData at: #index put: anIndex.
	^ anElement
]

{ #category : #'examples - reversed' }
BlChildrenSubsetExamples >> reversed [
	<gtExample>
	<return: #BlChildrenReversed>
	| childrenArray childrenIterator |
	childrenArray := self childrenArrayWith5Elements.
	childrenIterator := childrenArray reversed.

	self assert: childrenIterator size equals: 5.
	self assert: childrenIterator superset equals: childrenArray.
	1
		to: 5
		do: [ :index | 
			self
				assert: ((childrenIterator at: index) userData at: #index)
				equals: 5 - index + 1 ].

	^ childrenIterator
]

{ #category : #'examples - reversed' }
BlChildrenSubsetExamples >> reversedAndAcountedByLayout [
	<gtExample>
	<return: #BlChildrenAccountedByLayout>
	| childrenIterator childrenIteratorAcountedByLayout |
	childrenIterator := self reversed.
	childrenIteratorAcountedByLayout := childrenIterator accountedByLayout.

	self assert: childrenIteratorAcountedByLayout size equals: 3.
	self assert: childrenIteratorAcountedByLayout superset equals: childrenIterator.
	self
		assert: (childrenIteratorAcountedByLayout first userData at: #index)
		equals: 5.
	self
		assert: (childrenIteratorAcountedByLayout second userData at: #index)
		equals: 3.
	self
		assert: (childrenIteratorAcountedByLayout third userData at: #index)
		equals: 1.
	self
		assert: childrenIteratorAcountedByLayout asArray
		equals: {childrenIterator at: 1.
				childrenIterator at: 3.
				childrenIterator at: 5}.

	^ childrenIteratorAcountedByLayout
]

{ #category : #'examples - reversed' }
BlChildrenSubsetExamples >> reversedAndIgnoredByLayout [
	<gtExample>
	<return: #BlChildrenIgnoredByLayout>
	| childrenIterator childrenIteratorIgnoredByLayout |
	childrenIterator := self reversed.
	childrenIteratorIgnoredByLayout := childrenIterator ignoredByLayout.

	self assert: childrenIteratorIgnoredByLayout size equals: 2.
	self assert: childrenIteratorIgnoredByLayout superset equals: childrenIterator.
	self
		assert: (childrenIteratorIgnoredByLayout first userData at: #index)
		equals: 4.
	self
		assert: (childrenIteratorIgnoredByLayout second userData at: #index)
		equals: 2.
	self
		assert: childrenIteratorIgnoredByLayout asArray
		equals: {childrenIterator at: 2.
				childrenIterator at: 4}.

	^ childrenIteratorIgnoredByLayout
]

{ #category : #'examples - reversed' }
BlChildrenSubsetExamples >> reversedChildrenFromElement [
	<gtExample>
	<return: #BlChildrenReversed>
	| element reversedChildren |
	element := self elementWithChildren.
	reversedChildren := element children reversed.

	self assert: reversedChildren size equals: 5.
	^ reversedChildren
]

{ #category : #'examples - reversed' }
BlChildrenSubsetExamples >> reversedTwice [
	<gtExample>
	<return: #BlChildrenArray>
	| childrenIterator |
	childrenIterator := self reversed reversed.

	self assert: childrenIterator size equals: 5.
	self assert: (childrenIterator isKindOf: BlChildrenArray).	"Could be improved"
	1
		to: 5
		do: [ :index | self assert: ((childrenIterator at: index) userData at: #index) equals: index ].

	^ childrenIterator
]

{ #category : #'examples - elevation' }
BlChildrenSubsetExamples >> sortedByElevation [
	<gtExample>
	<return: #BlChildrenSortedByElevation>
	| childrenArray childrenIterator expectedOrder |
	childrenArray := self childrenArrayWith5Elements.
	childrenIterator := childrenArray sortedByElevation.

	self assert: childrenIterator size equals: 5.
	self assert: childrenIterator superset equals: childrenArray.

	expectedOrder := #(1 4 3 5 2).
	1
		to: 5
		do: [ :index | 
			self
				assert: ((childrenIterator at: index) userData at: #index)
				equals: (expectedOrder at: index) ].

	^ childrenIterator
]

{ #category : #'examples - elevation' }
BlChildrenSubsetExamples >> sortedByElevationAndAcountedByLayout [
	<gtExample>
	<return: #BlChildrenAccountedByLayout>
	| childrenIterator childrenIteratorAcountedByLayout |
	childrenIterator := self sortedByElevation.
	childrenIteratorAcountedByLayout := childrenIterator accountedByLayout.

	self assert: childrenIteratorAcountedByLayout size equals: 3.
	self assert: childrenIteratorAcountedByLayout superset equals: childrenIterator.
	self
		assert: (childrenIteratorAcountedByLayout first userData at: #index)
		equals: 1.
	self
		assert: (childrenIteratorAcountedByLayout second userData at: #index)
		equals: 3.
	self
		assert: (childrenIteratorAcountedByLayout third userData at: #index)
		equals: 5.

	^ childrenIteratorAcountedByLayout
]

{ #category : #'examples - elevation' }
BlChildrenSubsetExamples >> sortedByElevationAndIgnoredByLayout [
	<gtExample>
	<return: #BlChildrenIgnoredByLayout>
	| childrenIterator childrenIteratorIgnoredByLayout |
	childrenIterator := self sortedByElevation.
	childrenIteratorIgnoredByLayout := childrenIterator ignoredByLayout.

	self assert: childrenIteratorIgnoredByLayout size equals: 2.
	self assert: childrenIteratorIgnoredByLayout superset equals: childrenIterator.
	self
		assert: (childrenIteratorIgnoredByLayout first userData at: #index)
		equals: 4.
	self
		assert: (childrenIteratorIgnoredByLayout second userData at: #index)
		equals: 2.

	^ childrenIteratorIgnoredByLayout
]

{ #category : #'examples - elevation' }
BlChildrenSubsetExamples >> sortedByElevationAndReversed [
	<gtExample>
	<return: #BlChildrenReversed>
	| childrenIterator childrenIteratorReversed expectedOrder |
	childrenIterator := self sortedByElevation.
	childrenIteratorReversed := childrenIterator reversed.

	self assert: childrenIteratorReversed size equals: 5.
	self assert: childrenIteratorReversed superset equals: childrenIterator.

	expectedOrder := #(2 5 3 4 1).
	1
		to: 5
		do: [ :index | 
			self
				assert: ((childrenIteratorReversed at: index) userData at: #index)
				equals: (expectedOrder at: index) ].

	^ childrenIteratorReversed
]

{ #category : #'examples - elevation' }
BlChildrenSubsetExamples >> sortedByElevationFromElement [
	<gtExample>
	<return: #BlChildrenSortedByElevation>
	| element sortedByElevationChildren |
	element := self elementWithChildren.
	sortedByElevationChildren := element children sortedByElevation.

	self assert: sortedByElevationChildren size equals: 5.
	^ sortedByElevationChildren
]

{ #category : #'examples - elevation' }
BlChildrenSubsetExamples >> sortedByElevationTwice [
	<gtExample>
	<return: #BlChildrenSortedByElevation>
	| childrenIterator childrenIteratorSortedByElevation |
	childrenIterator := self sortedByElevation.
	childrenIteratorSortedByElevation := childrenIterator sortedByElevation.

	self assert: childrenIteratorSortedByElevation == childrenIterator.

	^ childrenIteratorSortedByElevation
]

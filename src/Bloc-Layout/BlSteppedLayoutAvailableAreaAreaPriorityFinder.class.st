Class {
	#name : #BlSteppedLayoutAvailableAreaAreaPriorityFinder,
	#superclass : #BlSteppedLayoutAvailableAreaChainedFinder,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #finding }
BlSteppedLayoutAvailableAreaAreaPriorityFinder >> bestPossibleArea: someAreas [
	self
		assert: [ someAreas isNotEmpty ]
		description: [ 'Possible areas must not be empty' ].

	^ someAreas detectMax: [ :eachArea | eachArea bounds area ]
]

{ #category : #testing }
BlSteppedLayoutAvailableAreaAreaPriorityFinder >> hasEnoughSpace: anArea forNode: aLayoutChildNode [
	^ anArea hasEnoughSpaceFor: aLayoutChildNode
]

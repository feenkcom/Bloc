Class {
	#name : #BlSteppedLayoutAvailableAreaHeightPriorityFinder,
	#superclass : #BlSteppedLayoutAvailableAreaChainedFinder,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #finding }
BlSteppedLayoutAvailableAreaHeightPriorityFinder >> bestPossibleArea: someAreas [
	self
		assert: [ someAreas isNotEmpty ]
		description: [ 'Possible areas must not be empty' ].

	^ someAreas detectMax: [ :eachArea | eachArea bounds width ]
]

{ #category : #testing }
BlSteppedLayoutAvailableAreaHeightPriorityFinder >> hasEnoughSpace: anArea forNode: aLayoutChildNode [
	^ anArea hasEnoughHeightFor: aLayoutChildNode
]

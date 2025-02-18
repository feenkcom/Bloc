Class {
	#name : #BlSteppedLayoutAvailableAreaWidthPriorityFinder,
	#superclass : #BlSteppedLayoutAvailableAreaChainedFinder,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #finding }
BlSteppedLayoutAvailableAreaWidthPriorityFinder >> bestPossibleArea: someAreas [
	self
		assert: [ someAreas isNotEmpty ]
		description: [ 'Possible areas must not be empty' ].

	^ someAreas detectMax: [ :eachArea | eachArea bounds height ]
]

{ #category : #testing }
BlSteppedLayoutAvailableAreaWidthPriorityFinder >> hasEnoughSpace: anArea forNode: aLayoutChildNode [
	^ anArea hasEnoughWidthFor: aLayoutChildNode
]

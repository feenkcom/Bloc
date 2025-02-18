Class {
	#name : #BlSteppedLayoutAvailableAreaFinder,
	#superclass : #Object,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #finding }
BlSteppedLayoutAvailableAreaFinder >> bestPossibleArea: someAreas [
	"Let's find the most satisfying among all given options"

	self
		assert: [ someAreas isNotEmpty ]
		description: [ 'Possible areas must not be empty' ].

	^ someAreas detectMax: [ :eachArea | eachArea bounds area ]
]

{ #category : #finding }
BlSteppedLayoutAvailableAreaFinder >> findIn: availableAreas forNode: aLayoutChildNode [
	<return: #BlSteppedLayoutArea>
	| possibleAreas |
	possibleAreas := availableAreas select: [ :eachArea | 
		self 
			hasEnoughSpace: eachArea 
			forNode: aLayoutChildNode ].

	^ possibleAreas 
		ifEmpty: [ 
			self 
				findSufficientIn: availableAreas 
				forNode: aLayoutChildNode ]
		ifNotEmpty: [ self bestPossibleArea: possibleAreas ].
]

{ #category : #finding }
BlSteppedLayoutAvailableAreaFinder >> findSufficientIn: availableAreas forNode: aLayoutChildNode [
	"There is not satisfying area, let's use less demanding conditions."

	<return: #BlSteppedLayoutArea>
	^ availableAreas detectMax: [ :eachArea | eachArea bounds area ]
]

{ #category : #testing }
BlSteppedLayoutAvailableAreaFinder >> hasEnoughSpace: anArea forNode: aLayoutChildNode [
	^ anArea hasEnoughSpaceFor: aLayoutChildNode
]

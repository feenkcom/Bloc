"
I return an {{gtClass:BlSteppedLayoutArea}} with enough height for a given {{gtClass:BlLayoutChildNode}}. 
"
Class {
	#name : #BlSteppedLayoutSuboptimalAreaHeightPriorityFinder,
	#superclass : #BlSteppedLayoutSuboptimalAreaChainedFinder,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #finding }
BlSteppedLayoutSuboptimalAreaHeightPriorityFinder >> bestPossibleArea: someAreas [
	self
		assert: [ someAreas isNotEmpty ]
		description: [ 'Possible areas must not be empty' ].

	^ someAreas detectMax: [ :eachArea | eachArea bounds width ]
]

{ #category : #testing }
BlSteppedLayoutSuboptimalAreaHeightPriorityFinder >> hasEnoughSpace: anArea forNode: aLayoutChildNode [
	^ anArea hasEnoughHeightFor: aLayoutChildNode
]

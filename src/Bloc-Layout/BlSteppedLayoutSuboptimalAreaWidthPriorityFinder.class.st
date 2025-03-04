"
I return an {{gtClass:BlSteppedLayoutArea}} with enough width for a given {{gtClass:BlLayoutChildNode}}. 
"
Class {
	#name : #BlSteppedLayoutSuboptimalAreaWidthPriorityFinder,
	#superclass : #BlSteppedLayoutSuboptimalAreaChainedFinder,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #finding }
BlSteppedLayoutSuboptimalAreaWidthPriorityFinder >> bestPossibleArea: someAreas [
	self
		assert: [ someAreas isNotEmpty ]
		description: [ 'Possible areas must not be empty' ].

	^ someAreas detectMax: [ :eachArea | eachArea bounds height ]
]

{ #category : #testing }
BlSteppedLayoutSuboptimalAreaWidthPriorityFinder >> hasEnoughSpace: anArea forNode: aLayoutChildNode [
	^ anArea hasEnoughWidthFor: aLayoutChildNode
]

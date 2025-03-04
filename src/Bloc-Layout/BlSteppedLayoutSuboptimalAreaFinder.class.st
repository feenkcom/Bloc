"
I am looking for a sub-optimal {{gtClass:BlSteppedLayoutArea}} for a given {{gtClass:BlLayoutChildNode}}.

"
Class {
	#name : #BlSteppedLayoutSuboptimalAreaFinder,
	#superclass : #Object,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #finding }
BlSteppedLayoutSuboptimalAreaFinder >> bestPossibleArea: someAreas [
	"Return the most suitable layout area among all given areas"

	<return: #BlSteppedLayoutArea>
	self
		assert: [ someAreas isNotEmpty ]
		description: [ 'Possible areas must not be empty' ].

	^ someAreas detectMax: [ :eachArea | eachArea bounds area ]
]

{ #category : #finding }
BlSteppedLayoutSuboptimalAreaFinder >> findIn: availableAreas forNode: aLayoutChildNode [
	"Find and return a suboptimal layout area:
	- among available areas,
	- for a given child node."

	<return: #BlSteppedLayoutArea>
	| possibleAreas |
	
	"1. Select all suboptimal layout areas."
	possibleAreas := availableAreas select: [ :eachArea | 
		self 
			hasEnoughSpace: eachArea 
			forNode: aLayoutChildNode ].

	"2. Find the most suitable layout area:
	- amont possible areas,
	- for a given child node."
	^ possibleAreas 
		ifEmpty: [ 
			"2a. There is no suitable layout area.
			     Let's use less demanding condition."
			self 
				findSufficientIn: availableAreas 
				forNode: aLayoutChildNode ]
		ifNotEmpty: [
			"2b. There are some suitable layout areas.
			     Let's select the most suitable one."
			self bestPossibleArea: possibleAreas ].
]

{ #category : #finding }
BlSteppedLayoutSuboptimalAreaFinder >> findSufficientIn: availableAreas forNode: aLayoutChildNode [
	"There is no suitable area, let's use less demanding conditions."

	<return: #BlSteppedLayoutArea>
	^ availableAreas detectMax: [ :eachArea | eachArea bounds area ]
]

{ #category : #testing }
BlSteppedLayoutSuboptimalAreaFinder >> hasEnoughSpace: anArea forNode: aLayoutChildNode [
	"Return true if the layout area is suitable for a given child node
	and therefore the child node could be place in this layout area."

	<return: #Boolean>
	^ anArea hasEnoughSpaceFor: aLayoutChildNode
]

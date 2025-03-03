"
If I do not find a sub-optimal {{gtClass:BlSteppedLayoutArea}} for a given {{gtClass:BlLayoutChildNode}}, I redirect the search to other {{gtClass:BlSteppedLayoutSuboptimalAreaFinder}} instances. 
"
Class {
	#name : #BlSteppedLayoutSuboptimalAreaChainedFinder,
	#superclass : #BlSteppedLayoutSuboptimalAreaFinder,
	#instVars : [
		'nextFinder'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #finding }
BlSteppedLayoutSuboptimalAreaChainedFinder >> findSufficientIn: availableAreas forNode: aLayoutChildNode [
	"There is no suitable area, let's use another area finder."

	<return: #BlSteppedLayoutArea>
	^ self nextFinder findIn: availableAreas forNode: aLayoutChildNode
]

{ #category : #accessing }
BlSteppedLayoutSuboptimalAreaChainedFinder >> nextFinder [
	<return: #BlSteppedLayoutSuboptimalAreaFinder>
	^ nextFinder ifNil: [ nextFinder := BlSteppedLayoutSuboptimalAreaFinder new ]
]

{ #category : #accessing }
BlSteppedLayoutSuboptimalAreaChainedFinder >> nextFinder: aSuboptimalAreaFinder [
	nextFinder := aSuboptimalAreaFinder
]

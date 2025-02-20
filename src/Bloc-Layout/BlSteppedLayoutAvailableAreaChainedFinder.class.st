Class {
	#name : #BlSteppedLayoutAvailableAreaChainedFinder,
	#superclass : #BlSteppedLayoutAvailableAreaFinder,
	#instVars : [
		'nextFinder'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #finding }
BlSteppedLayoutAvailableAreaChainedFinder >> findSufficientIn: availableAreas forNode: aLayoutChildNode [
	"There is not satisfying area, let's use less demanding conditions."

	<return: #BlSteppedLayoutArea>
	^ self nextFinder findIn: availableAreas forNode: aLayoutChildNode
]

{ #category : #accessing }
BlSteppedLayoutAvailableAreaChainedFinder >> nextFinder [
	^ nextFinder ifNil: [ nextFinder := BlSteppedLayoutAvailableAreaFinder new ]
]

{ #category : #accessing }
BlSteppedLayoutAvailableAreaChainedFinder >> nextFinder: anObject [
	nextFinder := anObject
]

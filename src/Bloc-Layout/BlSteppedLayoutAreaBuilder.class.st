Class {
	#name : #BlSteppedLayoutAreaBuilder,
	#superclass : #Object,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#instVars : [
		'area',
		'boundsBlock'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #accessing }
BlSteppedLayoutAreaBuilder >> bounds [
	^ boundsBlock
]

{ #category : #accessing }
BlSteppedLayoutAreaBuilder >> bounds: aBlock [
	boundsBlock := aBlock
]

{ #category : #'api - building' }
BlSteppedLayoutAreaBuilder >> buildFor: aState [
	<return: #BlSteppedLayoutArea>
	| aNewArea aBounds |
	aNewArea := area copy.

	aBounds := boundsBlock cull: aState.
	self 
		assert: [ aBounds isNotNil ]
		description: [ 'Area bounds must be non-nil: {1}' format: { boundsBlock } ].
	aNewArea bounds: aBounds.
	
	^ aNewArea
]

{ #category : #'api - direction' }
BlSteppedLayoutAreaBuilder >> direction: aSymbol [
	area direction: aSymbol
]

{ #category : #'api - direction' }
BlSteppedLayoutAreaBuilder >> directionLeft [
	area direction: #left
]

{ #category : #'api - direction' }
BlSteppedLayoutAreaBuilder >> directionRight [
	area direction: #right
]

{ #category : #accessing }
BlSteppedLayoutAreaBuilder >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ area horizontalAlignment
]

{ #category : #accessing }
BlSteppedLayoutAreaBuilder >> horizontalAlignment: aBlElementAlignment [
	area horizontalAlignment: aBlElementAlignment
]

{ #category : #initialization }
BlSteppedLayoutAreaBuilder >> initialize [
	super initialize.
	area := BlSteppedLayoutArea new.
	boundsBlock := [ :aState | (aState occupiedBounds corner corner: aState containerWidth @ aState containerHeight) ]
]

{ #category : #accessing }
BlSteppedLayoutAreaBuilder >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ area verticalAlignment
]

{ #category : #accessing }
BlSteppedLayoutAreaBuilder >> verticalAlignment: aBlElementAlignment [
	area verticalAlignment: aBlElementAlignment
]

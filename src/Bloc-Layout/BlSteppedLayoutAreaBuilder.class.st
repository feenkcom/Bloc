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

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> allToLeft [
	^ self new
		direction: #left;
		alignBottomRight;
		bounds: [ :aState | 0 @ 0 corner: aState occupiedBounds left @ aState containerHeight ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> allToRight [
	^ self new
		direction: #right;
		alignBottomLeft;
		bounds: [ :aState | 
			aState occupiedBounds right @ 0
				corner: aState containerWidth @ aState containerHeight ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> contextMenuBottomLeft [
	^ self new
		direction: #left;
		alignTopRight;
		bounds: [ :aState | 
			0 @ aState occupiedBounds bottom
				corner: aState occupiedBounds left @ aState containerHeight ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> contextMenuBottomRight [
	^ self new
		direction: #right;
		alignTopLeft;
		bounds: [ :aState | 
			aState occupiedBounds corner
				corner: aState containerWidth @ aState containerHeight ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> dropdownAllToBottom [
	^ self new
		direction: #right;
		alignBottomLeft;
		bounds: [ :aState | 
			0 @ aState occupiedBounds bottom
				corner: aState containerWidth @ aState containerHeight ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> dropdownAllToUp [
	^ self new
		direction: #right;
		alignBottomLeft;
		bounds: [ :aState | 0 @ 0 corner: aState containerWidth @ aState occupiedBounds top ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> dropdownBottomLeft [
	^ self new
		direction: #left;
		alignTopRight;
		bounds: [ :aState | 
			"Hot patch: we do `bottom - 1` due to BlChildrenWrappingGeometry."
			0 @ (aState occupiedBounds bottom - 1)
				corner: aState occupiedBounds right @ aState containerHeight ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> dropdownBottomRight [
	^ self new
		direction: #right;
		alignTopLeft;
		bounds: [ :aState | 
			"Hot patch: we do `bottom - 1` due to BlChildrenWrappingGeometry."
			(aState occupiedBounds bottomLeft - (0@1))
				corner: aState containerWidth @ aState containerHeight ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> dropdownUpLeft [
	^ self new
		direction: #left;
		alignBottomRight;
		bounds: [ :aState | 0 @ 0 corner: aState occupiedBounds right @ aState occupiedBounds top ]
]

{ #category : #factory }
BlSteppedLayoutAreaBuilder class >> dropdownUpRight [
	^ self new
		direction: #right;
		alignBottomLeft;
		bounds: [ :aState | 
			aState occupiedBounds left @ 0
				corner: aState containerWidth @ aState occupiedBounds top ]
]

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

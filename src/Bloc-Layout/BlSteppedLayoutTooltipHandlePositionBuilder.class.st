Class {
	#name : #BlSteppedLayoutTooltipHandlePositionBuilder,
	#superclass : #Object,
	#traits : 'TBlSteppedLayoutMarkVisitor',
	#classTraits : 'TBlSteppedLayoutMarkVisitor classTrait',
	#instVars : [
		'mark',
		'anchorBounds',
		'handleExtent'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #accessing }
BlSteppedLayoutTooltipHandlePositionBuilder >> anchorBounds [
	^ anchorBounds
]

{ #category : #accessing }
BlSteppedLayoutTooltipHandlePositionBuilder >> anchorBounds: anObject [
	anchorBounds := anObject
]

{ #category : #building }
BlSteppedLayoutTooltipHandlePositionBuilder >> bottomCenterPosition [
	| anchorCenterX handlePositionX handlePositionY |
	anchorCenterX := anchorBounds center x.
	handlePositionX := anchorCenterX - (handleExtent x / 2).
	handlePositionY := anchorBounds bottom.
	^ handlePositionX @ handlePositionY
]

{ #category : #building }
BlSteppedLayoutTooltipHandlePositionBuilder >> build [
	^ self visitMark: mark
]

{ #category : #building }
BlSteppedLayoutTooltipHandlePositionBuilder >> centerLeftPosition [
	| anchorCenterY handlePositionX handlePositionY |
	anchorCenterY := anchorBounds center y.
	handlePositionX := anchorBounds left - handleExtent x.
	handlePositionY := anchorCenterY - (handleExtent y / 2).
	^ handlePositionX @ handlePositionY
]

{ #category : #building }
BlSteppedLayoutTooltipHandlePositionBuilder >> centerRightPosition [
	| anchorCenterY handlePositionX handlePositionY |
	anchorCenterY := anchorBounds center y.
	handlePositionX := anchorBounds right.
	handlePositionY := anchorCenterY - (handleExtent y / 2).
	^ handlePositionX @ handlePositionY
]

{ #category : #accessing }
BlSteppedLayoutTooltipHandlePositionBuilder >> handleExtent [
	^ handleExtent
]

{ #category : #accessing }
BlSteppedLayoutTooltipHandlePositionBuilder >> handleExtent: anObject [
	handleExtent := anObject
]

{ #category : #accessing }
BlSteppedLayoutTooltipHandlePositionBuilder >> mark [
	<return: #BlSteppedLayoutMark>
	^ mark
]

{ #category : #accessing }
BlSteppedLayoutTooltipHandlePositionBuilder >> mark: anObject [
	mark := anObject
]

{ #category : #building }
BlSteppedLayoutTooltipHandlePositionBuilder >> upCenterPosition [
	| anchorCenterX handlePositionX handlePositionY |
	anchorCenterX := anchorBounds center x.
	handlePositionX := anchorCenterX - (handleExtent x / 2).
	handlePositionY := anchorBounds top - handleExtent y.
	^ handlePositionX @ handlePositionY
]

{ #category : #visiting }
BlSteppedLayoutTooltipHandlePositionBuilder >> visitSteppedLayoutAllToBottomMark: aMark [
	^ self bottomCenterPosition
]

{ #category : #visiting }
BlSteppedLayoutTooltipHandlePositionBuilder >> visitSteppedLayoutAllToLeftMark: aMark [
	^ self centerLeftPosition
]

{ #category : #visiting }
BlSteppedLayoutTooltipHandlePositionBuilder >> visitSteppedLayoutAllToRightMark: aMark [
	^ self centerRightPosition
]

{ #category : #visiting }
BlSteppedLayoutTooltipHandlePositionBuilder >> visitSteppedLayoutAllToUpMark: aMark [
	^ self upCenterPosition
]

{ #category : #visiting }
BlSteppedLayoutTooltipHandlePositionBuilder >> visitSteppedLayoutBottomLeftMark: aMark [
	^ self bottomCenterPosition
]

{ #category : #visiting }
BlSteppedLayoutTooltipHandlePositionBuilder >> visitSteppedLayoutBottomRightMark: aMark [
	^ self bottomCenterPosition
]

{ #category : #visiting }
BlSteppedLayoutTooltipHandlePositionBuilder >> visitSteppedLayoutMark: aMark [
	^ self bottomCenterPosition
]

{ #category : #visiting }
BlSteppedLayoutTooltipHandlePositionBuilder >> visitSteppedLayoutUpLeftMark: aMark [
	^ self upCenterPosition
]

{ #category : #visiting }
BlSteppedLayoutTooltipHandlePositionBuilder >> visitSteppedLayoutUpRightMark: aMark [
	^ self upCenterPosition
]

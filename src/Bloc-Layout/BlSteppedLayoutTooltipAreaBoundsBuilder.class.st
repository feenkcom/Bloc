Class {
	#name : #BlSteppedLayoutTooltipAreaBoundsBuilder,
	#superclass : #Object,
	#instVars : [
		'layoutState'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #accessing }
BlSteppedLayoutTooltipAreaBoundsBuilder >> layoutState [
	^ layoutState
]

{ #category : #accessing }
BlSteppedLayoutTooltipAreaBoundsBuilder >> layoutState: anObject [
	^ layoutState := anObject
]

{ #category : #factory }
BlSteppedLayoutTooltipAreaBoundsBuilder >> minProtrudingWidth [
	| aLeftSpace aRightSpace |
	aLeftSpace := self layoutState anchorLeft max: 0.
	aRightSpace := self layoutState containerWidthWithPadding
			- self layoutState anchorRight max: 0.
	^ aLeftSpace min: aRightSpace
]

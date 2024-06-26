Class {
	#name : #BlFrameLayoutConstraintsVertical,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'alignment',
		'weight'
	],
	#category : #'Bloc-Layout-Frame'
}

{ #category : #alignment }
BlFrameLayoutConstraintsVertical >> alignBottom [
	alignment := BlElementAlignment vertical end
]

{ #category : #alignment }
BlFrameLayoutConstraintsVertical >> alignBottomAt: aUnitCoordinateNumber [
	"Align the bottom of the element vertically with a unit-coordinate inside of the parent"

	alignment := BlVerticalCoordinateBottomAlignment new
		coordinate: aUnitCoordinateNumber;
		relativeAlignment: BlElementAlignment vertical end
]

{ #category : #alignment }
BlFrameLayoutConstraintsVertical >> alignCenter [
	"I align the center of the child element vertically with the center of the parent"

	alignment := BlElementAlignment vertical center
]

{ #category : #alignment }
BlFrameLayoutConstraintsVertical >> alignCenterAt: aUnitCoordinateNumber [
	"Align the center of the element vertically with a unit-coordinate inside of the parent"

	self alignCenterAt: aUnitCoordinateNumber offset: 0
]

{ #category : #alignment }
BlFrameLayoutConstraintsVertical >> alignCenterAt: aUnitCoordinateNumber offset: anOffsetNumber [
	"Align the center of the element vertically with a unit-coordinate inside of the parent additionally moving it by a given offset in points"

	alignment := BlVerticalCoordinateTopAlignment new
		coordinate: aUnitCoordinateNumber;
		offset: anOffsetNumber;
		relativeAlignment: BlElementAlignment vertical center
]

{ #category : #alignment }
BlFrameLayoutConstraintsVertical >> alignNone [
	alignment := BlElementAlignment vertical null
]

{ #category : #alignment }
BlFrameLayoutConstraintsVertical >> alignTop [
	alignment := BlElementAlignment vertical start
]

{ #category : #alignment }
BlFrameLayoutConstraintsVertical >> alignTopAt: aUnitCoordinateNumber [
	"Align the top of the element vertically with a unit-coordinate inside of the parent"

	alignment := BlVerticalCoordinateTopAlignment new
		coordinate: aUnitCoordinateNumber;
		relativeAlignment: BlElementAlignment vertical start
]

{ #category : #accessing }
BlFrameLayoutConstraintsVertical >> alignment [
	^ alignment
]

{ #category : #alignment }
BlFrameLayoutConstraintsVertical >> alignment: aBlElementAlignment [
	alignment := aBlElementAlignment
]

{ #category : #initialization }
BlFrameLayoutConstraintsVertical >> initialize [
	super initialize.

	alignment := BlElementAlignment vertical start.
	weight := 1.0
]

{ #category : #accessing }
BlFrameLayoutConstraintsVertical >> weight [
	<return: #Number>

	^ weight
]

{ #category : #accessing }
BlFrameLayoutConstraintsVertical >> weight: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Weight can not be nil' ].
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Weight can not be negative' ].

	weight := aNumber
]

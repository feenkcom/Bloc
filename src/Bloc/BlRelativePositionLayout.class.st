Class {
	#name : #BlRelativePositionLayout,
	#superclass : #BlLayout,
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #accessing }
BlRelativePositionLayout class >> constraints [
	^ BlRelativePositionLayoutConstraints new
]

{ #category : #accessing }
BlRelativePositionLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdater [

	| paddingLeft paddingRight paddingTop paddingBottom width height |
	anElement children accountedByLayout do: [ :child |
		| childLayoutBounds extent percent |
		extent := aRectangle extent.
		"extent := 500@500."
		paddingLeft := anElement insets left.
		paddingRight := anElement insets right.
		paddingTop := anElement insets top.
		paddingBottom := anElement insets bottom.
		width := extent x - paddingLeft - paddingRight.
		height := extent y - paddingTop - paddingBottom.
		
		percent := child constraints relativePosition percent.
		childLayoutBounds := width @ height * percent extent: child measuredExtent.
		child applyLayoutIn: childLayoutBounds context: aBlElementBoundsUpdater ].

	self layoutIgnored: anElement context: aBlElementBoundsUpdater
]

{ #category : #accessing }
BlRelativePositionLayout >> measure: anElement with: anExtentSpec [
	super measure: anElement with: anExtentSpec.
	"anElement measuredExtent: (anExtentSpec sizeFor: 0.0@0.0).
	"self measureIgnored: anElement with: anExtentSpec
]

Class {
	#name : #BlViewportAwareVerticalLayout,
	#superclass : #BlLayout,
	#category : #'Bloc-Layout-Viewport'
}

{ #category : #'as yet unclassified' }
BlViewportAwareVerticalLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdater [

	anElement children accountedByLayout do: [ :child |
		child applyLayoutIn: child measuredBounds asRectangle context: aBlElementBoundsUpdater ].

	self layoutIgnored: anElement context: aBlElementBoundsUpdater
]

{ #category : #'as yet unclassified' }
BlViewportAwareVerticalLayout >> measure: anElement with: anExtentSpec [
	| children viewport maxWidth totalHeight viewportOffset firstChildHeight |

	children := anElement children accountedByLayout.
	
	viewport := anExtentSpec viewport.
	viewportOffset := 0.
	
	children at: 2 ifPresent: [ :aSecondChild |
		self
			measureChild: aSecondChild
			parentSpec: anExtentSpec.
			
		viewport ifNotNil: [ :aViewport |
			viewportOffset := aSecondChild measuredExtent y.
			viewport := aViewport shrunkFromBottomBy: viewportOffset ] ].
	
	firstChildHeight := 0.
	totalHeight := 0.
	
	children at: 1 ifPresent: [ :aFirstChild |
		self
			measureChild: aFirstChild
			parentSpec: anExtentSpec
			viewport: viewport.
		
		firstChildHeight := aFirstChild measuredHeight.
		aFirstChild measuredBounds position: 0 @ 0 ].

	children at: 2 ifPresent: [ :aSecondChild |
		| aSecondChildPosition |
		
		aSecondChildPosition := firstChildHeight.
		viewport
			ifNotNil: [ :aViewport |
			 	| aViewportPosition |
			 	
			 	aViewportPosition := aViewport bounds bottom - aSecondChild measuredHeight.
			 	aSecondChildPosition := aSecondChildPosition min: aViewportPosition.
		].
		
		aSecondChild measuredBounds position: 0 @ aSecondChildPosition.
		
		totalHeight := aSecondChild measuredBounds bottom.
	].
	
			
	maxWidth := 0.
	
	children
		do:[ :eachChild |
			maxWidth := maxWidth max: eachChild measuredWidth ].

	anElement measuredExtent: (anExtentSpec sizeFor: maxWidth @ totalHeight).
	
	self measureIgnored: anElement with: anExtentSpec
]

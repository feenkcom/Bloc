Extension { #name : #BlBlurBelowEffect }

{ #category : #'*Bloc-Compositor' }
BlBlurBelowEffect >> paintOn: aCompositorPainter offset: anOffset for: anElement thenPaint: aBlock [
	aCompositorPainter
		pushFilterBelow: (anElement geometry pathOnSpartaCanvas: aCompositorPainter canvas of: anElement)
		filter: (BlCompositionBlurFilter radius: self radius)
		offset: anOffset
		bounds: anElement invalidationBounds
		compositing: BlCompositingSeparateLayerMode uniqueInstance
		thenPaint: aBlock
]

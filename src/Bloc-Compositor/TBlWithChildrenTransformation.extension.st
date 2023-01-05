Extension { #name : #TBlWithChildrenTransformation }

{ #category : #'*Bloc-Compositor' }
TBlWithChildrenTransformation >> paintChildrenOn: aCompositorPainter offset: anOffset [

	self childrenTransformation isIdentity
		ifTrue: [ super paintChildrenOn: aCompositorPainter offset: anOffset ]
		ifFalse: [
			aCompositorPainter
				pushTransform: self childrenTransformation matrix
				offset: anOffset
				bounds: self invalidationBounds
				compositing: self compositingMode
				thenPaint: [ :aTransformCompositorPainter :aTransformOffset |
					super paintChildrenOn: aTransformCompositorPainter offset: aTransformOffset ] ]
]

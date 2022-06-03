Extension { #name : #BlAffineTransformation }

{ #category : #'*Bloc-Extensions' }
BlAffineTransformation >> gtInspectorMatrixIn: aComposite [
	<gtInspectorPresentationOrder: 2>
	
	^ self asMatrix gtInspectorMatrixIn: aComposite
]

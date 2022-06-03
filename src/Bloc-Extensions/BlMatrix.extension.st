Extension { #name : #BlMatrix }

{ #category : #'*Bloc-Extensions' }
BlMatrix >> gtInspectorDecompositionIn: aComposite [
	<gtInspectorPresentationOrder: 2>
	
	^ self decomposition gtInspectorDecompositionIn: aComposite
]

{ #category : #'*Bloc-Extensions' }
BlMatrix >> gtInspectorRecompositionIn: aComposite [
	<gtInspectorPresentationOrder: 3>
	
	^ self decomposition gtInspectorCompositionIn: aComposite
]

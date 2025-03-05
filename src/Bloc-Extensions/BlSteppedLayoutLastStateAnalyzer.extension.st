Extension { #name : #BlSteppedLayoutLastStateAnalyzer }

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutLastStateAnalyzer >> gtAreasPreviewFor: aView context: aPhlowContext [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 4;
		stencil: [
			BlSteppedLayoutStatePreviewElement new
				layoutState: self layoutState;
				previewElement: self previewElement;
				phlowContext: aPhlowContext;
				updateElement. ]
]

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutLastStateAnalyzer >> previewElement [
	^ menuContainer
		ifNotNil: [ :aContainer | aContainer parent ifNotNil: [ :aParent | aParent gtPreviewElement ] ]
]

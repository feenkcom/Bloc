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
BlSteppedLayoutLastStateAnalyzer >> gtLayoutStateInfoFor: aView [
	<gtView>
	layoutState ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Info';
		object: [ layoutState ];
		view: #gtInfoFor:
]

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutLastStateAnalyzer >> gtLayoutStateOccupiedAreasFor: aView [
	<gtView>
	layoutState ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Occupied areas';
		object: [ layoutState ];
		view: #gtOccupiedAreasFor:
]

{ #category : #'*Bloc-Extensions' }
BlSteppedLayoutLastStateAnalyzer >> previewElement [
	^ menuContainer
		ifNotNil: [ :aContainer | aContainer parent ifNotNil: [ :aParent | aParent gtPreviewElement ] ]
]

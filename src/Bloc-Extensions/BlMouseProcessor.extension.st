Extension { #name : #BlMouseProcessor }

{ #category : #'*Bloc-Extensions' }
BlMouseProcessor >> gtLastClickEventPickedElementFor: aView [
	<gtView>
	
	lastClickEvent ifNil: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Last click picked element';
		priority: 10;
		stencil: [ self gtPickedElementPreviewForEvent: lastClickEvent ]
]

{ #category : #'*Bloc-Extensions' }
BlMouseProcessor >> gtPickedElementPreviewForEvent: anEvent [
	| aTopContainer aContainer aPickedElement anElementPosition aClickPosition |
	aTopContainer := BlElement new
			layout: BlFrameLayout new;
			padding: (BlInsets all: 10);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ].
				
	anEvent ifNil: [ ^ aTopContainer ].
				
	aContainer := BlElement new
			layout: BlFrameLayout new;
			background: Color white;
			aptitude: BrShadowAptitude new;
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ].


	aPickedElement := self processPicking: anEvent.
	anElementPosition := aPickedElement bounds inSpace position.
	aClickPosition := anEvent position - anElementPosition - (6 @ 6).

	aContainer addChild: aPickedElement gtPreviewElement.
	aContainer
		addChild: (BlElement new
				geometry: BlCircleGeometry new;
				size: 12 @ 12;
				constraintsDo: [ :c | c ignoreByLayout ];
				background: (Color white alpha: 0.25);
				border: (BlBorder paint: (Color blue alpha: 0.5) width: 1);
				relocate: aClickPosition).

	aTopContainer addChild: aContainer.
	^ aTopContainer asScalableElement maxScale: 1.0
]

{ #category : #'*Bloc-Extensions' }
BlMouseProcessor >> gtPreviousMouseDownEventPickedElementFor: aView [
	<gtView>
	
	previousMouseDownEvent ifNil: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Previous mouse down picked element';
		priority: 11;
		stencil: [ self gtPickedElementPreviewForEvent: previousMouseDownEvent ]
]

Extension { #name : #BlCompositionPrototypeTiledLayer }

{ #category : #'*Bloc-Extensions' }
BlCompositionPrototypeTiledLayer >> gtPreviewFor: aView [
	<gtView>
	
	^ aView sparta
		title: 'Preview';
		priority: 1;
		matchParent;
		embellisher: [ :anElement |
			anElement
				when: BlMouseWheelEvent
				do: [ :anEvent |
					anEvent consumed: true.
					self viewportCameraPosition: self viewportCameraPosition + (anEvent vector x @ anEvent vector y negated).
					anElement invalidate
				]
		];
		rendering: [ :aCanvas :anElement |
			aCanvas transform
				by: [ :t | t translateBy: (anElement extent - self viewportExtent) / 2.0 ]
				during: [ self drawPreviewOn: aCanvas element: anElement ] ];
		actionButtonIcon: BrGlamorousVectorIcons zoomin
			tooltip: 'Zoom in'
			action: [ :aButton :aTab |
				| aSpartaElement |
				aSpartaElement := (aTab parentTabGroup query // BlSpartaElement) anyOne.
				aSpartaElement addAnimation: (BlNumberTransition new
					onStepDo: [ :aScaleFactor :anElement |
						self scaleIn: aScaleFactor.
						anElement invalidate ];
					from: self scale;
					to: self nextZoomLevel;
					duration: 500 milliSeconds) ];
		actionButtonIcon: BrGlamorousVectorIcons zoomout
			tooltip: 'Zoom out'
			action: [ :aButton :aTab |
				| aSpartaElement |
				aSpartaElement := (aTab parentTabGroup query // BlSpartaElement) anyOne.
				aSpartaElement addAnimation: (BlNumberTransition new
					onStepDo: [ :aScaleFactor :anElement |
						self scaleOut: aScaleFactor.
						anElement invalidate ];
					from: self scale;
					to: self previousZoomLevel;
					duration: 500 milliSeconds) ]
]

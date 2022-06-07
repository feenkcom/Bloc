Extension { #name : #BlStrokeLineJoin }

{ #category : #'*Bloc-Extensions' }
BlStrokeLineJoin >> gtPreviewFor: aView [
	<gtView>
	
	self class = BlStrokeLineCap
		ifTrue: [ ^ aView empty ].
	
	^ aView sparta
		title: 'Preview' translated;
		priority: 11;
		matchParent;
		rendering: [ :aCanvas :anElement | | path width |
			width :=  40.
			path := aCanvas path
				absolute;
				moveTo: width @ (anElement extent y / 5.0 * 4.0);
				lineTo: (anElement extent x / 2) @ (anElement extent y / 4.0);
				lineTo: (anElement extent x - width) @ (anElement extent y / 5.0 * 4.0);
				finish.

			aCanvas stroke
				paint: (Color veryVeryDarkGray alpha: 0.8);
				path: path;
				width: width;
				in: [ :aStrokePainter | self applyOn: aStrokePainter ];
				draw.

			aCanvas stroke
				paint: (Color fromHexString: '00b0ff');
				path: path;
				width: 2;
				draw.
				
			aCanvas fill
				paint: (Color fromHexString: '00b0ff');
				path: (aCanvas shape circleAt: (anElement extent x / 2) @ (anElement extent y / 4.0 + 1) radius: 5);
				draw ]
]

Extension { #name : #BlStrokeLineCap }

{ #category : #'*Bloc-Extensions' }
BlStrokeLineCap >> gtPreviewFor: aView [
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
				moveTo: (anElement extent / (8.0 @ 2.0)) - (0 @ (width));
				lineTo: (anElement extent / ((8.0 / 7.0) @ 2.0))  - (0 @ (width));
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
				path: (aCanvas shape circleAt: (anElement extent / (8.0 @ 2.0))  - (0 @ (width)) radius: 5);
				draw.
				
			aCanvas fill
				paint: (Color fromHexString: '00b0ff');
				path: (aCanvas shape circleAt: (anElement extent / ((8.0 / 7.0) @ 2.0)) - (0 @ (width)) radius: 5);
				draw ]
]

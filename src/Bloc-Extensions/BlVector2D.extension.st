Extension { #name : #BlVector2D }

{ #category : #'*Bloc-Extensions' }
BlVector2D >> gtDegreeFor: aView [
	<gtView>
	^ aView explicit
		title: 'Degree';
		priority: 1;
		stencil: [ | vectorXPoint vectorYPoint container circle line lineX completeLineX dashedLineX lineY completeLineY dashedLineY list vector |
			vector := self.
			vectorXPoint := 100 + (100 * vector radians cos).
			vectorYPoint := 100 - (100 * vector radians sin).


			container := BrHorizontalPane new fitContent margin: (BlInsets all: 10).
			circle := BlElement new
					layout: BlFrameLayout new;
					geometry: BlCircleGeometry new;
					border: (BlBorder paint: Color veryLightGray width: 1);
					constraintsDo: [ :c | 
						c horizontal exact: 200.
						c vertical exact: 200 ].
			line := BlLineElement new
					border: (BlBorder paint: Color blue width: 1);
					fromAnchor: (BlAbsolutePositionAnchor position: 100 @ 100);
					toAnchor: (BlAbsolutePositionAnchor position: vectorXPoint @ vectorYPoint).
			lineX := BlLineElement new
					border: (BlBorder paint: Color black width: 1);
					fromAnchor: (BlAbsolutePositionAnchor position: 100 @ 100);
					toAnchor: (BlAbsolutePositionAnchor position: vectorXPoint @ 100).
			completeLineX := BlLineElement new
					border: (BlBorder paint: Color veryLightGray width: 1);
					fromAnchor: (BlAbsolutePositionAnchor position: 0 @ 100);
					toAnchor: (BlAbsolutePositionAnchor position: 200 @ 100).
			dashedLineX := BlLineElement new
					border: (BlBorder builder
							dashed;
							paint: Color veryLightGray;
							build);
					fromAnchor: (BlAbsolutePositionAnchor position: vectorXPoint @ vectorYPoint);
					toAnchor: (BlAbsolutePositionAnchor position: vectorXPoint @ 100).
			lineY := BlLineElement new
					border: (BlBorder paint: Color black width: 1);
					fromAnchor: (BlAbsolutePositionAnchor position: 100 @ 100);
					toAnchor: (BlAbsolutePositionAnchor position: 100 @ vectorYPoint).
			completeLineY := BlLineElement new
					border: (BlBorder paint: Color veryLightGray width: 1);
					fromAnchor: (BlAbsolutePositionAnchor position: 100 @ 0);
					toAnchor: (BlAbsolutePositionAnchor position: 100 @ 200).
			dashedLineY := BlLineElement new
					border: (BlBorder builder
							dashed;
							paint: Color veryLightGray;
							build);
					fromAnchor: (BlAbsolutePositionAnchor position: vectorXPoint @ vectorYPoint);
					toAnchor: (BlAbsolutePositionAnchor position: 100 @ vectorYPoint).

			list := BrColumnedList new
					hExact: 300;
					padding: (BlInsets left: 30).
			list column
				width: 80;
				stencil: [ :array | 
					BrLabel new
						text: array first;
						aptitude: (BrGlamorousLabelAptitude new foreground: array third) ].
			list column
				stencil: [ :array | 
					BrLabel new
						text: array second;
						aptitude: (BrGlamorousLabelAptitude new foreground: array third) ].
			list
				items: {{'length'.
							vector length.
							Color blue}.
						{'radians'.
							vector radians.
							Color blue}.
						{'x'.
							vector x.
							Color black}.
						{'y'.
							vector y.
							Color black}.
						{'normal x'.
							vector normalized x.
							Color black}.
						{'normal y'.
							vector normalized y.
							Color black}}.
			container
				addChild: circle;
				addChild: dashedLineX;
				addChild: dashedLineY;
				addChild: completeLineX;
				addChild: lineX;
				addChild: completeLineY;
				addChild: lineY;
				addChild: line;
				addChild: list.
			container ]
]

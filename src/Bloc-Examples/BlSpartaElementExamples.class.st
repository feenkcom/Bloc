Class {
	#name : #BlSpartaElementExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Sparta'
}

{ #category : #accessing }
BlSpartaElementExamples >> gridSpectrumColor [
	<gtExample>
	| root width height stepX stepY scaleH scaleS |
	root := BlSpartaElement new.
	width := 800.
	height := 400.
	stepX := 10.
	stepY := 10.
	root size: width @ height.
	
	scaleH := NSScale linear
		domain: {0. width};
		range: {0. 360}.
	scaleS := NSScale linear
		domain: {0. height}.
	root rendering: [:aCanvas :element |
		1 to: height by: stepY do: [:gridY | 
			1 to: width by: stepX do: [:gridX | 
				aCanvas fill
					paint: (Color 
						h: (scaleH scale: gridX)
						s: (scaleS scale: (height - gridY))
						v: 1);
					path: (gridX @ gridY extent: stepX @ stepY + 1)  ;
					draw
			]
		].
		
	].
	root 
		when: BlMouseMoveEvent
		do: [:evt |
			stepX := evt parentPosition x + 4.
			stepY := evt parentPosition y + 4.
			root invalidate
		].
	
	^ root
]

{ #category : #accessing }
BlSpartaElementExamples >> pixmapImage: blockColor [
	| image elementExtent tileExtent pic wScale |
	"directory := (IceRepository repositories 
		detect: [ :each | each name = 'Bloc' ]) repositoryDirectory.
	path := directory / 'img'/ 'scaled.jpg'."
	
	"image := ImageReadWriter formFromFileNamed: path"
	image := self iconNamed: 'pharoBig'.
	elementExtent := image extent * 3.
	pic := BlSpartaElement new.
	pic size: elementExtent.
	wScale := NSScale linear domain: {0. 0.132340734}; range: {10. 0.1}.
	tileExtent := elementExtent/image extent.
	pic rendering: [:canvas :element |
		| max min |
		max := 0.
		min := 10.
		1 to: image width by: 2.5 do: [:gridX |
			1 to: image height by: 2.5 do: [:gridY |
				| pos c greyScale svgPath |
				pos := gridX @ gridY * tileExtent.
				c := image colorAt: gridX@gridY.
				greyScale := c red*0.222 + c green*0.707 + c blue*0.071.
				max := greyScale max: max.
				min := greyScale min: min.
				svgPath := canvas path
					absolute;
					moveTo: pos;
					"lineTo: pos + (wScale scale: greyScale);"
					lineTo: pos + 5;
					build.
				canvas stroke
					capRound;
					in: [:stroke | blockColor value: stroke value: c ];
					width: (wScale scale: greyScale);
					path: svgPath;
					draw.
			].
		].
	].
	^ pic
]

{ #category : #accessing }
BlSpartaElementExamples >> pixmapImageColor [
	<gtExample>
	^ self pixmapImage: [:stroke :color | stroke paint: color ]
]

{ #category : #accessing }
BlSpartaElementExamples >> pixmapImageGray [
	<gtExample>
	^ self pixmapImage: [:stroke :color | stroke paint: Color gray ]
]

{ #category : #accessing }
BlSpartaElementExamples >> wheelSpectrumColor [
	<gtExample>
	| wheel segmentCount mousePosition radius center width height
	oldVertex scaleS scaleV |
	wheel := BlSpartaElement new.
	width := height := 500.
	wheel size: width @ height.
	scaleS := NSScale linear domain: {0. width}.
	scaleV := NSScale linear domain: {0. height}.
	
	center := width @ height / 2.
	mousePosition := width @ height.
	segmentCount := 6.
	radius := 250.
	wheel rendering: [:canvas :element |
		oldVertex := nil.
		(0 to: 360 by: 360/segmentCount) do:[:angle |
			| color rad vertex |
			rad := angle degreesToRadians.
			vertex := rad sin @ rad cos * radius + center.
			oldVertex ifNil: [ oldVertex := vertex ]
			ifNotNil: [ | path |
				
				color := Color 
					h: angle
					s: (scaleS scale: mousePosition x)
					v: (scaleV scale: mousePosition y).
				path := canvas path
					absolute;
					moveTo: center;
					lineTo: oldVertex;
					lineTo: vertex;
					close;
					build.
				oldVertex := vertex.
				canvas fill
					paint: color;
					path: path;
					draw.
			].
		].
	].
	wheel 
		when: BlMouseMoveEvent
		do: [:evt |
			mousePosition := evt parentPosition.
			wheel invalidate
		];
		beFocusable;
		when: BlMouseDownEvent
		do:[:evt | wheel requestFocuts ];
		when: BlKeyDownEvent
		do: [:evt | 
			evt key name = '1' ifTrue: [segmentCount := 360 ].
			evt key name = '2' ifTrue: [segmentCount := 45 ].
			evt key name = '3' ifTrue: [segmentCount := 24 ].
			evt key name = '4' ifTrue: [segmentCount := 12 ].
			evt key name = '5' ifTrue: [segmentCount := 6 ].
			wheel invalidate.];
		requestFocus.
	^ wheel
]

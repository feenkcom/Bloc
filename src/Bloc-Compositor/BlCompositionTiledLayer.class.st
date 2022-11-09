Class {
	#name : #BlCompositionTiledLayer,
	#superclass : #BlCompositionWithOffsetLayer,
	#instVars : [
		'cameraPosition',
		'viewportExtent',
		'tileExtent',
		'scaleFactor'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> bottomTileRow [
	<return: #Point>
	| aResult |

	aResult := (self tileBottomLeft y / tileExtent y).
	^ aResult truncated + aResult sign
]

{ #category : #'gt - extensions' }
BlCompositionTiledLayer >> drawAxesOn: aCanvas element: anElement [
	| anOrigin aCorner aViewportBounds |
	
	anOrigin := self viewportPointToTile: anElement extent negated / 2.0.
	aCorner := self viewportPointToTile: anElement extent / 2.0.
	aViewportBounds := anOrigin corner: aCorner.
	
	aCanvas stroke
			path: (aCanvas shape line: 0 @ aViewportBounds top to: 0 @ aViewportBounds bottom);
			width: 1;
			paint: Color gray;
			draw.
			
	aCanvas stroke
			path: (aCanvas shape line: aViewportBounds left @ 0 to: aViewportBounds right @ 0);
			width: 1;
			paint: Color gray;
			draw
]

{ #category : #'gt - extensions' }
BlCompositionTiledLayer >> drawCameraOn: aCanvas [
	aCanvas fill
		path: (aCanvas shape circleAt: self sceneCameraPosition radius: 3);
		paint: (Color blue alpha: 0.5);
		draw
]

{ #category : #'gt - extensions' }
BlCompositionTiledLayer >> drawPreviewOn: aCanvas element: anElement [
	aCanvas fill
		path: (0@0 extent: self viewportExtent);
		paint: (Color gray alpha: 0.1);
		draw.

	aCanvas transform
		by: [ :t |					
			t translateBy: self viewportExtent / 2.0.
			t scaleBy: scaleFactor ]
		during: [
			aCanvas transform
				by: [ :t | t translateBy: self sceneCameraPosition negated ]
				during: [
					self drawTilesOn: aCanvas.
					self drawAxesOn: aCanvas element: anElement.
					self drawCameraOn: aCanvas ] ]
]

{ #category : #'gt - extensions' }
BlCompositionTiledLayer >> drawTilesOn: aCanvas [
	| aTileFontSize aTileBorderWidth |
	
	aTileFontSize := self viewportConstantToTile: 9.
	aTileBorderWidth := self viewportConstantToTile: 1.
	
	self tilesDo: [ :eachTile |
		| aTextPainter textBounds |
		aCanvas stroke
			path: eachTile bounds;
			paint: (Color gray alpha: 0.2);
			width: aTileBorderWidth;
			draw.

		aTextPainter := aCanvas text
			font: (aCanvas font named: 'Source Code Pro'; size: aTileFontSize; build);
			string: (eachTile column @ eachTile row) printString;
			paint: Color gray;
			yourself.
	
		textBounds := aTextPainter measure textMetrics bounds.
		
		aTextPainter baseline: (eachTile bounds center) - textBounds center.
		
		aTextPainter draw ]
]

{ #category : #'gt - extensions' }
BlCompositionTiledLayer >> gtPreviewFor: aView [
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
		actionButtonIcon: BrGlamorousIcons zoomin
			tooltip: 'Zoom in'
			action: [ :aButton :aTab |
				| aSpartaElement |
				aSpartaElement := (aTab parentTabGroup query // BlSpartaElement) anyOne.
				aSpartaElement addAnimation: (BlNumberTransition new
					onStepDo: [ :aScaleFactor :anElement |
						self scaleFactor: aScaleFactor .
						anElement invalidate ];
					from: scaleFactor;
					to: self nextZoomLevel;
					duration: 500 milliSeconds) ];
		actionButtonIcon: BrGlamorousIcons zoomout
			tooltip: 'Zoom out'
			action: [ :aButton :aTab |
				| aSpartaElement |
				aSpartaElement := (aTab parentTabGroup query // BlSpartaElement) anyOne.
				aSpartaElement addAnimation: (BlNumberTransition new
					onStepDo: [ :aScaleFactor :anElement |
						self scaleFactor: aScaleFactor .
						anElement invalidate ];
					from: scaleFactor;
					to: self previousZoomLevel;
					duration: 500 milliSeconds) ]
]

{ #category : #'gt - extensions' }
BlCompositionTiledLayer >> gtTilesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Tiles';
		priority: 1.1;
		items: [
			Array streamContents: [ :aStream |
				self tilesDo: [ :eachTile | aStream nextPut: eachTile ] ] ]
]

{ #category : #initialization }
BlCompositionTiledLayer >> initialize [
	super initialize.

	viewportExtent := 600@400.
	cameraPosition := 0@0.
	scaleFactor := 1.0.
	tileExtent := 128@128
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> leftTileColumn [
	<return: #Point>
	| aResult |

	aResult := (self tileTopLeft x / tileExtent x).
	^ aResult truncated + aResult sign
]

{ #category : #'api - coordinates' }
BlCompositionTiledLayer >> localPointToViewPort: aPoint [
	"Convert a point specified in the local coordinates of the scene to the view port coordinates"
	<return: #Point>
	
	^ aPoint * scaleFactor
]

{ #category : #'api - geometry' }
BlCompositionTiledLayer >> nextZoomLevel [
	| aZoomLevel |

	aZoomLevel := self zoomLevel.
	^ aZoomLevel >= 1
		ifTrue: [ aZoomLevel + 1 ]
		ifFalse: [ 1 / (aZoomLevel denominator - 1) ]
]

{ #category : #'api - geometry' }
BlCompositionTiledLayer >> previousZoomLevel [
	| aZoomLevel |

	aZoomLevel := self zoomLevel.
	^ aZoomLevel > 1
		ifTrue: [ aZoomLevel - 1 ]
		ifFalse: [ 1 / (aZoomLevel denominator + 1) ]
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> rightTileColumn [
	<return: #Point>
	| aResult |

	aResult := (self tileTopRight x / tileExtent x).
	^ aResult truncated + aResult sign
]

{ #category : #'api - accessing' }
BlCompositionTiledLayer >> scaleFactor: aNumber [
	scaleFactor := aNumber
]

{ #category : #'api - geometry scene' }
BlCompositionTiledLayer >> sceneCameraPosition [
	"Return camera position in scene coordinates"
	<return: #Point>

	^ self viewportPointToLocal: self viewportCameraPosition
]

{ #category : #'api - geometry scene' }
BlCompositionTiledLayer >> sceneViewportBottom [
	<return: #Number>
	
	^ (self viewportPointToLocal: self viewportBottomRight) y
]

{ #category : #'api - geometry scene' }
BlCompositionTiledLayer >> sceneViewportBounds [
	<return: #Number>
	
	^ (self viewportPointToLocal: self viewportTopLeft) corner: (self viewportPointToLocal: self viewportBottomRight)
]

{ #category : #'api - geometry scene' }
BlCompositionTiledLayer >> sceneViewportTop [
	<return: #Number>
	
	^ (self viewportPointToLocal: self viewportTopLeft) y
]

{ #category : #'api - geometry tiles' }
BlCompositionTiledLayer >> tileBottomLeft [
	<return: #Point>

	^ self viewportPointToTile: self viewportBottomLeft
]

{ #category : #'api - geometry tiles' }
BlCompositionTiledLayer >> tileBottomRight [
	<return: #Point>

	^ self viewportPointToTile: self viewportBottomRight
]

{ #category : #'api - geometry tiles' }
BlCompositionTiledLayer >> tileCameraPosition [
	"Return camera position in tile coordinates"
	<return: #Point>

	^ self viewportPointToTile: self viewportCameraPosition
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> tileColumnsDo: aBlock [
	self leftTileColumn to: self rightTileColumn do: [ :eachColumn |
		eachColumn ~= 0
			ifTrue: [ aBlock value: eachColumn ] ]
]

{ #category : #'api - accessing' }
BlCompositionTiledLayer >> tileExtent: aPoint [
	tileExtent := aPoint
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> tileRowsDo: aBlock [
	self topTileRow to: self bottomTileRow do: [ :eachRow |
		eachRow ~= 0
			ifTrue: [ aBlock value: eachRow ] ]
]

{ #category : #'api - geometry tiles' }
BlCompositionTiledLayer >> tileTopLeft [
	<return: #Point>

	^ self viewportPointToTile: self viewportTopLeft
]

{ #category : #'api - geometry tiles' }
BlCompositionTiledLayer >> tileTopRight [
	<return: #Point>

	^ self viewportPointToTile: self viewportTopRight
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> tilesDo: aBlock [
	| aTileExtent |

	aTileExtent := self viewportExtentToTile: tileExtent.

	self tileRowsDo: [ :eachRow |
		self tileColumnsDo: [ :eachColumn |
			aBlock value: (BlCompositionTile new
				row: eachRow;
				column: eachColumn;
				extent: aTileExtent) ] ]
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> topTileRow [
	<return: #Point>
	| aResult |

	aResult := (self tileTopLeft y / tileExtent y).
	^ aResult truncated + aResult sign
]

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportBottomLeft [
	"Bottom left coordinate of the viewport which depends on the camera position and viewport size"
	<return: #Point>
	
	^ (self viewportCenter x - (self viewportWidth / 2.0))
		@ (self viewportCenter y + (self viewportHeight / 2.0))
]

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportBottomRight [
	"Bottom right coordinate of the viewport which depends on the camera position and viewport size"
	<return: #Point>
	
	^ self viewportCenter + (self viewportExtent / 2.0)
]

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportBounds [
	"Return the bounds of the viewport which depends on the camera position and viewport extent"
	<return: #Rectangle>

	^ (self viewportCenter - viewportExtent / 2.0) extent: viewportExtent
]

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportCameraPosition [
	"Return camera position in viewport coordinates"
	<return: #Point>
	
	^ cameraPosition
]

{ #category : #'api - accessing' }
BlCompositionTiledLayer >> viewportCameraPosition: aPoint [
	cameraPosition := aPoint
]

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportCenter [
	"Return the center of the viewport.
	By our definition, the center of the viewport is the camera's position"
	<return: #Point>

	^ 0@0
]

{ #category : #'api - coordinates' }
BlCompositionTiledLayer >> viewportConstantToTile: aNumber [
	"Convert a constant number specified in view port coordinates to the coordinates of the tiles"
	<return: #Point>
	
	^ aNumber / self zoomLevel
]

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportExtent [
	"Return the size of the view port."
	<return: #Point>

	^ viewportExtent
]

{ #category : #'api - accessing' }
BlCompositionTiledLayer >> viewportExtent: anExtent [
	viewportExtent := anExtent
]

{ #category : #'api - coordinates' }
BlCompositionTiledLayer >> viewportExtentToTile: anExtent [
	"Convert an extent specified in view port coordinates to the coordinates of the tiles"
	<return: #Point>
	
	^ anExtent / self zoomLevel
]

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportHeight [
	"Return the height of the view port"
	<return: #Number>
	
	^ viewportExtent y
]

{ #category : #'api - coordinates' }
BlCompositionTiledLayer >> viewportPointToLocal: aPoint [
	"Convert a point specified in view port coordinates to the local coordinates of the scene"
	<return: #Point>
	
	^ aPoint / scaleFactor
]

{ #category : #'api - coordinates' }
BlCompositionTiledLayer >> viewportPointToTile: aPoint [
	"Convert a point specified in view port coordinates to the coordinates of the tiles"
	<return: #Point>
	
	^ (aPoint + cameraPosition) / self zoomLevel
]

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportTopLeft [
	"Top left coordinate of the viewport which depends on the camera position and viewport size"
	<return: #Point>
	
	^ self viewportCenter - (self viewportExtent / 2.0)
]

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportTopRight [
	"Top right coordinate of the viewport which depends on the camera position and viewport size"
	<return: #Point>
	
	^ (self viewportCenter x + (self viewportWidth / 2.0))
		@ (self viewportCenter y - (self viewportHeight / 2.0))
]

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportWidth [
	"Return the width of the view port"
	<return: #Number>
	
	^ viewportExtent x
]

{ #category : #'api - geometry' }
BlCompositionTiledLayer >> zoomLevel [
	"Return a zoom level represented as a fraction with integer denominator.
	For example, zoom level of (1 / 4) means that we the scene is zoomed out 4 times.
	Contrarily, zoom level of (4 / 1) means that the scene is zoomed in 4 times."
	<return: #Fraction>

	^ scaleFactor >= 1
		ifTrue: [ scaleFactor floor asFraction ]
		ifFalse: [ 1 / (1 / scaleFactor) floor ]
]

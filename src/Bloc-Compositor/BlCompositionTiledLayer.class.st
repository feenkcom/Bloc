Class {
	#name : #BlCompositionTiledLayer,
	#superclass : #BlCompositionLayer,
	#instVars : [
		'cameraPosition',
		'viewportExtent',
		'tileExtent',
		'scaleFactor',
		'figures'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #'api - figures' }
BlCompositionTiledLayer >> addFigure: aBlCompositionTileFigure [
	figures add: aBlCompositionTileFigure
]

{ #category : #converting }
BlCompositionTiledLayer >> asSkiaLayer [
	| theTilesCache thePictureLayers |
	
	theTilesCache := Dictionary new.
	
	self figuresAndTilesDo: [ :eachFigure :eachTile |
		| aRecordingCanvas |
		
		aRecordingCanvas := theTilesCache
			at: eachTile
			ifAbsentPut: [ SkiaCanvas recording: eachTile bounds ].
		
		eachFigure picture playbackOn: aRecordingCanvas surfaceCanvas ].
	
	thePictureLayers := theTilesCache values
		collect: [ :eachCanvas | BlCompositionPictureLayer new picture: eachCanvas snapshot ].
	
	^ (BlCompositionOffsetLayer new
		offset: self viewportCameraPosition;
		addLayers: thePictureLayers)
			asSkiaLayer
]

{ #category : #converting }
BlCompositionTiledLayer >> asSymbolTree [
	^ {
		#Tiled
	}
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> bottomTileRow [
	<return: #Number>
	
	^ self tileRowAt: self viewportBottom
]

{ #category : #'gt - extensions' }
BlCompositionTiledLayer >> drawAxesOn: aCanvas element: anElement [
	| anOrigin aCorner aViewportBounds aWidth |
	
	anOrigin := self viewportPointToScene: anElement extent negated / 2.0.
	aCorner := self viewportPointToScene: anElement extent / 2.0.
	aWidth := self viewportConstantToScene: 1. 
	aViewportBounds := anOrigin corner: aCorner.
	
	aCanvas stroke
			path: (aCanvas shape line: 0 @ aViewportBounds top to: 0 @ aViewportBounds bottom);
			width: aWidth;
			paint: Color gray;
			draw.
			
	aCanvas stroke
			path: (aCanvas shape line: aViewportBounds left @ 0 to: aViewportBounds right @ 0);
			width: aWidth;
			paint: Color gray;
			draw
]

{ #category : #'gt - extensions' }
BlCompositionTiledLayer >> drawCameraOn: aCanvas [
	aCanvas fill
		path: (aCanvas shape circleAt: self sceneCameraPosition radius: 3);
		paint: (Color red alpha: 0.5);
		draw
]

{ #category : #'gt - extensions' }
BlCompositionTiledLayer >> drawFiguresOn: aCanvas [
	self figuresAndTilesDo: [ :eachFigure :eachTile |
		aCanvas fill
			path: eachTile bounds;
			paint: Color veryVeryLightGray;
			draw ].

	self visibleFiguresDo: [ :eachFigure |
		aCanvas fill
			path: eachFigure bounds;
			paint: (Color blue alpha: 0.2);
			draw ]
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
			t scaleBy: self scale ]
		during: [
			aCanvas transform
				by: [ :t | t translateBy: self sceneCameraPosition negated ]
				during: [
					self drawFiguresOn: aCanvas.
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

{ #category : #'api - figures' }
BlCompositionTiledLayer >> figuresAndTilesDo: aBlock [
	| aViewportTileExtent aTileExtent aTileLocalExtent aZoomLevel aLeftSceneColumn aRightSceneColumn aTopSceneRow aBottomSceneRow |

	aViewportTileExtent := self tileExtentToViewport: tileExtent.
	aTileExtent := self viewportExtentToTile: tileExtent.
	aTileLocalExtent := self viewportPointToScene: tileExtent.
	aZoomLevel := self zoomLevel.

	aLeftSceneColumn := self leftTileColumn.
	aRightSceneColumn := self rightTileColumn.
	aTopSceneRow := self topTileRow.
	aBottomSceneRow := self bottomTileRow.

	figures do: [ :eachFigure |
		| top right bottom left leftColumn rightColumn topRow bottomRow isOutside |

		left := self sceneConstantToViewPort: eachFigure offset x.
		top := self sceneConstantToViewPort: eachFigure offset y.
		right := left + (self sceneConstantToViewPort: eachFigure extent x).
		bottom := top + (self sceneConstantToViewPort: eachFigure extent y).

		leftColumn := self tileColumnAt: left tileWidth: aViewportTileExtent x.
		rightColumn := self tileColumnAt: right tileWidth: aViewportTileExtent x.
		topRow := self tileRowAt: top tileHeight: aViewportTileExtent y.
		bottomRow := self tileRowAt: bottom tileHeight: aViewportTileExtent y.
		
		isOutside := rightColumn < aLeftSceneColumn
			or: [ leftColumn > aRightSceneColumn
				or: [ topRow > aBottomSceneRow
					or: [ bottomRow < aTopSceneRow ] ] ].

		leftColumn := leftColumn max: aLeftSceneColumn.
		rightColumn := rightColumn min: aRightSceneColumn.
		topRow := topRow max: aTopSceneRow.
		bottomRow := bottomRow min: aBottomSceneRow.

		isOutside ifFalse: [
			self tileRowsFrom: topRow to: bottomRow do: [ :eachRow |
				self tileColumnsFrom: leftColumn to: rightColumn do: [ :eachColumn |
					| eachTile |
					eachTile := BlCompositionTile new
						row: eachRow;
						column: eachColumn;
						zoomLevel: aZoomLevel;
						extent: aTileExtent;
						localExtent: aTileLocalExtent.
					
					aBlock value: eachFigure value: eachTile ] ] ] ]
]

{ #category : #'gt - extensions' }
BlCompositionTiledLayer >> gtInfoFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Info';
		priority: 1.1;
		items: [ {
			'Scale factor' -> self scaleFactor.
			'Camera position' -> self viewportCameraPosition.
			'Viewport Extent' -> self viewportExtent.
			'Viewport Bounds' -> self viewportBounds.
		} ];
		column: 'Property' text: #key;
		column: 'Value' text: #value;
		send: #value;
		actionUpdateButton
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
						self scaleIn: aScaleFactor.
						anElement invalidate ];
					from: self scale;
					to: self nextZoomLevel;
					duration: 500 milliSeconds) ];
		actionButtonIcon: BrGlamorousIcons zoomout
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

{ #category : #'gt - extensions' }
BlCompositionTiledLayer >> gtTilesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Tiles';
		priority: 1.2;
		items: [
			Array streamContents: [ :aStream |
				self tilesDo: [ :eachTile | aStream nextPut: eachTile ] ] ]
]

{ #category : #initialization }
BlCompositionTiledLayer >> initialize [
	super initialize.

	viewportExtent := 600@400.
	cameraPosition := 0@0.
	scaleFactor := BlCompositionTileScaleInFactor scale: 1.0.
	tileExtent := 128@128.
	figures := OrderedCollection new
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> leftTileColumn [
	<return: #Number>
	
	^ self tileColumnAt: self viewportLeft
]

{ #category : #accessing }
BlCompositionTiledLayer >> name [
	^ 'Tiled'
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
	<return: #Number>

	^ self tileColumnAt: self viewportRight
]

{ #category : #'api - accessing' }
BlCompositionTiledLayer >> scale [
	<return: #Number>

	^ scaleFactor scale
]

{ #category : #'api - accessing' }
BlCompositionTiledLayer >> scaleFactor [
	^ scaleFactor
]

{ #category : #'api - accessing' }
BlCompositionTiledLayer >> scaleFactor: aBlCompositionTileScaleFactor [
	self
		assert: [ aBlCompositionTileScaleFactor isKindOf: BlCompositionTileScaleFactor ]
		description: [ 'Scale factor must be a domain object' ].

	scaleFactor := aBlCompositionTileScaleFactor
]

{ #category : #'api - accessing' }
BlCompositionTiledLayer >> scaleIn: aFloat [
	self scaleFactor: (BlCompositionTileScaleInFactor scale: aFloat)
]

{ #category : #'api - accessing' }
BlCompositionTiledLayer >> scaleOut: aFloat [
	self scaleFactor: (BlCompositionTileScaleOutFactor scale: aFloat)
]

{ #category : #'api - geometry scene' }
BlCompositionTiledLayer >> sceneCameraPosition [
	"Return camera position in scene coordinates"
	<return: #Point>

	^ self viewportPointToScene: self viewportCameraPosition
]

{ #category : #'api - coordinates' }
BlCompositionTiledLayer >> sceneConstantToViewPort: aNumber [
	"Convert a number specified in the local coordinates of the scene to the view port coordinates"
	<return: #Number>
	
	^ aNumber * self scale
]

{ #category : #'api - geometry scene' }
BlCompositionTiledLayer >> sceneViewportBottom [
	<return: #Number>
	
	^ (self viewportPointToScene: self viewportBottomRight) y
]

{ #category : #'api - geometry scene' }
BlCompositionTiledLayer >> sceneViewportBounds [
	<return: #Number>
	
	^ (self viewportPointToScene: self viewportTopLeft) corner: (self viewportPointToScene: self viewportBottomRight)
]

{ #category : #'api - geometry scene' }
BlCompositionTiledLayer >> sceneViewportLeft [
	<return: #Number>
	
	^ (self viewportPointToScene: self viewportTopLeft) x
]

{ #category : #'api - geometry scene' }
BlCompositionTiledLayer >> sceneViewportRight [
	<return: #Number>
	
	^ (self viewportPointToScene: self viewportTopRight) x
]

{ #category : #'api - geometry scene' }
BlCompositionTiledLayer >> sceneViewportTop [
	<return: #Number>
	
	^ (self viewportPointToScene: self viewportTopLeft) y
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
BlCompositionTiledLayer >> tileColumnAt: aX [
	<return: #Number>

	^ self
		tileColumnAt: aX
		tileWidth: (self tileExtentToViewport: tileExtent) x
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> tileColumnAt: aX tileWidth: aTileWidth [
	<return: #Number>
	| aResult |

	aResult :=  aX / aTileWidth.
	^ aResult truncated + aResult sign
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> tileColumnsDo: aBlock [
	self
		tileColumnsFrom: self leftTileColumn
		to: self rightTileColumn
		do: aBlock
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> tileColumnsFrom: aLeftColumn to: aRightColumn do: aBlock [
	aLeftColumn to: aRightColumn do: [ :eachColumn |
		eachColumn ~= 0
			ifTrue: [ aBlock value: eachColumn ] ]
]

{ #category : #'api - accessing' }
BlCompositionTiledLayer >> tileExtent [
	^ tileExtent
]

{ #category : #'api - accessing' }
BlCompositionTiledLayer >> tileExtent: aPoint [
	tileExtent := aPoint
]

{ #category : #'api - coordinates' }
BlCompositionTiledLayer >> tileExtentToViewport: anExtent [
	"Convert an extent specified in tile coordinates to the coordinates of the viewport"
	<return: #Point>
	
	^ anExtent / self zoomLevel * self scale
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> tileRowAt: aY [
	<return: #Number>

	^ self
		tileRowAt: aY
		tileHeight: (self tileExtentToViewport: tileExtent) y
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> tileRowAt: aY tileHeight: aTileHeight [
	<return: #Number>
	| aResult |

	aResult :=  aY / aTileHeight.
	^ aResult truncated + aResult sign
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> tileRowsDo: aBlock [	
	self
		tileRowsFrom: self topTileRow
		to: self bottomTileRow
		do: aBlock
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> tileRowsFrom: aTopRow to: aBottomRow do: aBlock [
	aTopRow to: aBottomRow do: [ :eachRow |
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
	| aZoomLevel aTileExtent aTileLocalExtent |

	aTileExtent := self viewportExtentToTile: tileExtent.
	aTileLocalExtent := self viewportPointToScene: tileExtent.
	aZoomLevel := self zoomLevel.

	self tileRowsDo: [ :eachRow |
		self tileColumnsDo: [ :eachColumn |
			aBlock value: (BlCompositionTile new
				row: eachRow;
				column: eachColumn;
				zoomLevel: aZoomLevel;
				extent: aTileExtent;
				localExtent: aTileLocalExtent) ] ]
]

{ #category : #'api - tiles' }
BlCompositionTiledLayer >> topTileRow [
	<return: #Number>
	
	^ self tileRowAt: self viewportTop
]

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportBottom [
	"Bottom coordinate of the viewport which depends on the camera position and viewport size"
	<return: #Number>
	
	^ self viewportBottomRight y
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

	^ cameraPosition
]

{ #category : #'api - coordinates' }
BlCompositionTiledLayer >> viewportConstantToScene: aNumber [
	"Convert a constant number specified in view port coordinates to the coordinates of the scene"
	<return: #Point>
	
	^ aNumber / self scale
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

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportLeft [
	"Left coordinate of the viewport which depends on the camera position and viewport size"
	<return: #Number>
	
	^ self viewportTopLeft x
]

{ #category : #'api - coordinates' }
BlCompositionTiledLayer >> viewportPointToScene: aPoint [
	"Convert a point specified in view port coordinates to the local coordinates of the scene"
	<return: #Point>
	
	^ aPoint / self scale
]

{ #category : #'api - coordinates' }
BlCompositionTiledLayer >> viewportPointToTile: aPoint [
	"Convert a point specified in view port coordinates to the coordinates of the tiles"
	<return: #Point>
	
	^ (aPoint + cameraPosition) / self zoomLevel
]

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportRight [
	"Right coordinate of the viewport which depends on the camera position and viewport size"
	<return: #Point>
	
	^ self viewportBottomRight x
]

{ #category : #'api - geometry viewport' }
BlCompositionTiledLayer >> viewportTop [
	"Top coordinate of the viewport which depends on the camera position and viewport size"
	<return: #Number>
	
	^ self viewportTopLeft y
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

{ #category : #'api - figures' }
BlCompositionTiledLayer >> visibleFiguresDo: aBlock [
	| aPreviousFigure |
	
	aPreviousFigure := nil.
	
	self figuresAndTilesDo: [ :eachFigure :eachTile |
		eachFigure == aPreviousFigure
			ifFalse: [ aBlock value: eachFigure ].
		aPreviousFigure := eachFigure ]
]

{ #category : #'api - geometry' }
BlCompositionTiledLayer >> zoomLevel [
	"Return a zoom level represented as a fraction with integer denominator.
	For example, zoom level of (1 / 4) means that we the scene is zoomed out 4 times.
	Contrarily, zoom level of (4 / 1) means that the scene is zoomed in 4 times."
	<return: #Fraction>

	^ scaleFactor zoomLevel
]

Class {
	#name : #BlCompositionTiledLayer,
	#superclass : #BlCompositionLayer,
	#instVars : [
		'figures',
		'skiaLayer',
		'viewportCameraPosition',
		'viewportExtent',
		'tileExtent',
		'scaleFactor'
	],
	#classVars : [
		'UniqueIdGenerator'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #accessing }
BlCompositionTiledLayer class >> initialize [
	UniqueIdGenerator := BlUniqueIdGenerator new
]

{ #category : #accessing }
BlCompositionTiledLayer >> addFigure: aFigure [
	aFigure id: UniqueIdGenerator generateUniqueId.
	figures at: aFigure id put: aFigure
]

{ #category : #accessing }
BlCompositionTiledLayer >> asSkiaLayer [
	skiaLayer ifNil: [ 
		skiaLayer := SkiaCompositionTiledLayer
			forCameraPosition: viewportCameraPosition
			viewportExtent: viewportExtent
			tileExtent: tileExtent.
		
		figures do: [ :eachFigure |
			skiaLayer
				addFigure: eachFigure id
				offset: eachFigure offset
				extent: eachFigure extent ] ].

	skiaLayer visibleFiguresIdsWithoutPicture do: [ :eachId |
		figures
			at: eachId
			ifPresent: [ :aFigure |
				| aPicture |
				
				aPicture := aFigure picture.
				skiaLayer
					setFigurePicture: eachId
					picture: aPicture ] ].
	
	^ skiaLayer
]

{ #category : #accessing }
BlCompositionTiledLayer >> initialize [
	super initialize.
	
	figures := Dictionary new.
	viewportCameraPosition := 0@0.
	viewportExtent := 600@400.
	tileExtent := 128@128.
	scaleFactor := BlCompositionTileScaleInFactor scale: 1.0.
]

{ #category : #accessing }
BlCompositionTiledLayer >> name [
	^ 'Tiled'
]

{ #category : #accessing }
BlCompositionTiledLayer >> scaleFactor: aScaleFactor [
	scaleFactor := aScaleFactor.
	skiaLayer ifNotNil: [ :aSkiaLayer |
		aScaleFactor isScaleIn
			ifTrue: [ aSkiaLayer scaleIn: aScaleFactor scale ]
			ifFalse: [ aSkiaLayer scaleOut: aScaleFactor scale ] ]
]

{ #category : #accessing }
BlCompositionTiledLayer >> tileExtent: aPoint [
	tileExtent := aPoint 
]

{ #category : #accessing }
BlCompositionTiledLayer >> viewportCameraPosition: aPoint [
	viewportCameraPosition := aPoint.
	skiaLayer ifNotNil: [ :aSkiaLayer | aSkiaLayer cameraPosition: aPoint ]
]

{ #category : #accessing }
BlCompositionTiledLayer >> viewportExtent: aPoint [
	viewportExtent := aPoint
]

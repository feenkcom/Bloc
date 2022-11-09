Class {
	#name : #BlCompositionTiledLayerExamples,
	#superclass : #Object,
	#category : #'Bloc-Compositor-Examples'
}

{ #category : #examples }
BlCompositionTiledLayerExamples >> defaultTiledLayer [
	<gtExample>
	| aLayer |
	
	aLayer := BlCompositionTiledLayer new.

	self assert: aLayer viewportCameraPosition equals: 0@0.
	self assert: aLayer viewportExtent equals: 600@400.
	self assert: aLayer viewportBounds equals: ((-300.0@ -200.0) corner: (300.0@200.0)).
	self assert: aLayer scale equals: 1.
	self assert: aLayer zoomLevel equals: 1.
	self assert: aLayer tileExtent equals: 128@128.

	^ aLayer
]

{ #category : #examples }
BlCompositionTiledLayerExamples >> smallTiledLayer [
	<gtExample>
	| aLayer |
	
	aLayer := BlCompositionTiledLayer new
		viewportExtent: 300@200;
		viewportCameraPosition: 0@0;
		tileExtent: 64@64.

	self assert: aLayer viewportCameraPosition equals: 0@0.
	self assert: aLayer viewportExtent equals: 300@200.
	self assert: aLayer viewportBounds equals: ((-150.0@ -100.0) corner: (150.0@100.0)).
	self assert: aLayer scale equals: 1.
	self assert: aLayer zoomLevel equals: 1.
	self assert: aLayer tileExtent equals: 64@64.

	^ aLayer
]

{ #category : #examples }
BlCompositionTiledLayerExamples >> smallTiledLayerTilesNoScaleBottomMovement [
	<gtExample>
	| aLayer |
	
	aLayer := self smallTiledLayer.
	aLayer viewportCameraPosition: 0@ 150.

	self assert: aLayer leftTileColumn equals: -3.
	self assert: aLayer rightTileColumn equals: 3.
	self assert: aLayer topTileRow equals: 1.
	self assert: aLayer bottomTileRow equals: 4.

	^ aLayer
]

{ #category : #examples }
BlCompositionTiledLayerExamples >> smallTiledLayerTilesNoScaleLeftMovement [
	<gtExample>
	| aLayer |
	
	aLayer := self smallTiledLayer.
	aLayer viewportCameraPosition: -100@0.
	
	self assert: aLayer leftTileColumn equals: -4.
	self assert: aLayer rightTileColumn equals: 1.
	self assert: aLayer topTileRow equals: -2.
	self assert: aLayer bottomTileRow equals: 2.

	^ aLayer
]

{ #category : #examples }
BlCompositionTiledLayerExamples >> smallTiledLayerTilesNoScaleNoMovement [
	<gtExample>
	| aLayer |
	
	aLayer := self smallTiledLayer.
	self assert: aLayer leftTileColumn equals: -3.
	self assert: aLayer rightTileColumn equals: 3.
	self assert: aLayer topTileRow equals: -2.
	self assert: aLayer bottomTileRow equals: 2.

	^ aLayer
]

{ #category : #examples }
BlCompositionTiledLayerExamples >> smallTiledLayerTilesNoScaleRightMovement [
	<gtExample>
	| aLayer |
	
	aLayer := self smallTiledLayer.
	aLayer viewportCameraPosition: 100@0.
	
	self assert: aLayer leftTileColumn equals: -1.
	self assert: aLayer rightTileColumn equals: 4.
	self assert: aLayer topTileRow equals: -2.
	self assert: aLayer bottomTileRow equals: 2.

	^ aLayer
]

{ #category : #examples }
BlCompositionTiledLayerExamples >> smallTiledLayerTilesNoScaleTopMovement [
	<gtExample>
	| aLayer |
	
	aLayer := self smallTiledLayer.
	aLayer viewportCameraPosition: 0@ -150.

	self assert: aLayer leftTileColumn equals: -3.
	self assert: aLayer rightTileColumn equals: 3.
	self assert: aLayer topTileRow equals: -4.
	self assert: aLayer bottomTileRow equals: -1.

	^ aLayer
]

{ #category : #examples }
BlCompositionTiledLayerExamples >> smallTiledLayerTilesZoomInNoMovement [
	<gtExample>
	| aLayer |
	
	aLayer := self smallTiledLayer.
	aLayer scaleIn: 1.3.
	
	self assert: aLayer leftTileColumn equals: -2.
	self assert: aLayer rightTileColumn equals: 2.
	self assert: aLayer topTileRow equals: -2.
	self assert: aLayer bottomTileRow equals: 2.

	^ aLayer
]

{ #category : #examples }
BlCompositionTiledLayerExamples >> smallTiledLayerTilesZoomOutNoMovement [
	<gtExample>
	| aLayer |
	
	aLayer := self smallTiledLayer.
	aLayer scaleOut: 0.7.
	
	self assert: aLayer leftTileColumn equals: -4.
	self assert: aLayer rightTileColumn equals: 4.
	self assert: aLayer topTileRow equals: -3.
	self assert: aLayer bottomTileRow equals: 3.

	^ aLayer
]

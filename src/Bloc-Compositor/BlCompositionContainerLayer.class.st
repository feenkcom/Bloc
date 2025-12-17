Class {
	#name : #BlCompositionContainerLayer,
	#superclass : #BlCompositionLayer,
	#instVars : [
		'children'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #removing }
BlCompositionContainerLayer >> addLayer: aBlCompositionLayer [
	self
		assert: [ aBlCompositionLayer isNotNil ]
		description: [ 'Child layer must not be nil' ].

	children add: aBlCompositionLayer.
	aBlCompositionLayer attachToParent: self.
	
	self markNeedsComposition
]

{ #category : #removing }
BlCompositionContainerLayer >> addLayers: aCollectionOfLayers [
	self
		assert: [ aCollectionOfLayers allSatisfy: [ :each | each isNotNil ] ]
		description: [ 'Child layer must not be nil' ].

	children addAll: aCollectionOfLayers.
	aCollectionOfLayers do: [ :eachLayer | eachLayer attachToParent: self ].
	self markNeedsComposition
]

{ #category : #'private - context' }
BlCompositionContainerLayer >> allPictureLayers [
	^ Array streamContents: [ :aStream | self pictureLayersDo: [ :eachLayer | aStream nextPut: eachLayer ] ]
]

{ #category : #converting }
BlCompositionContainerLayer >> asSkiaLayer [
	| aLayer theChildLayers |

	^ BlFrameTelemetry
		time: [ 'As Skia layer ', self name ]
		during: [
			aLayer := self newSkiaLayer.
			self
				assert: [ aLayer isKindOf: SkiaCompositionLayer ]
				description: [ 'Must be Skia composition layer' ].
			
			theChildLayers := children collect: [ :eachLayer | eachLayer asSkiaLayer ].
			aLayer withLayers: theChildLayers ]
]

{ #category : #converting }
BlCompositionContainerLayer >> asSymbolTree [
	^ {
		#Container .
			children collect: [ :eachLayer | eachLayer asSymbolTree ] as: Array
	}
]

{ #category : #accessing }
BlCompositionContainerLayer >> children [
	^ self layers
]

{ #category : #'private - composition' }
BlCompositionContainerLayer >> cleanNeedsCompositionFromAllLayers [
	super cleanNeedsCompositionFromAllLayers.
	children do: [ :eachLayer | eachLayer cleanNeedsCompositionFromAllLayers ]
]

{ #category : #'private - composition' }
BlCompositionContainerLayer >> computeNeedsComposition [
	children do: [ :eachLayer |
		eachLayer computeNeedsComposition.
		needsComposition := needsComposition or: [ eachLayer needsComposition ] ]
]

{ #category : #drawing }
BlCompositionContainerLayer >> drawOnSpartaCanvas: aCanvas [
	children do: [ :eachLayer | eachLayer drawOnSpartaCanvas: aCanvas ]
]

{ #category : #initialization }
BlCompositionContainerLayer >> initialize [
	super initialize.
	
	children := AsyncSharedOrderedCollection new
]

{ #category : #accessing }
BlCompositionContainerLayer >> layers [
	<return: #Collection of: #BlCompositionLayer>

	^ children
]

{ #category : #accessing }
BlCompositionContainerLayer >> markPictureLayersToNotNeedCache [
	children
		select: [ :each | each isKindOf: BlCompositionPictureLayer ]
		thenDo: [ :each | each needsCache: false ]
]

{ #category : #accessing }
BlCompositionContainerLayer >> name [
	^ 'Container'
]

{ #category : #converting }
BlCompositionContainerLayer >> newSkiaLayer [
	^ SkiaCompositionOffsetLayer offset: 0@0
]

{ #category : #'private - context' }
BlCompositionContainerLayer >> pictureLayersDo: aBlock [
	children do: [ :eachLayer | eachLayer pictureLayersDo: aBlock ]
]

{ #category : #removing }
BlCompositionContainerLayer >> removeAllLayers [
	children do: [ :each | each detachFromParent ].
	children removeAll.
	
	self markNeedsComposition
]

{ #category : #removing }
BlCompositionContainerLayer >> removeLayer: aBlCompositionLayer [
	children remove: aBlCompositionLayer.
	aBlCompositionLayer detachFromParent.

	self markNeedsComposition
]

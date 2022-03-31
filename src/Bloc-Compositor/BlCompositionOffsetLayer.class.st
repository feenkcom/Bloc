Class {
	#name : #BlCompositionOffsetLayer,
	#superclass : #BlCompositionWithOffsetLayer,
	#instVars : [
		'skiaLayer'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionOffsetLayer >> asSkiaLayer [
	<return: #SkiaCompositionOffsetLayer>

	^ (skiaLayer isNil or: [ self needsComposition ])
		ifTrue: [
			BlFrameTelemetry
				time: [ 'Create new Skia offset layer ', self name ]
				during: [
					| theChildLayers |
					theChildLayers := self children collect: [ :eachLayer | eachLayer asSkiaLayer ].
					skiaLayer := self newSkiaLayer withLayers: theChildLayers.
					skiaLayer ] ]
		ifFalse: [
			BlFrameTelemetry
				time: [ 'With new offset for Skia offset layer ', self name ]
				during: [ skiaLayer withOffset: self offset ] ]
]

{ #category : #converting }
BlCompositionOffsetLayer >> asSymbolTree [
	^ {
		#Offset .
			#offset. { self offset x . self offset y }.
			self layers collect: [ :eachLayer | eachLayer asSymbolTree ] as: Array
	}
]

{ #category : #drawing }
BlCompositionOffsetLayer >> drawOnSpartaCanvas: aCanvas [
	aCanvas transform
		by: [ :t | t translateBy: self offset ]
		during: [ super drawOnSpartaCanvas: aCanvas ]
]

{ #category : #'private - context' }
BlCompositionOffsetLayer >> multiplyOn: aBlMatrix2D [
	aBlMatrix2D translateBy: self offset
]

{ #category : #accessing }
BlCompositionOffsetLayer >> name [
	^ 'Offset {1}' format: { self offset }
]

Class {
	#name : #BlCompositionTransformationLayer,
	#superclass : #BlCompositionWithOffsetLayer,
	#instVars : [
		'matrix'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionTransformationLayer >> asSkiaLayer [
	| aTransformationLayer theChildLayers |
	
	theChildLayers := self children collect: [ :eachLayer | eachLayer asSkiaLayer ].	
	aTransformationLayer := self newSkiaLayer withLayers: theChildLayers.
	
	^ self offset isZero
		ifTrue: [ aTransformationLayer ]
		ifFalse: [ super newSkiaLayer withLayers: (Array with: aTransformationLayer) ]
]

{ #category : #converting }
BlCompositionTransformationLayer >> asSymbolTree [
	^ {
		#Transformation .
			#offset. { self offset x . self offset y }.
			#matrix. self matrix asMatrixCollection asArray.
			self layers collect: [ :eachLayer | eachLayer asSymbolTree ] as: Array
	}
]

{ #category : #initialization }
BlCompositionTransformationLayer >> initialize [
	super initialize.
	
	matrix := BlMatrix2D new
]

{ #category : #accessing }
BlCompositionTransformationLayer >> matrix [
	^ matrix
]

{ #category : #accessing }
BlCompositionTransformationLayer >> matrix: anObject [
	matrix := anObject
]

{ #category : #'private - context' }
BlCompositionTransformationLayer >> multiplyOn: aBlMatrix2D [
	aBlMatrix2D translateBy: self offset.
	aBlMatrix2D multiplyBy: self matrix
]

{ #category : #accessing }
BlCompositionTransformationLayer >> name [
	^ 'Transform {1}' format: { self offset }
]

{ #category : #converting }
BlCompositionTransformationLayer >> newSkiaLayer [
	^ SkiaCompositionTransformationLayer matrix: self matrix
]

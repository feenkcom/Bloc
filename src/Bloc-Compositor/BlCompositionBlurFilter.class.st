Class {
	#name : #BlCompositionBlurFilter,
	#superclass : #Object,
	#instVars : [
		'radius'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #'instance creation' }
BlCompositionBlurFilter class >> radius: aNumber [
	^ self new
		radius: aNumber;
		yourself
]

{ #category : #converting }
BlCompositionBlurFilter >> asSkiaFilterDuring: aBlock [
	^ SkiaCompositorFilter
		blur: self radius asPoint
		during: aBlock
]

{ #category : #converting }
BlCompositionBlurFilter >> asSymbolTree [
	^ {
		#BlurFilter .
		#radius . self radius
	}
]

{ #category : #accessing }
BlCompositionBlurFilter >> radius [
	^ radius
]

{ #category : #accessing }
BlCompositionBlurFilter >> radius: anObject [
	radius := anObject
]

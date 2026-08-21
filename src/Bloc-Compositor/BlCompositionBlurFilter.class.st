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
BlCompositionBlurFilter >> asSkiaFilter [
	^ SkiaCompositorFilter blur: self radius asPoint
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

Class {
	#name : #BlCompositingWithoutLayerMode,
	#superclass : #BlCompositingMode,
	#category : #'Bloc-Core-Support'
}

{ #category : #testing }
BlCompositingWithoutLayerMode >> wantsBufferedLayer [
	^ false
]

{ #category : #testing }
BlCompositingWithoutLayerMode >> wantsCompositionLayer [
	^ false
]

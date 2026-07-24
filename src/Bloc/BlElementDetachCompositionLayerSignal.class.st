Class {
	#name : #BlElementDetachCompositionLayerSignal,
	#superclass : #BlElementSignal,
	#instVars : [
		'compositionLayer'
	],
	#category : #'Bloc-Core-Support'
}

{ #category : #accessing }
BlElementDetachCompositionLayerSignal >> compositionLayer [

	^ compositionLayer
]

{ #category : #accessing }
BlElementDetachCompositionLayerSignal >> compositionLayer: anObject [

	compositionLayer := anObject
]

Class {
	#name : #BlElementOffsetCompositionLayerSignal,
	#superclass : #BlElementSignal,
	#instVars : [
		'compositionLayer',
		'oldPosition',
		'newPosition'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #accessing }
BlElementOffsetCompositionLayerSignal >> compositionLayer [

	^ compositionLayer
]

{ #category : #accessing }
BlElementOffsetCompositionLayerSignal >> compositionLayer: anObject [

	compositionLayer := anObject
]

{ #category : #accessing }
BlElementOffsetCompositionLayerSignal >> newPosition [

	^ newPosition
]

{ #category : #accessing }
BlElementOffsetCompositionLayerSignal >> newPosition: anObject [

	newPosition := anObject
]

{ #category : #accessing }
BlElementOffsetCompositionLayerSignal >> oldPosition [

	^ oldPosition
]

{ #category : #accessing }
BlElementOffsetCompositionLayerSignal >> oldPosition: anObject [

	oldPosition := anObject
]

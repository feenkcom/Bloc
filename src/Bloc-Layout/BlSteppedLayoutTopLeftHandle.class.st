Class {
	#name : #BlSteppedLayoutTopLeftHandle,
	#superclass : #BlSteppedLayoutHandle,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #measure }
BlSteppedLayoutTopLeftHandle >> state: aState measure: aCollectionOfLayoutChildNode [
	| handleNode childPosition |
	aCollectionOfLayoutChildNode ifEmpty: [ ^ self ].

	handleNode := aCollectionOfLayoutChildNode at: 1.
	aState measureChild: handleNode.
	childPosition := aState anchorBounds origin.
	handleNode position: childPosition.
	aCollectionOfLayoutChildNode allButFirstDo: [ :eachChild | 
		aState measureAndPlaceChild: eachChild ]
]

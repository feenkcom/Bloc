Class {
	#name : #BlSteppedCenterHandle,
	#superclass : #BlSteppedHandle,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #measure }
BlSteppedCenterHandle >> state: aState measure: aCollectionOfLayoutChildNode [
	| handleNode handlePosition halfExtent anchorCenter |
	aCollectionOfLayoutChildNode ifEmpty: [ ^ self ].

	handleNode := aCollectionOfLayoutChildNode at: 1.
	aState measureChild: handleNode.
	halfExtent := handleNode extent / 2.0.
	anchorCenter := aState anchorBounds center.
	handlePosition := anchorCenter - halfExtent.
	handleNode position: handlePosition.
	aCollectionOfLayoutChildNode allButFirstDo: [ :eachChild | 
		aState measureAndPlaceChild: eachChild ]
]

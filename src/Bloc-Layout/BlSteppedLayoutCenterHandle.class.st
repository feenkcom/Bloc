Class {
	#name : #BlSteppedLayoutCenterHandle,
	#superclass : #BlSteppedLayoutHandle,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #measure }
BlSteppedLayoutCenterHandle >> state: aState measure: aCollectionOfLayoutChildNode [
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

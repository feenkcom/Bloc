Class {
	#name : #BlSteppedLayoutTooltipHandle,
	#superclass : #BlSteppedLayoutHandle,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #measure }
BlSteppedLayoutTooltipHandle >> state: aState measure: aCollectionOfLayoutChildNode [
	| handleNode handlePositionX handleExtent anchorCenterX originalAnchorBounds newAnchorBounds handlePositionY childMark handlePosition |
	aCollectionOfLayoutChildNode ifEmpty: [ ^ self ].

	handleNode := aCollectionOfLayoutChildNode at: 1.
	aState measureChild: handleNode.
	handleExtent := handleNode extent.

	originalAnchorBounds := aState anchorBounds.
	newAnchorBounds := originalAnchorBounds expandBy: handleExtent.
	aState anchorBounds: newAnchorBounds.

	aCollectionOfLayoutChildNode allButFirstDo: [ :eachChild | 
		aState measureAndPlaceChild: eachChild ].
		
	childMark := aCollectionOfLayoutChildNode size > 1
		ifTrue: [ aCollectionOfLayoutChildNode second constraints stepped mark ]
		ifFalse: [ BlSteppedLayoutMark allToBottom ].
	
	handlePosition := BlSteppedLayoutTooltipHandlePositionBuilder new
		mark: childMark;
		anchorBounds: originalAnchorBounds;
		handleExtent: handleExtent;
		build.
	
	handleNode position: handlePosition
]

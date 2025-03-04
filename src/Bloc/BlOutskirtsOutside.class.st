Class {
	#name : #BlOutskirtsOutside,
	#superclass : #BlOutskirts,
	#category : #'Bloc-Core-Border'
}

{ #category : #'visual bounds' }
BlOutskirtsOutside >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	^ anElement geometry strokedBoundsOutside: aBlBounds of: anElement on: aCanvas
]

{ #category : #testing }
BlOutskirtsOutside >> wantsLayerOn: anElement [
	"Return true if background and border should be rendered on a separate layer,
	false otherwise"
	<return: #Boolean>
	
	^ anElement border isVisible
]

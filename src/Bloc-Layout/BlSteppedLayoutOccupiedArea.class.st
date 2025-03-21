"
I define an occupied area (bounds) where an {{gtClass:BlElement}} is placed.
#Example
The following example has three occupied areas which you can explore individually by clicking on the occupied areas buttons: {{gtExample:BlSteppedLayoutExamples >>atMostNodeWithThreeExactChildren_layoutState_measureThirdChild | codeExpanded=false | previewExpanded=true | previewHeight=980}}
"
Class {
	#name : #BlSteppedLayoutOccupiedArea,
	#superclass : #Object,
	#instVars : [
		'previousArea',
		'bounds',
		'selectedArea',
		'requestedExtent',
		'availableAreas',
		'layoutState'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #'accessing - available areas' }
BlSteppedLayoutOccupiedArea >> availableAreas [
	<return: #Collection of: #BlSteppedLayoutArea>
	^ availableAreas
]

{ #category : #'accessing - available areas' }
BlSteppedLayoutOccupiedArea >> availableAreas: aCollectionOfAvailableAreas [ 
	availableAreas := aCollectionOfAvailableAreas
]

{ #category : #'accessing - child bounds' }
BlSteppedLayoutOccupiedArea >> bottom [
	^ self bounds bottom
]

{ #category : #'accessing - child bounds' }
BlSteppedLayoutOccupiedArea >> bounds [
	<return: #Rectangle>
	^ bounds
]

{ #category : #'accessing - child bounds' }
BlSteppedLayoutOccupiedArea >> bounds: aRectangle [
	bounds := aRectangle
]

{ #category : #'accessing - selected area' }
BlSteppedLayoutOccupiedArea >> direction [
	^ self area direction
]

{ #category : #'accessing - child bounds' }
BlSteppedLayoutOccupiedArea >> extent [
	^ self bounds extent
]

{ #category : #'accessing - child bounds' }
BlSteppedLayoutOccupiedArea >> height [
	^ self bounds height
]

{ #category : #'accessing - selected area' }
BlSteppedLayoutOccupiedArea >> horizontalAlignment [
	^ self selectedArea horizontalAlignment
]

{ #category : #accessing }
BlSteppedLayoutOccupiedArea >> layoutState [
	<return: #BlSteppedLayoutState>
	^ layoutState
]

{ #category : #accessing }
BlSteppedLayoutOccupiedArea >> layoutState: aLayoutState [
	layoutState := aLayoutState
]

{ #category : #'accessing - child bounds' }
BlSteppedLayoutOccupiedArea >> left [
	^ self bounds left
]

{ #category : #'accessing - selected area' }
BlSteppedLayoutOccupiedArea >> mark [
	<return: #BlSteppedLayoutMark>
	^ self selectedArea mark
]

{ #category : #accessing }
BlSteppedLayoutOccupiedArea >> previousArea [
	<return: #BlSteppedLayoutOccupiedArea>
	^ previousArea
]

{ #category : #accessing }
BlSteppedLayoutOccupiedArea >> previousArea: aSelectedArea [
	previousArea := aSelectedArea
]

{ #category : #printing }
BlSteppedLayoutOccupiedArea >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [ 
		aStream print: (self bounds ifNotNil: #rounded) ]
]

{ #category : #'accessing - child bounds' }
BlSteppedLayoutOccupiedArea >> requestedExtent [
	^ requestedExtent
]

{ #category : #'accessing - child bounds' }
BlSteppedLayoutOccupiedArea >> requestedExtent: aRectangle [
	requestedExtent := aRectangle
]

{ #category : #'accessing - child bounds' }
BlSteppedLayoutOccupiedArea >> right [
	^ self bounds right
]

{ #category : #'accessing - selected area' }
BlSteppedLayoutOccupiedArea >> selectedArea [
	<return: #BlSteppedLayoutArea>
	^ selectedArea
]

{ #category : #'accessing - selected area' }
BlSteppedLayoutOccupiedArea >> selectedArea: aLayoutArea [
	selectedArea := aLayoutArea
]

{ #category : #'accessing - child bounds' }
BlSteppedLayoutOccupiedArea >> top [
	^ self bounds top
]

{ #category : #'accessing - selected area' }
BlSteppedLayoutOccupiedArea >> verticalAlignment [
	^ self selectedArea verticalAlignment
]

{ #category : #'accessing - child bounds' }
BlSteppedLayoutOccupiedArea >> width [
	^ self bounds width
]

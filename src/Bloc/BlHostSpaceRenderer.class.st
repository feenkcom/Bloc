Class {
	#name : #BlHostSpaceRenderer,
	#superclass : #Object,
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #initialization }
BlHostSpaceRenderer >> initializeForSurface: aSurface [
	"Initalize space renderer to be used with a given surface"

	self subclassResponsibility
]

{ #category : #rendering }
BlHostSpaceRenderer >> renderSpace: aSpace [
	"Render a space and return a collection of damaged rectangles"
	<return: #Collection of: #Rectangle>
	
	^ self subclassResponsibility
]

{ #category : #initialization }
BlHostSpaceRenderer >> resizeForSurface: aSurface [
	"Resize space renderer to be used with a given surface"

	self initializeForSurface: aSurface
]

Class {
	#name : #BlSpartaMetalSpaceRenderer,
	#superclass : #BlSpartaHardwareAcceleratedSpaceRenderer,
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #rendering }
BlSpartaMetalSpaceRenderer >> damagedAreasOf: aSpace [
	^ { 0@0 extent: aSpace extent }
]

{ #category : #initialization }
BlSpartaMetalSpaceRenderer >> initializeForSurface: aMetalSurface [
	"Initalize sparta canvas to be used with a given surface"
	| aSpartaCanvas |

	aSpartaCanvas := (BlSpartaRenderer pickCanvasForSurface: aMetalSurface) forMetalOn: aMetalSurface.

	self
		initializeCanvas: aSpartaCanvas
		surface: aMetalSurface
]

{ #category : #rendering }
BlSpartaMetalSpaceRenderer >> renderSpace: aSpace [
	"Render a space and return a collection of damaged rectangles"
	<return: #Collection of: #Rectangle>
	| theDirtyAreas aLogicalExtent |
	
	self isValid
		ifFalse: [ ^ self ].
	
	aLogicalExtent := (physicalSize asLogical: self scaleFactor) asPoint.
	
	"collect the dirty area to be updated"
	theDirtyAreas := (self damagedAreasOf: aSpace)
		collect: [ :each | each intersect: (0@0 extent: aLogicalExtent) ifNone: [ nil ] ]
		thenSelect: [ :each | each isNotNil and: [ each hasPositiveExtent ] ].

	theDirtyAreas
		ifEmpty: [ ^ self ].

	spartaCanvas transform
		by: [ :t | t scaleBy: scaleFactor asPoint ]
		during: [
			theDirtyAreas do: [ :aBlBounds |
				spartaCanvas clip by: aBlBounds during: [ aSpace fullDrawOn: spartaCanvas ] ] ].

	spartaCanvas flush.
	
	^ theDirtyAreas
]

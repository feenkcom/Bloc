"
I define a possible area (bounds) where an {{gtClass:BlElement}} can be placed.
#Example
Several areas are available In the following example. Hover the initial available areas: {{gtExample:BlSteppedLayoutExamples >>atMostNodeWithThreeExactChildren_layoutState | codeExpanded=false | previewExpanded=true | previewHeight=750}}
"
Class {
	#name : #BlSteppedLayoutArea,
	#superclass : #Object,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#instVars : [
		'bounds',
		'direction',
		'verticalAlignment',
		'horizontalAlignment',
		'previousArea',
		'mark'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #accessing }
BlSteppedLayoutArea >> bottom [
	^ bounds bottom
]

{ #category : #accessing }
BlSteppedLayoutArea >> bounds [
	^ bounds
]

{ #category : #accessing }
BlSteppedLayoutArea >> bounds: anObject [
	bounds := anObject
]

{ #category : #accessing }
BlSteppedLayoutArea >> direction [
	^ direction
]

{ #category : #accessing }
BlSteppedLayoutArea >> direction: anObject [
	direction := anObject
]

{ #category : #accessing }
BlSteppedLayoutArea >> extent [
	^ bounds extent
]

{ #category : #'api - testing' }
BlSteppedLayoutArea >> hasEnoughHeightFor: aLayoutChildNode [
	^ self bounds height >= aLayoutChildNode height
]

{ #category : #'api - testing' }
BlSteppedLayoutArea >> hasEnoughSpaceFor: aLayoutChildNode [
	^ self bounds width >= aLayoutChildNode width
		and: [ self bounds height >=  aLayoutChildNode height ]
]

{ #category : #'api - testing' }
BlSteppedLayoutArea >> hasEnoughWidthFor: aLayoutChildNode [
	^ self bounds width >= aLayoutChildNode width
]

{ #category : #accessing }
BlSteppedLayoutArea >> height [
	^ bounds height
]

{ #category : #accessing }
BlSteppedLayoutArea >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ horizontalAlignment
]

{ #category : #accessing }
BlSteppedLayoutArea >> horizontalAlignment: aBlElementAlignment [
	horizontalAlignment := aBlElementAlignment
]

{ #category : #initialization }
BlSteppedLayoutArea >> initialize [
	super initialize.
	
	self alignNone
]

{ #category : #accessing }
BlSteppedLayoutArea >> left [
	^ bounds left
]

{ #category : #accessing }
BlSteppedLayoutArea >> mark [
	^ mark ifNil: [ mark := BlSteppedLayoutMark undefined ]
]

{ #category : #accessing }
BlSteppedLayoutArea >> mark: anObject [
	mark := anObject
]

{ #category : #'api - positioning' }
BlSteppedLayoutArea >> positionOfMeasuredChild: aLayoutChildNode [
	^ (horizontalAlignment + verticalAlignment)
		translationOf: aLayoutChildNode layoutBounds
		in: bounds
]

{ #category : #accessing }
BlSteppedLayoutArea >> previousArea [
	^ previousArea
]

{ #category : #accessing }
BlSteppedLayoutArea >> previousArea: anObject [
	previousArea := anObject
]

{ #category : #printing }
BlSteppedLayoutArea >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [ 
		aStream print: (self bounds ifNotNil: #rounded) ]
]

{ #category : #accessing }
BlSteppedLayoutArea >> right [
	^ bounds right
]

{ #category : #accessing }
BlSteppedLayoutArea >> top [
	^ bounds top
]

{ #category : #accessing }
BlSteppedLayoutArea >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ verticalAlignment
]

{ #category : #accessing }
BlSteppedLayoutArea >> verticalAlignment: aBlElementAlignment [
	verticalAlignment := aBlElementAlignment
]

{ #category : #accessing }
BlSteppedLayoutArea >> width [
	^ bounds width
]

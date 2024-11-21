Class {
	#name : #BlSteppedLayoutArea,
	#superclass : #Object,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#instVars : [
		'bounds',
		'direction',
		'alignment',
		'verticalAlignment',
		'horizontalAlignment',
		'previousArea'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
BlSteppedLayoutArea >> extent [
	^ bounds extent
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutArea >> hasEnoughSpaceFor: aLayoutChildNode [
	^ self bounds width >= aLayoutChildNode width
		and: [ self bounds height >=  aLayoutChildNode height ]
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

{ #category : #'as yet unclassified' }
BlSteppedLayoutArea >> initialize [
	super initialize.
	
	self alignNone
]

{ #category : #'as yet unclassified' }
BlSteppedLayoutArea >> left [
	^ bounds left
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
BlSteppedLayoutArea >> right [
	^ bounds right
]

{ #category : #'as yet unclassified' }
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

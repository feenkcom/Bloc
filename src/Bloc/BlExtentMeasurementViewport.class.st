Class {
	#name : #BlExtentMeasurementViewport,
	#superclass : #Object,
	#instVars : [
		'edge',
		'bounds'
	],
	#classVars : [
		'BottomEdge',
		'LeftEdge',
		'RightEdge',
		'TopEdge'
	],
	#category : #'Bloc-Layouts-Support'
}

{ #category : #'instance creation' }
BlExtentMeasurementViewport class >> fromBottomEdge: aRectangle [
	^ self new
		setEdge: BottomEdge
		bounds: aRectangle
]

{ #category : #'instance creation' }
BlExtentMeasurementViewport class >> fromLeftEdge: aRectangle [
	^ self new
		setEdge: LeftEdge
		bounds: aRectangle
]

{ #category : #'instance creation' }
BlExtentMeasurementViewport class >> fromRightEdge: aRectangle [
	^ self new
		setEdge: RightEdge
		bounds: aRectangle
]

{ #category : #'instance creation' }
BlExtentMeasurementViewport class >> fromTopEdge: aRectangle [
	^ self new
		setEdge: TopEdge
		bounds: aRectangle
]

{ #category : #'class initialization' }
BlExtentMeasurementViewport class >> initialize [
	TopEdge := #Top.
	RightEdge := #Right.
	BottomEdge := #Bottom.
	LeftEdge := #Left
]

{ #category : #'as yet unclassified' }
BlExtentMeasurementViewport >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject bounds = bounds
		and: [ anotherObject edge = edge ]
]

{ #category : #'as yet unclassified' }
BlExtentMeasurementViewport >> bounds [
	^ bounds
]

{ #category : #'as yet unclassified' }
BlExtentMeasurementViewport >> edge [
	^ edge
]

{ #category : #comparing }
BlExtentMeasurementViewport >> hash [
	^ (bounds hash + edge hash) hashMultiply
]

{ #category : #'as yet unclassified' }
BlExtentMeasurementViewport >> ifTop: aTopBlock ifRight: aRightBlock ifBottom: aBottomBlock ifLeft: aLeftBlock [
	edge = TopEdge
		ifTrue: [ ^ aTopBlock cull: self ].
	edge = RightEdge
		ifTrue: [ ^ aRightBlock cull: self ].
	edge = BottomEdge
		ifTrue: [ ^ aBottomBlock cull: self ].
	edge = LeftEdge
		ifTrue: [ ^ aLeftBlock cull: self ].
	
	self error: ('Unknown edge type: {1}' format: { edge printString })
]

{ #category : #initialization }
BlExtentMeasurementViewport >> setEdge: anEdgeSymbol bounds: aRectangle [
	edge := anEdgeSymbol.
	bounds := aRectangle
]

{ #category : #'as yet unclassified' }
BlExtentMeasurementViewport >> shrunkFromBottomBy: aNumber [
	^ self class new
		setEdge: edge
		bounds: (bounds bottom: bounds bottom - aNumber)
]

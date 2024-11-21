Class {
	#name : #BlManhattanLineGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'from',
		'to',
		'orientation',
		'cornerRadius',
		'splitMode',
		'proportion',
		'fixedDistance'
	],
	#category : #'Bloc-Basic'
}

{ #category : #accessing }
BlManhattanLineGeometry >> beAutomatic [
	orientation := #automatic
]

{ #category : #'as yet unclassified' }
BlManhattanLineGeometry >> beFixedFrom [
	splitMode := #fixedFrom
]

{ #category : #'as yet unclassified' }
BlManhattanLineGeometry >> beFixedTo [
	splitMode := #fixedTo
]

{ #category : #accessing }
BlManhattanLineGeometry >> beHorizontal [
	orientation := #horizontal
]

{ #category : #'as yet unclassified' }
BlManhattanLineGeometry >> beProportional [
	splitMode := #proportional
]

{ #category : #accessing }
BlManhattanLineGeometry >> beVertical [
	orientation := #vertical
]

{ #category : #'accesing - defaults' }
BlManhattanLineGeometry >> cornerRadius [
	^ {cornerRadius.
		((from x - to x) / 2) abs.
		((from y - to y) / 2) abs} min
]

{ #category : #acccessing }
BlManhattanLineGeometry >> cornerRadius: aNumber [ 
	cornerRadius := aNumber
]

{ #category : #'as yet unclassified' }
BlManhattanLineGeometry >> fixedDistance: aNumber [ 
	fixedDistance := aNumber
]

{ #category : #converting }
BlManhattanLineGeometry >> from: aFromPoint to: aToPoint [
	from := aFromPoint.
	to := aToPoint
]

{ #category : #accessing }
BlManhattanLineGeometry >> initialize [
	super initialize.
	from := 0@0.
	to := 0@0.
	cornerRadius := 0.
	orientation := #horizontal.
	splitMode := #proportional.
	proportion := 0.5.
	fixedDistance := 100
]

{ #category : #testing }
BlManhattanLineGeometry >> isHorizontal [
	^ orientation = #horizontal or: [orientation = #automatic and: [ self isSlopeMoreHorizontal ]]
]

{ #category : #testing }
BlManhattanLineGeometry >> isSlopeMoreHorizontal [
	| delta |
	delta := from - to.
	^delta x abs > delta y abs
]

{ #category : #testing }
BlManhattanLineGeometry >> isSlopeMoreVertical [
	| delta |
	delta := from - to.
	^delta y abs > delta x abs
]

{ #category : #testing }
BlManhattanLineGeometry >> isVertical [
	^ orientation = #vertical or: [orientation = #automatic and: [ self isSlopeMoreVertical ]]
]

{ #category : #geometry }
BlManhattanLineGeometry >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #'as yet unclassified' }
BlManhattanLineGeometry >> proportion: aFloat [ 
	proportion := aFloat
]

{ #category : #accessing }
BlManhattanLineGeometry >> vertices [
	| midX midY |
	splitMode = #proportional
		ifTrue: [ midX := (from x + to x) * proportion.
			midY := (from y + to y) * proportion ].
	splitMode = #fixedFrom
		ifTrue: [ midX := from x + fixedDistance.
			midY := from y + fixedDistance ].
	splitMode = #fixedTo
		ifTrue: [ midX := (to x - fixedDistance) * self horizontalUnitVector x.
			midY := (to y - fixedDistance) * self verticalUnitVector y ].
	^ self isHorizontal
		ifTrue: [ {from.
				midX @ from y.
				midX @ to y.
				to} ]
		ifFalse: [ {from.
				from x @ midY.
				to x @ midY.
				to} ]
]

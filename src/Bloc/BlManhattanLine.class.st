Class {
	#name : #BlManhattanLine,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'from',
		'to',
		'orientation'
	],
	#category : #'Bloc-Basic'
}

{ #category : #accessing }
BlManhattanLine >> beAutomatic [
	orientation := #automatic
]

{ #category : #accessing }
BlManhattanLine >> beHorizontal [
	orientation := #horizontal
]

{ #category : #accessing }
BlManhattanLine >> beVertical [
	orientation := #vertical
]

{ #category : #'instance creation' }
BlManhattanLine >> from: aFromPoint to: aToPoint [
	from := aFromPoint.
	to := aToPoint
]

{ #category : #accessing }
BlManhattanLine >> initialize [
	super initialize.
	from := 0@0.
	to := 0@0.
	orientation := #horizontal
]

{ #category : #testing }
BlManhattanLine >> isHorizontal [
	^ orientation = #horizontal or: [orientation = #automatic and: [ self isSlopeMoreHorizontal ]]
]

{ #category : #testing }
BlManhattanLine >> isSlopeMoreHorizontal [
	| delta |
	delta := from - to.
	^delta x abs > delta y abs
]

{ #category : #testing }
BlManhattanLine >> isSlopeMoreVertical [
	| delta |
	delta := from - to.
	^delta y abs > delta x abs
]

{ #category : #testing }
BlManhattanLine >> isVertical [
	^ orientation = #vertical or: [orientation = #automatic and: [ self isSlopeMoreVertical ]]
]

{ #category : #geometry }
BlManhattanLine >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #accessing }
BlManhattanLine >> vertices [
	| midX midY |
	midX := (from x + to x) / 2.0.
	midY := (from y + to y) / 2.0.
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

Class {
	#name : #BlGridLayoutBaselineBounds,
	#superclass : #BlGridLayoutBounds,
	#instVars : [
		'size'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #accessing }
BlGridLayoutBaselineBounds >> includeSize: aSize [
	"before + after of a child is its size; take the size itself, the sum rounds when before is UNDEFINED"
	size := size max: aSize
]

{ #category : #accessing }
BlGridLayoutBaselineBounds >> offset: anElement alignment: anAlignment size: aSize [
	^ (super offset: anElement alignment: anAlignment size: aSize) max: 0
]

{ #category : #initialization }
BlGridLayoutBaselineBounds >> reset [
	super reset.
	size := UNDEFINED
]

{ #category : #accessing }
BlGridLayoutBaselineBounds >> size: min [
	^(super size: min) max: size
]

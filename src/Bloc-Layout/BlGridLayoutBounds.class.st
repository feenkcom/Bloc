"
For each group (with a given alignment) we need to store the amount of space required before the alignment point and the amount of space required after it. One side of this calculation is always 0 for START and END alignments but we don't make use of this. For CENTER and BASELINE alignments both sides are needed and in the BASELINE case no simple optimisations are possible.

The general algorithm therefore is to create a Map (actually a PackedMap) from group to Bounds and to loop through all Views in the group taking the maximum of the values for each View.

Children with a fill, undefined or baseline alignment have no alignment point; their alignment value is the UNDEFINED sentinel (about -2^30). Their size is kept apart in undefinedSize rather than stored as size - UNDEFINED in after: in Floats that difference only resolves steps of 2^-22, and adding UNDEFINED back changed fractional sizes, which made grid columns overflow at display scales other than 1. See BlGridLayoutFractionalSizeExamples.
"
Class {
	#name : #BlGridLayoutBounds,
	#superclass : #Object,
	#instVars : [
		'before',
		'after',
		'flexibility',
		'undefinedSize'
	],
	#pools : [
		'BlGridLayoutConstants'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #accessing }
BlGridLayoutBounds class >> canStretch [
	^ BlGridFlexibility canStretch
]

{ #category : #accessing }
BlGridLayoutBounds class >> inflexible [
	^ BlGridFlexibility inflexible
]

{ #category : #accessing }
BlGridLayoutBounds class >> maxSize [
	^ 100000
]

{ #category : #testing }
BlGridLayoutBounds >> canStretch [
	^ flexibility = self class canStretch
]

{ #category : #accessing }
BlGridLayoutBounds >> includeElement: anElement spec: aSpec axis: anAxis size: size [
	"Fill, undefined and baseline alignments have no alignment point and answer the UNDEFINED sentinel (about -2^30). Their size is kept apart in undefinedSize: storing size - UNDEFINED in after loses the low bits of fractional sizes (a double resolves only 2^-22 at 2^30), so the columns of a grid at a display scale other than 1 could need more than the grid. See BlGridLayoutFractionalSizeExamples"
	| alignment newBefore |
	flexibility := flexibility and: aSpec flexibility.
	alignment := aSpec absoluteAlignment: anAxis horizontal.
	newBefore := alignment alignmentValue: anElement viewSize: size.
	before < newBefore ifTrue: [before := newBefore].
	newBefore = UNDEFINED
		ifTrue: [undefinedSize < size ifTrue: [undefinedSize := size]]
		ifFalse: 
			[| newAfter |
			newAfter := size - newBefore.
			after < newAfter ifTrue: [after := newAfter]].
	self includeSize: size
]

{ #category : #accessing }
BlGridLayoutBounds >> includeSize: aSize [
	"A hook for subclasses that need the full size of every child, see BlGridLayoutBaselineBounds"
	
]

{ #category : #initialization }
BlGridLayoutBounds >> initialize [
	super initialize.
	
	self reset
]

{ #category : #accessing }
BlGridLayoutBounds >> offset: anElement alignment: anAlignment size: size [
	^ before - (anAlignment alignmentValue: anElement viewSize: size)
]

{ #category : #printing }
BlGridLayoutBounds >> printOn: aStream [
	aStream
		nextPutAll: 'before: ';
		nextPutAll: before asString;
		nextPutAll: ' after: ';
		nextPutAll: after asString;
		nextPutAll: ' undefinedSize: ';
		nextPutAll: undefinedSize asString;
		nextPutAll: ' size(false): ';
		nextPutAll: (self size: false) asString;
		nextPutAll: ' size(true): ';
		nextPutAll: (self size: true) asString
]

{ #category : #initialization }
BlGridLayoutBounds >> reset [
	before := UNDEFINED.
	after := UNDEFINED.
	undefinedSize := UNDEFINED.
	flexibility := self class canStretch	"we are flexible when empty"
]

{ #category : #accessing }
BlGridLayoutBounds >> size: min [
	"A group of only undefined-aligned children needs exactly its largest size. Mixed with aligned children, the undefined ones still extend past the alignment point by their size minus UNDEFINED, as before"
	(min not and: [self canStretch]) ifTrue: [^self class maxSize].
	undefinedSize = UNDEFINED ifTrue: [^before + after].
	before = UNDEFINED ifTrue: [^undefinedSize].
	^before + (undefinedSize - UNDEFINED max: after)
]

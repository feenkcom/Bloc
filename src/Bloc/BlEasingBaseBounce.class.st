Class {
	#name : #BlEasingBaseBounce,
	#superclass : #BlEasing,
	#category : #'Bloc-Core-Interpolators'
}

{ #category : #interpolation }
BlEasingBaseBounce >> computeBounce: aProgress [
	| a b |
	a := 0.
	b := 1.
	
	[ aProgress >= ((7 - (4 * a)) / 11)
		ifTrue: [ ^ ((11 - (6 * a) - (11 * aProgress)) / 4 raisedTo: 2) negated + (b raisedTo: 2) ].
	a := a + b.
	b := b / 2 ] repeat
]

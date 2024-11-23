Class {
	#name : #BlEasingQuad,
	#superclass : #BlEasing,
	#category : #'Bloc-Core-Interpolators'
}

{ #category : #interpolation }
BlEasingQuad >> interpolate: aProgress [
	^ aProgress raisedTo: 2
]

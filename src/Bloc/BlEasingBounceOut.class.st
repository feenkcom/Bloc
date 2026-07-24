Class {
	#name : #BlEasingBounceOut,
	#superclass : #BlEasingBaseBounce,
	#category : #'Bloc-Core-Interpolators'
}

{ #category : #interpolation }
BlEasingBounceOut >> interpolate: aProgress [
	^ 1-(self computeBounce:(1-aProgress))
]

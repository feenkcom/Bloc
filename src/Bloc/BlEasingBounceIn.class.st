Class {
	#name : #BlEasingBounceIn,
	#superclass : #BlEasingBaseBounce,
	#category : #'Bloc-Core-Interpolators'
}

{ #category : #interpolation }
BlEasingBounceIn >> interpolate: aProgress [
	^ self computeBounce: aProgress
]

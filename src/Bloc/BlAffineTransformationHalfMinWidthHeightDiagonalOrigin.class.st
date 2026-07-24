Class {
	#name : #BlAffineTransformationHalfMinWidthHeightDiagonalOrigin,
	#superclass : #BlAffineTransformationOrigin,
	#category : #'Bloc-Core-Transformations'
}

{ #category : #math }
BlAffineTransformationHalfMinWidthHeightDiagonalOrigin >> originIn: anElement [
	"@see Method comment BlAffineTransformationOrigin>>#originIn:"

	<return: #Point or: #BlPoint3D>
	^ ((anElement height min: anElement width) / 2.0)
		@ ((anElement height min: anElement width) / 2.0)
]

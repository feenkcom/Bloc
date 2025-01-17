Extension { #name : #Rectangle }

{ #category : #'*Bloc' }
Rectangle >> asBlocFloatRectangle [
	^ self origin asFloatPoint corner: self corner asFloatPoint
]

{ #category : #'*Bloc' }
Rectangle >> blocEnlargedBy: aPoint [
	"Return a new rectangle enlarged by the given point in all directions."

	^ self origin - aPoint corner: self corner + aPoint
]

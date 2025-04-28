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

{ #category : #'*Bloc' }
Rectangle >> blocRelocateFullyInsideRectangle: aRectangle [
	"Return a new rectangle that is fully inside of the given rectangle."

	| aShiftY aShiftX |
	(aRectangle containsRect: self) ifTrue: [ ^ self ].

	aShiftX := ((aRectangle containsPoint: self origin x @ 0)
			and: [ aRectangle containsPoint: self corner x @ 0 ])
			ifTrue: [ 0 ]
			ifFalse: [ | anOriginX aCornerX |
				anOriginX := aRectangle origin x - self origin x.
				aCornerX := aRectangle corner x - self corner x.

				anOriginX abs < aCornerX abs ifTrue: [ anOriginX ] ifFalse: [ aCornerX ] ].


	aShiftY := ((aRectangle containsPoint: 0 @ self origin y)
			and: [ aRectangle containsPoint: 0 @ self corner y ])
			ifTrue: [ 0 ]
			ifFalse: [ | anOriginY aCornerY |
				anOriginY := aRectangle origin y - self origin y.
				aCornerY := aRectangle corner y - self corner y.

				anOriginY abs < aCornerY abs ifTrue: [ anOriginY ] ifFalse: [ aCornerY ] ].


	^ self translateBy: aShiftX @ aShiftY
]

Extension { #name : #BlManhattanLine }

{ #category : #'*Bloc-Sparta' }
BlManhattanLine >> buildPathOnSpartaCanvas: aCanvas [
	| aCollection pathBuilder unitHoriz unitVert firstClockWise |
	aCollection := self vertices.

	pathBuilder := aCanvas path
			absolute;
			moveTo: aCollection first.
	self cornerRadius isZero
		ifTrue: [ aCollection allButFirstDo: [ :pt | pathBuilder lineTo: pt ] ]
		ifFalse: [ unitHoriz := self horizontalUnitVector.
			unitVert := self verticalUnitVector.
			
			"The first arc is clockwise if the two vectors are positive"
			firstClockWise := unitHoriz x * unitVert y > 0.
			pathBuilder lineTo: aCollection second - (unitHoriz * self cornerRadius).
			pathBuilder
				arcTo: aCollection second + (unitVert * self cornerRadius)
				angle: Float halfPi
				cw: firstClockWise.
			pathBuilder lineTo: aCollection third - (unitVert * self cornerRadius).
			pathBuilder
				arcTo: aCollection third + (unitHoriz * self cornerRadius)
				angle: Float halfPi
				cw: firstClockWise not.
			pathBuilder lineTo: aCollection last ].

	^ pathBuilder finish
]

{ #category : #'*Bloc-Sparta' }
BlManhattanLine >> horizontalUnitVector [
	| unitHoriz |
	unitHoriz := (to x @ 0 - (from x @ 0)) asBlocVector.
	unitHoriz length isZero ifFalse: [ unitHoriz := unitHoriz normalized ].
	^ unitHoriz
]

{ #category : #'*Bloc-Sparta' }
BlManhattanLine >> verticalUnitVector [
	| unitVert |
	unitVert := (0 @ to y - (0 @ from y)) asBlocVector normalized.
	unitVert length isZero ifFalse: [ unitVert := unitVert normalized ].
	^ unitVert
]

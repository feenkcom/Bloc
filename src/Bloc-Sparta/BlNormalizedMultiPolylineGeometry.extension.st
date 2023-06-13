Extension { #name : #BlNormalizedMultiPolylineGeometry }

{ #category : #'*Bloc-Sparta' }
BlNormalizedMultiPolylineGeometry >> buildPathOnSpartaCanvas: aCanvas [
	| theScaledVertices aPathBuilder |
	
	aPathBuilder := aCanvas path.
	
	self polylines do: [ :eachPolyline |
		theScaledVertices := eachPolyline collect: [ :eachVertex | (self extent * eachVertex) asFloatPoint ].
		theScaledVertices size <= 1
			ifFalse: [
				aPathBuilder moveTo: theScaledVertices first.
				theScaledVertices allButFirstDo: [ :eachVertex | aPathBuilder lineTo: eachVertex ] ] ].

	^ aPathBuilder build
]

Extension { #name : #BlStadiumGeometry }

{ #category : #'*Bloc-Sparta' }
BlStadiumGeometry >> buildPathOnSpartaCanvas: aCanvas [
	^ self
		buildPathOnSpartaCanvas: aCanvas
		orientation: self resolveOrientation
]

{ #category : #'*Bloc-Sparta' }
BlStadiumGeometry >> buildPathOnSpartaCanvas: aCanvas orientation: anOrientation [
	| aRadius aDiameter aLength |
	
	aRadius := self radiusForOrientation: anOrientation.
	aDiameter := aRadius * 2.
	aLength := self lengthForOrienatation: anOrientation.

	(aLength < aDiameter)
		ifTrue: [
			aRadius := aLength / 2.0.
			^ aCanvas shape circleAt: aRadius asPoint radius: aRadius ].
	
	anOrientation = Horizontal
		ifTrue: [
			^ aCanvas path
				relative;
				moveTo: aRadius @ 0;
				lineTo: (self extent x - aDiameter) @ 0;
				cwArcTo: 0 @ aDiameter angle: 180 degreesToRadians;
				lineTo: (self extent x - aDiameter) negated @ 0;
				cwArcTo: 0 @ aDiameter negated angle: 180 degreesToRadians;
				close;
				build ].

	anOrientation = Vertical
		ifTrue: [
			^ aCanvas path
				relative;
				moveTo: 0 @ aRadius;
				cwArcTo: aDiameter @ 0 angle: 180 degreesToRadians;
				lineTo: 0 @ (self extent y - aDiameter);
				cwArcTo: aDiameter negated @ 0 angle: 180 degreesToRadians;
				lineTo: 0 @ (self extent y - aDiameter) negated;
				close;
				build ].

	self error: 'Unsupported orientation: ', anOrientation printString
		
]

Extension { #name : #BlStadium }

{ #category : #'*Bloc-Sparta' }
BlStadium >> buildPathOnSpartaCanvas: aCanvas [
	| aRadius aDiameter |
	
	aRadius := self radius.
	aDiameter := aRadius * 2.

	(aDiameter < self extent y)
		ifTrue: [
			aRadius := self extent y / 2.0.
			^ aCanvas shape circleAt: aRadius asPoint radius: aRadius ].

	^ aCanvas path
		relative;
		moveTo: aRadius @ 0;
		lineTo: (self extent x - aDiameter) @ 0;
		cwArcTo: 0 @ aDiameter angle: 180 degreesToRadians;
		lineTo: (self extent x - aDiameter) negated @ 0;
		cwArcTo: 0 @ aDiameter negated angle: 180 degreesToRadians;
		close;
		build
]

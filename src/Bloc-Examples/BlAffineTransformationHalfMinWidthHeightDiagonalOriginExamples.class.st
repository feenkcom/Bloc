Class {
	#name : #BlAffineTransformationHalfMinWidthHeightDiagonalOriginExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples'
}

{ #category : #'as yet unclassified' }
BlAffineTransformationHalfMinWidthHeightDiagonalOriginExamples >> overlappingLabels [
	<gtExample>
	| container rotated original measuredContainer |
	container := BlElement new
			layout: BlBasicLayout new;
			constraintsDo: [ :c | 
				c vertical matchParent.
				c horizontal matchParent ].
	original := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new fontSize: 20);
			text: 'Original label';
			padding: (BlInsets left: 30);
			background: (Color blue alpha: 0.5).
	rotated := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new fontSize: 20);
			text: 'Rotated label';
			constraintsDo: [ :c | c accountTransformation ];
			background: (Color red alpha: 0.5);
			padding: (BlInsets left: 30);
			transformDo: [ :aBuilder | 
				aBuilder
					origin: BlAffineTransformationHalfMinWidthHeightDiagonalOrigin new;
					rotateBy: 90 ].
	container
		addChild: original;
		addChild: rotated.
	measuredContainer := BlScripter new
			element: container;
			elementWithoutParent.
	self
		assert: measuredContainer children second bounds inParent position x
		equals: 0.
	^ container
]

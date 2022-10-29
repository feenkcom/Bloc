Class {
	#name : #BlBenchmarkExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Benchmark'
}

{ #category : #acccessing }
BlBenchmarkExamples >> nestedElementsWithTransformation: anAmountOfElements [
	| rootElement currentElement anElementStencil |

	anElementStencil := [
		BrFrame new
			matchParent;
			alignCenter;
			background: (Color gray alpha: (1.0 / anAmountOfElements));
			constraintsDo: [ :c | c frame vertical alignCenter; weight: (1.0 - (1.0 / anAmountOfElements)) ];
			constraintsDo: [ :c | c frame horizontal alignCenter; weight: (1.0 - (1.0 / anAmountOfElements))  ];
			transformDo: [ :t | t rotateBy: 1 ] ] asStencil.

	currentElement := rootElement := anElementStencil asElement.
	anAmountOfElements timesRepeat: [
		| childElement |
		childElement := anElementStencil asElement.
		currentElement addChild: childElement.
		currentElement := childElement ].

	^ rootElement
]

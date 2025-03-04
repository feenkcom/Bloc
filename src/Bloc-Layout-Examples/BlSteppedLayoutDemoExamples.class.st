Class {
	#name : #BlSteppedLayoutDemoExamples,
	#superclass : #Object,
	#category : #'Bloc-Layout-Examples-Stepped'
}

{ #category : #'examples - demo' }
BlSteppedLayoutDemoExamples >> atMostPaddingNodeWithFirstLargerChild_childOneExtent [
	<gtExample>
	| aParentNode aChildConstraints |
	aParentNode := BlSteppedLayoutExamples new
			atMostPaddingNodeWithFirstLargerChild.
	aChildConstraints := aParentNode children first constraints.
	^ aChildConstraints horizontal resizer size @ aChildConstraints vertical resizer size
]

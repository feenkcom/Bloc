Class {
	#name : #BlSteppedLayoutDemoExamples,
	#superclass : #Object,
	#category : #'Bloc-Layout-Examples-Stepped'
}

{ #category : #'examples - demo' }
BlSteppedLayoutDemoExamples >> atMostNodeWithTwoRelativeBounds_childOneExtent [
	<gtExample>
	| aParentNode aChildConstraints |
	aParentNode := BlSteppedLayoutExamples new
			atMostNodeWithTwoRelativeBounds.
	aChildConstraints := aParentNode children first constraints.
	^ aChildConstraints horizontal resizer size @ aChildConstraints vertical resizer size
]

{ #category : #'examples - demo' }
BlSteppedLayoutDemoExamples >> atMostNodeWithTwoRelativeBounds_childThreeExtent [
	<gtExample>
	| aParentNode aChildConstraints |
	aParentNode := BlSteppedLayoutExamples new
			atMostNodeWithTwoRelativeBounds.
	aChildConstraints := aParentNode children third constraints.
	^ aChildConstraints horizontal resizer size @ aChildConstraints vertical resizer size
]

{ #category : #'examples - demo' }
BlSteppedLayoutDemoExamples >> atMostNodeWithTwoRelativeBounds_childThreeRelativeBounds [
	<gtExample>
	| aParentNode aChildConstraints |
	aParentNode := BlSteppedLayoutExamples new
			atMostNodeWithTwoRelativeBounds.
	aChildConstraints := aParentNode children third constraints.
	^ aChildConstraints stepped relativeBounds
]

{ #category : #'examples - demo' }
BlSteppedLayoutDemoExamples >> atMostNodeWithTwoRelativeBounds_childTwoExtent [
	<gtExample>
	| aParentNode aChildConstraints |
	aParentNode := BlSteppedLayoutExamples new
			atMostNodeWithTwoRelativeBounds.
	aChildConstraints := aParentNode children second constraints.
	^ aChildConstraints horizontal resizer size @ aChildConstraints vertical resizer size
]

{ #category : #'examples - demo' }
BlSteppedLayoutDemoExamples >> atMostNodeWithTwoRelativeBounds_childTwoRelativeBounds [
	<gtExample>
	| aParentNode aChildConstraints |
	aParentNode := BlSteppedLayoutExamples new
			atMostNodeWithTwoRelativeBounds.
	aChildConstraints := aParentNode children second constraints.
	^ aChildConstraints stepped relativeBounds
]

{ #category : #'examples - demo' }
BlSteppedLayoutDemoExamples >> atMostPaddingNodeWithFirstLargerChild_childOneExtent [
	<gtExample>
	| aParentNode aChildConstraints |
	aParentNode := BlSteppedLayoutExamples new
			atMostPaddingNodeWithFirstLargerChild.
	aChildConstraints := aParentNode children first constraints.
	^ aChildConstraints horizontal resizer size @ aChildConstraints vertical resizer size
]

"
I contain examples of how to apply different transformations on visual elements (e.g. scale, rotation, translation)

"
Class {
	#name : #BlTransformationExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'Bloc-Examples-Basic'
}

{ #category : #examples }
BlTransformationExamples class >> reflected [
	<script: 'self reflected'>

	self
		openInWindow: self new reflection
		named: 'Reflected in both x and y axes'
		extent: 600@400
]

{ #category : #examples }
BlTransformationExamples class >> rotated [
	<script: 'self rotated'>

	self
		openInWindow: self new rotate
		named: 'Rotated by 45 degrees'
		extent: 300@300
]

{ #category : #examples }
BlTransformationExamples class >> scaled [
	<script: 'self scaled'>

	self
		openInWindow: self new scale
		named: 'Scaled by 2'
		extent: 300@300
]

{ #category : #'instance creation' }
BlTransformationExamples >> element [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		background: Color blue;
		size: self extent;
		relocate: self position;
		forceLayout	"to compute extent and position"
]

{ #category : #'instance creation' }
BlTransformationExamples >> extent [
	^ 100@100
]

{ #category : #'instance creation' }
BlTransformationExamples >> position [
	^ 100@100
]

{ #category : #'examples - transformation' }
BlTransformationExamples >> reflection [
	<gtExample>
	<return: #BlElement>
	| element |
	element := BlBasicExamples new rectangleWithImage.
	element relocate: self position.
	element transform
		flipX;
		flipY;
		apply.

	^ element
]

{ #category : #'examples - transformation' }
BlTransformationExamples >> rotate [
	<gtExample>
	<return: #BlElement>
	| element expectedOrigin expectedExtent |
	element := self element.
	element transform
		rotateBy: 45;
		apply.

	self assert: element extent equals: self extent.
	self assert: element position equals: self position.

	expectedOrigin := self extent / 2.0 * (1 - 2 sqrt).
	expectedExtent := self extent * 2 sqrt.

	self
		assert: (element bounds transformed bounds
				closeTo: (expectedOrigin extent: expectedExtent)).	"transformed bounds, are local bounds with applied transformation matrix on top"

	self
		assert: (element bounds inParent bounds
				closeTo: (expectedOrigin + self position extent: expectedExtent)).	"bounds in parent are transformed bounds additionally translated by #position in parent"

	^ element
]

{ #category : #'examples - transformation' }
BlTransformationExamples >> scale [
	<gtExample>
	<return: #BlElement>
	| element expectedOrigin expectedExtent |
	element := self element.
	element transform
		scaleBy: 2 @ 2;
		apply.

	expectedOrigin := (self extent / 2.0) negated.
	expectedExtent := self extent * 2.

	self
		assert: (element bounds transformed bounds
				closeTo: (expectedOrigin extent: expectedExtent)).	"transformed bounds, are local bounds with applied transformation matrix on top"

	self
		assert: (element bounds inParent bounds
				closeTo: (expectedOrigin + self position extent: expectedExtent)).	"bounds in parent are transformed bounds additionally translated by #position in parent"

	^ element
]

{ #category : #'examples - transformation' }
BlTransformationExamples >> translate [
	<gtExample>
	<return: #BlElement>
	| element expectedOrigin expectedExtent |
	element := self element.
	element transform
		translateBy: 50 @ 50;
		apply.

	expectedOrigin := 50 @ 50.
	expectedExtent := self extent.

	self
		assert: (element bounds transformed bounds
				closeTo: (expectedOrigin extent: expectedExtent)).	"transformed bounds, are local bounds with applied transformation matrix on top"

	self
		assert: (element bounds inParent bounds
				closeTo: (expectedOrigin + self position extent: expectedExtent)).	"bounds in parent are transformed bounds additionally translated by #position in parent"

	^ element
]

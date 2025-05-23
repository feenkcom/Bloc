Class {
	#name : #BlVector2DExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #examples }
BlVector2DExamples >> vector_0degrees [
	<gtExample>
	<return: #BlVector2D>
	| aVector |
	aVector := BlVector x: 10 y: 0.

	self assert: aVector length equals: 10.
	self assert: aVector degrees equals: 0.

	^ aVector
]

{ #category : #examples }
BlVector2DExamples >> vector_180degrees [
	<gtExample>
	<return: #BlVector2D>
	| aVector |
	aVector := BlVector x: -10 y: 0.

	self assert: aVector length equals: 10.
	self assert: aVector degrees equals: 180.

	^ aVector
]

{ #category : #examples }
BlVector2DExamples >> vector_270degrees [
	<gtExample>
	<return: #BlVector2D>
	| aVector |
	aVector := BlVector x: 0 y: -10.

	self assert: aVector length equals: 10.
	self assert: aVector degrees equals: 270.

	^ aVector
]

{ #category : #examples }
BlVector2DExamples >> vector_346degrees [
	<gtExample>
	<return: #BlVector2D>
	| aVector |
	aVector := BlVector x: 4 y: -1.

	self
		assert: (aVector length - 4.123) abs < 0.1
		description: [ 'vector length must be 4.123 +/- 0.1, but is ' , aVector length asString ].
	self
		assert: (aVector degrees - 346) abs < 0.1
		description: [ 'vector degrees must be 346 +/- 0.1, but is ' , aVector degrees asString ].

	^ aVector
]

{ #category : #examples }
BlVector2DExamples >> vector_45degrees [
	<gtExample>
	<return: #BlVector2D>
	| aVector |
	aVector := BlVector x: 10 y: 10.

	self
		assert: (aVector length - 14.14) abs < 0.1
		description: [ 'vector length must be 4.123 +/- 0.1, but is ' , aVector length asString ].
	self assert: aVector degrees equals: 45.

	^ aVector
]

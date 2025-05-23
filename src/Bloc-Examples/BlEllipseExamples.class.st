Class {
	#name : #BlEllipseExamples,
	#superclass : #BlGeometryExamples,
	#category : #'Bloc-Examples-! Documentation examples'
}

{ #category : #accessing }
BlEllipseExamples >> default [
	<gtExample>
	<return: #BlEllipseGeometry>
	| anEllipse |
	anEllipse := BlEllipseGeometry new.

	self assert: anEllipse extent equals: 150 @ 100.

	^ anEllipse
]

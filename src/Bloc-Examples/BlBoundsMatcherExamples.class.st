Class {
	#name : #BlBoundsMatcherExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #'examples - matcher' }
BlBoundsMatcherExamples >> childStartEqualParentStartWhenEquals [
	<gtExample>
	<return: #BlBoundsMatcher>
	| aMatcher |
	aMatcher := BlBoundsMatcher new
			constraints: BlBoundsMatcherConstraints new addChildStartEqualParentStart.

	aMatcher
		childStart: 30;
		parentStart: 30.
	self assert: aMatcher matches.

	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamples >> childStartEqualParentStartWhenGreater [
	<gtExample>
	<return: #BlBoundsMatcher>
	| aMatcher |
	aMatcher := BlBoundsMatcher new
			constraints: BlBoundsMatcherConstraints new addChildStartEqualParentStart.

	aMatcher
		childStart: 40;
		parentStart: 30.
	self assert: aMatcher matches not.

	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamples >> childStartEqualParentStartWhenLess [
	<gtExample>
	<return: #BlBoundsMatcher>
	| aMatcher |
	aMatcher := BlBoundsMatcher new
			constraints: BlBoundsMatcherConstraints new addChildStartEqualParentStart.

	aMatcher
		childStart: 20;
		parentStart: 30.
	self assert: aMatcher matches not.

	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamples >> childStartGreaterThanParentStartWhenEquals [
	<gtExample>
	<return: #BlBoundsMatcher>
	| aMatcher |
	aMatcher := BlBoundsMatcher new
			constraints: BlBoundsMatcherConstraints new addChildStartGreaterThanParentStart.

	aMatcher
		childStart: 30;
		parentStart: 30.
	self assert: aMatcher matches not.

	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamples >> childStartGreaterThanParentStartWhenGreater [
	<gtExample>
	<return: #BlBoundsMatcher>
	| aMatcher |
	aMatcher := BlBoundsMatcher new
			constraints: BlBoundsMatcherConstraints new addChildStartGreaterThanParentStart.

	aMatcher
		childStart: 40;
		parentStart: 30.
	self assert: aMatcher matches.

	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamples >> childStartGreaterThanParentStartWhenLess [
	<gtExample>
	<return: #BlBoundsMatcher>
	| aMatcher |
	aMatcher := BlBoundsMatcher new
			constraints: BlBoundsMatcherConstraints new addChildStartGreaterThanParentStart.

	aMatcher
		childStart: 20;
		parentStart: 30.
	self assert: aMatcher matches not.

	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamples >> childStartLessThanParentStartWhenEquals [
	<gtExample>
	<return: #BlBoundsMatcher>
	| aMatcher |
	aMatcher := BlBoundsMatcher new
			constraints: BlBoundsMatcherConstraints new addChildStartLessThanParentStart.

	aMatcher
		childStart: 30;
		parentStart: 30.
	self assert: aMatcher matches not.

	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamples >> childStartLessThanParentStartWhenGreater [
	<gtExample>
	<return: #BlBoundsMatcher>
	| aMatcher |
	aMatcher := BlBoundsMatcher new
			constraints: BlBoundsMatcherConstraints new addChildStartLessThanParentStart.

	aMatcher
		childStart: 40;
		parentStart: 30.
	self assert: aMatcher matches not.

	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamples >> childStartLessThanParentStartWhenLess [
	<gtExample>
	<return: #BlBoundsMatcher>
	| aMatcher |
	aMatcher := BlBoundsMatcher new
			constraints: BlBoundsMatcherConstraints new addChildStartLessThanParentStart.

	aMatcher
		childStart: 20;
		parentStart: 30.
	self assert: aMatcher matches.

	^ aMatcher
]

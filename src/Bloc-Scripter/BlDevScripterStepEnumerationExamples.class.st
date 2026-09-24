"
I exemplify the step tree enumeration of ${class:BlDevScripterStep}$: ${method:BlDevScripterStep>>#isLeaveStep}$, ${method:BlDevScripterStep>>#allStepsBreadthFirstDo:}$ and ${method:BlDevScripterStep>>#withAllStepsBreadthFirstDo:}$.

The enumeration mirrors ${method:BlElement>>#withAllChildrenBreadthFirstDo:}$, so that the steps of a scripter can be counted without collecting them first.
"
Class {
	#name : #BlDevScripterStepEnumerationExamples,
	#superclass : #Object,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #examples }
BlDevScripterStepEnumerationExamples >> allStepsBreadthFirst [
	<gtExample>
	<return: #OrderedCollection>
	| aRoot aBranch theSteps |
	aRoot := self stepTree.
	aBranch := aRoot steps first.
	theSteps := OrderedCollection new.
	aRoot allStepsBreadthFirstDo: [ :eachStep | theSteps add: eachStep ].
	self assert: theSteps size equals: 4.
	self assert: (theSteps includes: aRoot) not.
	self assert: (theSteps at: 1) == aBranch.
	self assert: (theSteps at: 2) == (aRoot steps at: 2).
	self assert: (theSteps at: 3) == (aBranch steps at: 1).
	self assert: (theSteps at: 4) == (aBranch steps at: 2).
	^ theSteps
]

{ #category : #examples }
BlDevScripterStepEnumerationExamples >> leaveStep [
	<gtExample>
	<return: #BlDevScripterStep>
	| aStep |
	aStep := BlDevScripterStep new.
	self assert: aStep steps isEmpty.
	self assert: aStep isLeaveStep.
	^ aStep
]

{ #category : #examples }
BlDevScripterStepEnumerationExamples >> leaveStepsCount [
	<gtExample>
	<return: #Number>
	| aRoot aCount |
	aRoot := self stepTree.
	aCount := 0.
	aRoot withAllStepsBreadthFirstDo: [ :eachStep |
		eachStep isLeaveStep ifTrue: [ aCount := aCount + 1 ] ].
	"The leave held by the root and the two leaves held by the branch."
	self assert: aCount equals: 3.
	^ aCount
]

{ #category : #examples }
BlDevScripterStepEnumerationExamples >> stepTree [
	"Build a step tree of five steps: a root holding a branch and a leave,
	the branch holding two more leaves."
	<gtExample>
	<return: #BlDevScripterCompositeStep>
	| aRoot aBranch |
	aRoot := BlDevScripterCompositeStep new.
	aBranch := BlDevScripterCompositeStep new.
	aRoot addStep: aBranch.
	aRoot addStep: BlDevScripterStep new.
	aBranch addStep: BlDevScripterStep new.
	aBranch addStep: BlDevScripterStep new.
	self assert: aRoot isLeaveStep not.
	self assert: aRoot steps size equals: 2.
	self assert: aBranch isLeaveStep not.
	self assert: aBranch steps size equals: 2.
	^ aRoot
]

{ #category : #examples }
BlDevScripterStepEnumerationExamples >> withAllStepsBreadthFirst [
	<gtExample>
	<return: #OrderedCollection>
	| aRoot aBranch theSteps |
	aRoot := self stepTree.
	aBranch := aRoot steps first.
	theSteps := OrderedCollection new.
	aRoot withAllStepsBreadthFirstDo: [ :eachStep | theSteps add: eachStep ].
	self assert: theSteps size equals: 5.
	self assert: (theSteps at: 1) == aRoot.
	self assert: (theSteps at: 2) == aBranch.
	self assert: (theSteps at: 3) == (aRoot steps at: 2).
	self assert: (theSteps at: 4) == (aBranch steps at: 1).
	self assert: (theSteps at: 5) == (aBranch steps at: 2).
	^ theSteps
]

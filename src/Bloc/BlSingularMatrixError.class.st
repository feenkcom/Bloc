"
I am signaled when matrix is singular and therefore can not be used for mathematical operations such as inverse

"
Class {
	#name : #BlSingularMatrixError,
	#superclass : #ArithmeticError,
	#instVars : [
		'targetMatrix'
	],
	#category : #'Bloc-Basic-Math'
}

{ #category : #accessing }
BlSingularMatrixError class >> signalForMatrix: aMatrix [
	^ (self new
			targetMatrix: aMatrix )
			signal: 'Matrix is singular and can not be inverted!'
]

{ #category : #'gt - extensions' }
BlSingularMatrixError >> gtMatrixFor: aView [ 
	<gtView>
	<gtExceptionDetailsPaneDebuggingView>
	
	self targetMatrix 
		ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Matrix';
		priority: 15;
		object: [ self targetMatrix ];
		view: #gtMatrixFor:
]

{ #category : #'gt - extensions' }
BlSingularMatrixError >> gtViewDecompositionFor: aView [ 
	<gtView>
	<gtExceptionDetailsPaneDebuggingView>
	
	self targetMatrix 
		ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Decomposition';
		priority: 20;
		object: [ self targetMatrix ];
		view: #gtViewDecompositionFor:
]

{ #category : #accessing }
BlSingularMatrixError >> targetMatrix [
	^ targetMatrix
]

{ #category : #accessing }
BlSingularMatrixError >> targetMatrix: aMatrix [
	targetMatrix := aMatrix
]

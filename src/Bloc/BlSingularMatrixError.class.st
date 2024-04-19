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

{ #category : #'gt - extensions' }
BlSingularMatrixError >> gtMatrixFor: aView [ 
	<gtView>
	
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

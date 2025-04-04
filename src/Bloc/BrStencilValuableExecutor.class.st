Class {
	#name : #BrStencilValuableExecutor,
	#superclass : #BrStencilExecutor,
	#instVars : [
		'valuable',
		'arguments'
	],
	#category : #'Bloc-Core-Stencil'
}

{ #category : #'instance creation' }
BrStencilValuableExecutor class >> from: aValuable [
	<return: #BrStencilValuableExecutor>

	^ self new valuable: aValuable
]

{ #category : #accessing }
BrStencilValuableExecutor >> arguments [
	<return: #Collection of: #Object>

	^ arguments
]

{ #category : #'api - running' }
BrStencilValuableExecutor >> execute [
	<return: #BlElement>

	^ self valuable gtValueWithArgs: self arguments
]

{ #category : #initialization }
BrStencilValuableExecutor >> initialize [
	super initialize.
	
	arguments := OrderedCollection new: 5
]

{ #category : #'api - arguments' }
BrStencilValuableExecutor >> push: anArgumentObject [
	arguments add: anArgumentObject
]

{ #category : #'api - arguments' }
BrStencilValuableExecutor >> resetArguments [
	arguments removeAll
]

{ #category : #printing }
BrStencilValuableExecutor >> storeOn: aStream [
	valuable isBlock
		ifTrue: [ aStream nextPutAll: valuable asString ]
		ifFalse: [ aStream nextPutAll: '[  ]' ]
]

{ #category : #accessing }
BrStencilValuableExecutor >> valuable [
	^ valuable
]

{ #category : #accessing }
BrStencilValuableExecutor >> valuable: anObject [
	valuable := anObject
]

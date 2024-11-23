Class {
	#name : #BrStencilDynamicExecutor,
	#superclass : #BrStencilExecutor,
	#instVars : [
		'valuable'
	],
	#category : #'Bloc-Core-Stencil'
}

{ #category : #running }
BrStencilDynamicExecutor >> execute: aCollectionOfArguments [
	self subclassResponsibility
]

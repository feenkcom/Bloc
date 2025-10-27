Class {
	#name : #BlDevScripterMouseMovePosition,
	#superclass : #Object,
	#instVars : [
		'step'
	],
	#category : #'Bloc-Scripter-Scripter-Utilities'
}

{ #category : #'private - accessing' }
BlDevScripterMouseMovePosition >> getMousePositionIn: aScripter [
	^ self step getMousePositionIn: aScripter
]

{ #category : #'private - accessing' }
BlDevScripterMouseMovePosition >> hasMousePositionIn: aScripter [
	^ self step hasMousePositionIn: aScripter
]

{ #category : #'api - positioning' }
BlDevScripterMouseMovePosition >> newPositionInScripter: aScripter [
	<return: #Point>
	^ self subclassResponsibility
]

{ #category : #'private - accessing' }
BlDevScripterMouseMovePosition >> setMousePosition: aNewPosition in: aScripter [
	self step setMousePosition: aNewPosition in: aScripter
]

{ #category : #accessing }
BlDevScripterMouseMovePosition >> step [
	^ step
]

{ #category : #accessing }
BlDevScripterMouseMovePosition >> step: anObject [
	step := anObject
]

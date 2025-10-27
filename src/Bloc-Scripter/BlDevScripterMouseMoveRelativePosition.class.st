Class {
	#name : #BlDevScripterMouseMoveRelativePosition,
	#superclass : #BlDevScripterMouseMovePosition,
	#instVars : [
		'delta'
	],
	#category : #'Bloc-Scripter-Scripter-Utilities'
}

{ #category : #accessing }
BlDevScripterMouseMoveRelativePosition >> delta [
	^ delta ifNil: [ 0 @ 0 ]
]

{ #category : #accessing }
BlDevScripterMouseMoveRelativePosition >> delta: aPoint [
	self assert: [ aPoint isKindOf: Point ].
	self assert: [ aPoint x isKindOf: Number ].
	self assert: [ aPoint y isKindOf: Number ].

	delta := aPoint
]

{ #category : #'api - positioning' }
BlDevScripterMouseMoveRelativePosition >> newPositionInScripter: aScripter [
	<return: #Point>
	| anOldPositon aNewPosition |
	anOldPositon := (self hasMousePositionIn: aScripter)
			ifTrue: [ self getMousePositionIn: aScripter ]
			ifFalse: [ self delta ].

	aNewPosition := (self hasMousePositionIn: aScripter)
			ifTrue: [ anOldPositon + self delta ]
			ifFalse: [ anOldPositon ].

	self setMousePosition: aNewPosition in: aScripter.

	^ aNewPosition
]

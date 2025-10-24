Class {
	#name : #BlDevScripterMouseMoveAbsolutePosition,
	#superclass : #BlDevScripterMouseMovePosition,
	#instVars : [
		'position'
	],
	#category : #'Bloc-Scripter-Scripter-Utilities'
}

{ #category : #'api - positioning' }
BlDevScripterMouseMoveAbsolutePosition >> newPositionInScripter: aScripter [
	<return: #Point>
	self setMousePosition: self position in: aScripter.

	^ self position
]

{ #category : #accessing }
BlDevScripterMouseMoveAbsolutePosition >> position [
	^ position ifNil: [ 0 @ 0 ]
]

{ #category : #accessing }
BlDevScripterMouseMoveAbsolutePosition >> position: aPoint [
	self assert: [ aPoint isKindOf: Point ].
	self assert: [ aPoint x isKindOf: Number ].
	self assert: [ aPoint y isKindOf: Number ].

	position := aPoint
]

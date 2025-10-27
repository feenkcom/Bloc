Class {
	#name : #BlDevScripterMouseMoveStep,
	#superclass : #BlDevScripterMouseStep,
	#instVars : [
		'position'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #'api - positioning' }
BlDevScripterMouseMoveStep >> by: aPoint [
	self position: (BlDevScripterMouseMoveRelativePosition new delta: aPoint)
]

{ #category : #accessing }
BlDevScripterMouseMoveStep >> defaultLabel [
	^ 'Mouse move'
]

{ #category : #'api - positioning' }
BlDevScripterMouseMoveStep >> delta: aPoint [
	self by: aPoint
]

{ #category : #actions }
BlDevScripterMouseMoveStep >> initialize [
	super initialize.

	self position: (BlDevScripterMouseMoveRelativePosition new delta: 0 @ 0)
]

{ #category : #actions }
BlDevScripterMouseMoveStep >> playOn: aScripter [
	| anOldPositon aNewPosition |
	
	anOldPositon := self getMousePositionIn: aScripter.
	aNewPosition := position newPositionInScripter: aScripter.
	
	self setMousePosition: aNewPosition in: aScripter.
	
	self modifiers
		ifNil: [ BlSpace simulateMouseMoveOn: aScripter element from: anOldPositon to: aNewPosition ]
		ifNotNil: [ :aModifiers |
			BlSpace simulateMouseMoveOn: aScripter element modifiers: aModifiers from: anOldPositon to: aNewPosition  ].
	aScripter pulse
]

{ #category : #'api - positioning' }
BlDevScripterMouseMoveStep >> position [
	<return: #BlDevScripterMouseMovePosition>
	^ position
]

{ #category : #'api - positioning' }
BlDevScripterMouseMoveStep >> position: aMouseMovePosition [
	aMouseMovePosition step: self.

	position := aMouseMovePosition
]

{ #category : #'api - positioning' }
BlDevScripterMouseMoveStep >> to: aPoint [
	self position: (BlDevScripterMouseMoveAbsolutePosition new position: aPoint)
]

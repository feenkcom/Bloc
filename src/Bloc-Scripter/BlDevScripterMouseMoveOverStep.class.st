Class {
	#name : #BlDevScripterMouseMoveOverStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'modifiers'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseMoveOverStep >> defaultLabel [
	^ 'Mouse move over'
]

{ #category : #initialization }
BlDevScripterMouseMoveOverStep >> initialize [
	super initialize.
	
	modifiers := BlKeyModifiers new
]

{ #category : #accessing }
BlDevScripterMouseMoveOverStep >> modifiers [
	^ modifiers
]

{ #category : #accessing }
BlDevScripterMouseMoveOverStep >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #actions }
BlDevScripterMouseMoveOverStep >> playOn: aScripter [
	| aTarget anOldPositon aNewPosition |
	
	aTarget := self target findTargetStartingInScripter: aScripter.
	
	anOldPositon := (self hasMousePositionIn: aScripter)
		ifTrue: [ self getMousePositionIn: aScripter ]
		ifFalse: [ 0@0 ].

	aNewPosition := aTarget bounds inSpace center.
	
	self setMousePosition: aNewPosition in: aScripter.
	
	self modifiers
		ifNil: [ 
			BlSpace simulateMouseMoveOn: aScripter element from: anOldPositon to: aNewPosition ]
		ifNotNil: [ :aModifiers |
			BlSpace simulateMouseMoveOn: aScripter element modifiers: aModifiers from: anOldPositon to: aNewPosition  ].
	aScripter pulse
]

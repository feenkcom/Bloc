Class {
	#name : #BlDevScripterTypeTextStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'text'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterTypeTextStep >> defaultLabel [
	^ self text 
		ifNotNil: [ :aString | 'Type: ', aString asString ]
		ifNil: [ self className ]
]

{ #category : #actions }
BlDevScripterTypeTextStep >> playOn: aScripter [
	| aText aTarget anInputEvent |
	aTarget := self target findTargetStartingInScripter: aScripter.

	aText := self text isString
			ifTrue: [ self text asString ]
			ifFalse: [ (self text cull: aTarget cull: aScripter) asString ].

	anInputEvent := BlTextInputEvent new text: aText.

	BlSpace simulateEvent: anInputEvent on: aTarget.

	aScripter pulse
]

{ #category : #accessing }
BlDevScripterTypeTextStep >> text [
	^ text
]

{ #category : #accessing }
BlDevScripterTypeTextStep >> text: aStringOrChar [
	self 
		assert: [ aStringOrChar isString or: [ aStringOrChar isCharacter ] ]
		description: [ 'Text must be a string or character' ].
	text := aStringOrChar asString
]

{ #category : #accessing }
BlDevScripterTypeTextStep >> valuable: aValuable [
	self
		assert: [ aValuable isNotNil ]
		description: [ 'Text valuable must be non-nil' ].
	text := aValuable
]

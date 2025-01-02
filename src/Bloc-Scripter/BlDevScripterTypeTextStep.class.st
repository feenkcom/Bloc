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
	"The event is eventually handled in {{gtMethod:BrTextEditorInsertionHandler>>#textInputEvent:}}. 
	Note that all characters must be printable, otherwise the event is ignored."

	| aText aTarget anInputEvent nonPrintableCharacters |
	aTarget := self target findTargetStartingInScripter: aScripter.

	aText := self text isString
			ifTrue: [ self text asString ]
			ifFalse: [ (self text cull: aTarget cull: aScripter) asString ].

	nonPrintableCharacters := aText reject: [ :aCharacter | 
		Unicode isPrintable: aCharacter ].
	self 
		assert: [ nonPrintableCharacters isEmpty ] 
		description: [ 'Some characters cannot be printed, therefore the type text event would be ignored: `{1}`. See BrTextEditorInsertionHandler>>#textInputEvent:.' format: { nonPrintableCharacters } ].

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

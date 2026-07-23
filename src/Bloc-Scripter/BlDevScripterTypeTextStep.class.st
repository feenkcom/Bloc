"
I simulate typing a string of text into the target element.

I send a {{gtClass:BlTextInputEvent}} with the specified text. The target element must have focus to receive the event. All characters in the text must be printable — non-printable characters will cause an assertion failure.

The text can be a string or a block that receives the target element and returns a string.

## Usage Examples

- {{gtClass:BlScripterTypeTextStepUsageExamples}} — canonical usage patterns
- {{gtClass:BrEditorWithScripterExamples}} — typing in editors with scrollbar

## Example

{{gtExample:BlScripterTypeTextStepUsageExamples>>#typeTextAndAssertContent|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlDevScripterTypeTextStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'text',
		'modifiers'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterTypeTextStep >> defaultLabel [
	^ self text 
		ifNotNil: [ :aString | 'Type: ', aString asString ]
		ifNil: [ self className ]
]

{ #category : #accessing }
BlDevScripterTypeTextStep >> modifiers [
	^ modifiers
]

{ #category : #accessing }
BlDevScripterTypeTextStep >> modifiers: anObject [
	modifiers := anObject
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
	modifiers ifNotNil: [ :keyModifiers | anInputEvent modifiers: keyModifiers ].

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

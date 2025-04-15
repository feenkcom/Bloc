"
I fire a {{gtClass:BlMouseDownEvent}}, {{gtClass:BlMouseUpEvent}}, and {{gtClass:BlClickEvent}}.

## Example

Here you can see how to configure a fire and check a click event on a child element:
{{gtExample:BlScripterExamples>>#clickCheck|previewExpanded=true|previewHeight=400}}


"
Class {
	#name : #BlDevScripterClickStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'modifiers'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterClickStep >> defaultLabel [
	^ 'Click'
]

{ #category : #accessing }
BlDevScripterClickStep >> initialize [
	super initialize.
	
	modifiers := BlKeyModifiers new
]

{ #category : #accessing }
BlDevScripterClickStep >> modifiers [
	^ modifiers
]

{ #category : #accessing }
BlDevScripterClickStep >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #actions }
BlDevScripterClickStep >> playOn: aScripter [
	"By disabling and later enabling double click we prevent
	unwanted double-click generation when scripting UI"
	aScripter space mouseProcessor disableDoubleClick.

	[ self
		setMousePosition: (BlSpace
				simulateClickOn: (self target findTargetStartingInScripter: aScripter)
				modifiers: modifiers)
		in: aScripter ] ensure: [ aScripter space mouseProcessor enableDoubleClick ].

	aScripter pulse
]

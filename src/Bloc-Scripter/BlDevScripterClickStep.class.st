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
		'modifiers',
		'assertTargetVisibility'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #actions }
BlDevScripterClickStep >> assertTarget: aTarget [
	"Ensure that a given target can be clicked, e.g., is not hidden."

	assertTargetVisibility ifFalse: [ ^ self ].


	self
		assert: (aTarget isKindOf: BlElement)
		description: [ 'Target must be an element: {1}' format: {aTarget} ].

	self
		assert: aTarget visibility isVisible
		description: [ 'Target must be visible: {1}' format: {aTarget} ].

	self
		assert: aTarget visibility shouldDraw
		description: [ 'Target should draw: {1}' format: {aTarget} ].

	aTarget
		allParentsDo: [ :eachParent | 
			self
				assert: eachParent visibility isVisible
				description: [ 'Target parent must be visible: {1} ... {2}'
						format: {eachParent.
								aTarget} ].

			self
				assert: eachParent visibility shouldDraw
				description: [ 'Target parent should draw: {1} ... {2}'
						format: {eachParent.
								aTarget} ] ]
]

{ #category : #accessing }
BlDevScripterClickStep >> defaultLabel [
	^ 'Click'
]

{ #category : #'api - initialization' }
BlDevScripterClickStep >> ignoreTargetVisibility [
	"For use cases that requires clicking on a hidden target."

	assertTargetVisibility := false
]

{ #category : #initialization }
BlDevScripterClickStep >> initialize [
	super initialize.
	
	modifiers := BlKeyModifiers new.
	assertTargetVisibility := true.
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

	| aTarget |
	aTarget := self target findTargetStartingInScripter: aScripter.
	self assertTarget: aTarget.
	
	aScripter space mouseProcessor disableDoubleClick.
	[ self
		setMousePosition: (BlSpace simulateClickOn: aTarget modifiers: modifiers)
		in: aScripter ] ensure: [ aScripter space mouseProcessor enableDoubleClick ].
	aScripter pulse
]

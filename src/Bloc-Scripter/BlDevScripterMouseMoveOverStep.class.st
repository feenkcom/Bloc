"
I move the mouse cursor over the target element, triggering mouse enter/move events.

I simulate the full mouse movement sequence from the previous position to the target center, triggering {{gtClass:BlMouseMoveEvent}}, {{gtClass:BlMouseEnterEvent}}, and {{gtClass:BlMouseOverEvent}} as appropriate.

## Usage Examples

- {{gtClass:BlScripterMouseStepUsageExamples}} — canonical usage patterns (mouseMoveOver)
- {{gtClass:GtSpotterByScripterExamples}} — hovering over spotter categories before clicking

## Example

{{gtExample:BlScripterMouseStepUsageExamples>>#mouseMoveOver|previewExpanded=true|previewHeight=300}}
"
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

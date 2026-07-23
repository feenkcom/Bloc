"
I fire a secondary click (right-click) on the target element.

This is typically used to trigger context menus. I simulate a {{gtClass:BlMouseDownEvent}}, {{gtClass:BlMouseUpEvent}}, and a click event with the secondary button.

## Usage Examples

- {{gtClass:BlScripterSecondaryClickStepUsageExamples}} — canonical usage patterns
- {{gtClass:BlMouseProcessorExamples}} — secondary mouse button processor tests

## Example

{{gtExample:BlScripterSecondaryClickStepUsageExamples>>#secondaryClickOnButton|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlDevScripterSecondaryClickStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'localPosition'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterSecondaryClickStep >> defaultLabel [
	^ 'Secondary Click'
]

{ #category : #accessing }
BlDevScripterSecondaryClickStep >> localPosition [
	^ localPosition
]

{ #category : #accessing }
BlDevScripterSecondaryClickStep >> localPosition: aPoint [
	localPosition := aPoint
]

{ #category : #actions }
BlDevScripterSecondaryClickStep >> playOn: aScripter [
	self localPosition
		ifNil: [ self
				setMousePosition: (BlSpace
						simulateSecondaryClickOn: (self target findTargetStartingInScripter: aScripter))
				in: aScripter ]
		ifNotNil: [ :aPosition | 
			self
				setMousePosition: (BlSpace
						simulateSecondaryClickOn: (self target findTargetStartingInScripter: aScripter)
						atLocalPosition: aPosition)
				in: aScripter ].

	aScripter pulse
]

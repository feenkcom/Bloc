"
I simulate a mouse button release at a position on the scripter element.

I call {{gtMethod:BlSpace class>>#simulateMouseUpOn:at:}} to fire a {{gtClass:BlMouseUpEvent}}. Use me as the second half of a manual click sequence.

## Usage Examples

- {{gtClass:BlScripterMouseStepUsageExamples}} — canonical mouseDown/mouseUp pattern
- {{gtClass:BlMouseProcessorExamples}} — low-level mouse processor tests

## Example

{{gtExample:BlScripterMouseStepUsageExamples>>#mouseDownAndUp|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlDevScripterMouseUpStep,
	#superclass : #BlDevScripterMouseStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseUpStep >> defaultLabel [
	^ 'Mouse up'
]

{ #category : #actions }
BlDevScripterMouseUpStep >> playOn: aScripter [
	self modifiers
		ifNil: [ BlSpace simulateMouseUpOn: aScripter element at: (self getMousePositionIn: aScripter) ]
		ifNotNil: [ :aModifiers |
			 BlSpace simulateMouseUpOn: aScripter element modifiers: aModifiers at: (self getMousePositionIn: aScripter)  ].
	aScripter pulse
]

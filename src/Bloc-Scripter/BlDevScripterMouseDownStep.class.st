"
I simulate a mouse button press at a position on the scripter element.

I call {{gtMethod:BlSpace class>>#simulateMouseDownOn:at:}} to fire a {{gtClass:BlMouseDownEvent}}. Use me as the first half of a manual click sequence when you need control over timing between press and release.

## Usage Examples

- {{gtClass:BlScripterMouseStepUsageExamples}} — canonical mouseDown/mouseUp pattern
- {{gtClass:BlMouseProcessorExamples}} — low-level mouse processor tests

## Example

{{gtExample:BlScripterMouseStepUsageExamples>>#mouseDownAndUp|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlDevScripterMouseDownStep,
	#superclass : #BlDevScripterMouseStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseDownStep >> defaultLabel [
	^ 'Mouse down'
]

{ #category : #actions }
BlDevScripterMouseDownStep >> playOn: aScripter [
	self modifiers 
		ifNil: [ 
			BlSpace simulateMouseDownOn: aScripter element at: (self getMousePositionIn: aScripter) ]
		ifNotNil: [ :aModifiers | 
			BlSpace simulateMouseDownOn: aScripter element modifiers: aModifiers at: (self getMousePositionIn: aScripter) ].
	aScripter pulse
]

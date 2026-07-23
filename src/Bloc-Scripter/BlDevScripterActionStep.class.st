"
I execute an arbitrary block during scripter playback.

Access me via {{gtMethod:TBlDevScripterActionStep>>#do|label=#selector}} or the auto-playing {{gtMethod:TBlDevScripterActionStep>>#doStep:|label=#selector}}. My block (set via {{gtMethod:BlDevScripterActionStep>>#block:}}) receives up to three arguments: the targeted element, the scripter user data, and the scripter itself.

Use me for custom side effects or logic that doesn't fit other step types — e.g., mutating elements, storing values, or performing assertions inline.

## Usage Examples

- {{gtClass:BlScripterActionStepUsageExamples}} — canonical usage patterns

## Example

{{gtExample:BlScripterActionStepUsageExamples>>#doStepModifiesElement|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlDevScripterActionStep,
	#superclass : #BlDevScripterTargetedStep,
	#instVars : [
		'block'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterActionStep >> action: anOneArgBlock [
	self block: anOneArgBlock
]

{ #category : #asserting }
BlDevScripterActionStep >> assertBlock: anOneArgBlock [
	self 
		assert: [ anOneArgBlock isNotNil ] 
		description: [ 'Block must be non-nil' ].
	self 
		assert: [ anOneArgBlock numArgs < 4 ] 
		description: [ 'Block must receive less then 4 arguments' ].
]

{ #category : #accessing }
BlDevScripterActionStep >> block [
	^ block
]

{ #category : #accessing }
BlDevScripterActionStep >> block: anOneArgBlock [
	self assertBlock: anOneArgBlock.
	block := anOneArgBlock
]

{ #category : #accessing }
BlDevScripterActionStep >> defaultLabel [
	^ 'Action'
]

{ #category : #accessing }
BlDevScripterActionStep >> element: anElement [
	"Set a scripter main element (child of Scripter space root element)."

	self block: [ :aScripter | aScripter setElement: anElement asStencil asElement ].
	self onScripter
]

{ #category : #actions }
BlDevScripterActionStep >> playOn: aScripter [
	| aTarget |
	self assertBlock: self block.
	aTarget := self target findTargetStartingInScripter: aScripter.
	self block cull: aTarget cull: aScripter userData cull: aScripter.
]

{ #category : #accessing }
BlDevScripterActionStep >> pulse [
	self label: 'Pulse space'.
	self onSpace.
	self block: [ :aSpace | aSpace pulse ].
]

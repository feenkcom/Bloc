"
I demonstrate how to use {{gtClass:BlDevScripterActionStep}} to execute custom blocks during a scripter script.

An action step (accessed via {{gtMethod:TBlDevScripterActionStep>>#do|label=#selector}} or {{gtMethod:TBlDevScripterActionStep>>#doStep:|label=#selector}}) runs an arbitrary block with the targeted element as argument. Use it for side effects or custom logic that doesn't fit other step types.

The block receives up to three arguments: the target element, the scripter user data, and the scripter itself.

## Examples

{{gtExample:BlScripterActionStepUsageExamples>>#doStepModifiesElement|previewExpanded=true|previewHeight=300}}
{{gtExample:BlScripterActionStepUsageExamples>>#doStepAccessesUserData|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlScripterActionStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #examples }
BlScripterActionStepUsageExamples >> doStepAccessesUserData [
	"Demonstrates using doStep: with user data access.
	The block receives the element and scripter user data as arguments."
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: (BrFrame new
		matchParent;
		addChild: (BlElement new
			id: #target;
			size: 100 @ 100;
			background: Color blue)).
	aScripter doStep: [ :s |
		s
			label: 'Store element size in user data';
			block: [ :el :userData | userData at: #size put: el size ];
			id: #target ].
	aScripter doStep: [ :s |
		s
			label: 'Assert user data has stored size';
			block: [ :el |
				self assert: (aScripter userData at: #size) equals: (100 @ 100) ] ].
	^ aScripter
]

{ #category : #examples }
BlScripterActionStepUsageExamples >> doStepModifiesElement [
	"Demonstrates using doStep: to execute a custom block on a targeted element.
	The block modifies the element's background, then an assertion verifies the change."
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: (BrFrame new
		matchParent;
		addChild: (BlElement new
			id: #target;
			size: 100 @ 100;
			background: Color blue)).
	aScripter doStep: [ :s |
		s
			label: 'Change background to red';
			block: [ :el | el background: Color red ];
			id: #target ].
	aScripter assertStep: [ :s |
		s
			label: 'Assert background is red';
			value: [ :el | el background paint color ] equals: [ Color red ];
			id: #target ].
	^ aScripter
]

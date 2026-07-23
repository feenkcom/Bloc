"
I demonstrate how to use {{gtClass:BlDevScripterWaitStep}} to wait for asynchronous operations.

A wait step pauses scripter execution until a condition is met: empty task queue, semaphore signal, or custom condition. Use it after actions that trigger async work (animations, deferred layout, background tasks) before asserting results.

In normal scripter examples this step should not be needed as when executig a step scripter waits for all tasks to be executed before proceeding to the next step. Could be needed in specific situation where scripter does not know to wait fpr background tasks.

## Example

{{gtExample:BlScripterWaitStepUsageExamples>>#waitForEmptyTaskQueue|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlScripterWaitStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #examples }
BlScripterWaitStepUsageExamples >> waitForEmptyTaskQueue [
	"Demonstrates waiting for the space's task queue to be empty.
	Useful when an action triggers async tasks (animations, deferred layout)."
	<gtExample>
	| aScripter |
	aScripter := self scripterWithButton.
	aScripter substep: 'Click and wait for tasks'
		do: 
			[:aStep |
			(aStep click)
				label: 'Click button';
				id: #testButton;
				play.
			(aStep wait)
				label: 'Wait for async tasks';
				forEmptySpaceTaskQueueTimeout: 2 seconds;
				play].
	^aScripter
]

{ #category : #examples }
BlScripterWaitStepUsageExamples >> waitForEnqueuedTask [
	"Demonstrates waiting for a specific enqueued space task to complete.
	Useful when you know a task was enqueued and need it finished before proceeding."
	<gtExample>
	| aScripter |
	aScripter := self scripterWithButton.
	aScripter substep: 'Wait for enqueued task'
		do: [ :aStep |
			aStep wait
				label: 'Wait for enqueued space task';
				forEnqueuedSpaceTaskTimeout: 3 seconds;
				play ].
	^ aScripter
]

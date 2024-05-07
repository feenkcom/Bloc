Class {
	#name : #BlDevScripterStepSignal,
	#superclass : #BlDevScripterSignal,
	#instVars : [
		'step',
		'activeTasks',
		'pendingTasks'
	],
	#category : #'Bloc-Scripter-Signals'
}

{ #category : #'gt - extensions' }
BlDevScripterStepSignal >> gtStepsMondrianTreeFor: aView [
	<gtView>
	self step ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Step';
		priority: 5;
		object: [ self step ];
		view: #gtReferenceFor:
]

{ #category : #initialization }
BlDevScripterStepSignal >> prepareForDelivery [
	super prepareForDelivery.

	activeTasks := scripter space taskQueue tasks.
	pendingTasks := scripter space taskQueue pendingTasks
]

{ #category : #printing }
BlDevScripterStepSignal >> printOneLineContentsOn: aStream [
	super printOneLineContentsOn: aStream.
	self step gtDisplayOn: aStream
]

{ #category : #accessing }
BlDevScripterStepSignal >> step [
	^ step
]

{ #category : #accessing }
BlDevScripterStepSignal >> step: anObject [
	step := anObject
]

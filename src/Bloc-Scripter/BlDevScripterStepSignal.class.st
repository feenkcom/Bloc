Class {
	#name : #BlDevScripterStepSignal,
	#superclass : #BlDevScripterSignal,
	#instVars : [
		'step'
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

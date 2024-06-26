Class {
	#name : #BlTaskAction,
	#superclass : #BlTask,
	#instVars : [
		'action'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #factory }
BlTaskAction class >> enqueueElement: anElement action: anActionBlock [
	| aTask |
	aTask := self new action: anActionBlock.
	anElement enqueueTask: aTask.
	^ aTask
]

{ #category : #accessing }
BlTaskAction >> action [
	^ action
]

{ #category : #accessing }
BlTaskAction >> action: aBlock [
	action := aBlock
]

{ #category : #'gt - extensions' }
BlTaskAction >> gtSourceCodeFor: aView [
	<gtView>
	
	action ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Source code';
		object: [ action ];
		view: #gtSourceCodeFor:  
]

{ #category : #initialization }
BlTaskAction >> initialize [
	super initialize.
	
	action := [ :optionalThisTask | ]
]

{ #category : #printing }
BlTaskAction >> printOn: aStream [
	aStream
		print: self class name;
		space;
		nextPut: $(;
		print: self action;
		nextPut: $)
]

{ #category : #running }
BlTaskAction >> run: aWaker [
	self action isClosure
		ifTrue: [ self action cull: self ]
		ifFalse: [ self action value ]
]

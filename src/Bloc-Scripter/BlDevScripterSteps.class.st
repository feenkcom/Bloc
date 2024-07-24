"
I ideally replace {{gtClass:BlDevScripterMultipleActionStep}} usage that is used in {{gtMethod:TBlDevScripterActionStep>>#substeps}}. 
"
Class {
	#name : #BlDevScripterSteps,
	#superclass : #BlDevScripterToolActionStep,
	#instVars : [
		'before',
		'ensure'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterSteps >> before [
	^ before ifNil: [ before := self defaultBefore ]
]

{ #category : #accessing }
BlDevScripterSteps >> before: anObject [
	before := anObject
]

{ #category : #initialization }
BlDevScripterSteps >> defaultBefore [
	^ [ :anElement :aUserData :aScripter | "do nothing" ]
]

{ #category : #initialization }
BlDevScripterSteps >> defaultEnsure [
	^ [ :aBeforeResult :anElement :aUserData :aScripter | "do nothing" ]
]

{ #category : #accessing }
BlDevScripterSteps >> ensure [
	^ ensure ifNil: [ ensure := self defaultEnsure ]
]

{ #category : #accessing }
BlDevScripterSteps >> ensure: anObject [
	ensure := anObject
]

{ #category : #actions }
BlDevScripterSteps >> playOnExecutor: anExecutor [
	| aTarget aBeforeResult |
	aTarget := self target findTargetStartingInScripter: anExecutor scripter.
	aBeforeResult := self before 
			cull: aTarget
			cull: anExecutor scripter userData
			cull: anExecutor scripter.
	
	[
		super playOnExecutor: anExecutor.
	] ensure: [
		self ensure 
			cull: aBeforeResult 
			cull: aTarget 
			cull: anExecutor scripter userData 
			cull: anExecutor scripter ]
]

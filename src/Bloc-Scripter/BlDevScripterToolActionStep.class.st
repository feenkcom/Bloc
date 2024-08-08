Class {
	#name : #BlDevScripterToolActionStep,
	#superclass : #BlDevScripterMultipleActionStep,
	#instVars : [
		'target'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #'steps - checks' }
BlDevScripterToolActionStep >> assertHasFocus [
	^ self assert
		hasFocus;
		onParentStepTarget: self;
		referenceSender
]

{ #category : #'steps - checks' }
BlDevScripterToolActionStep >> click [
	^ super click
		onParentStepTarget: self;
		referenceSender
]

{ #category : #initialization }
BlDevScripterToolActionStep >> defaultTarget [
	^ BlDevScripterSelfEventTarget new
]

{ #category : #testing }
BlDevScripterToolActionStep >> isStepWithTarget [
	^ true
]

{ #category : #accessing }
BlDevScripterToolActionStep >> label: anObject [
	label := anObject
]

{ #category : #accessing }
BlDevScripterToolActionStep >> realTarget [
	^ self target
]

{ #category : #accessing }
BlDevScripterToolActionStep >> target [
	^ target ifNil: [ target := self defaultTarget ]
]

{ #category : #accessing }
BlDevScripterToolActionStep >> target: anObject [
	target := anObject
]

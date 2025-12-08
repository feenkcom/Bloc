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

{ #category : #'steps - interactions' }
BlDevScripterToolActionStep >> click [
	^ super click onParentStepTarget: self
]

{ #category : #initialization }
BlDevScripterToolActionStep >> defaultTarget [
	^ BlDevScripterSelfEventTarget new
]

{ #category : #'steps - interactions' }
BlDevScripterToolActionStep >> do [
	^ super do onParentStepTarget: self
]

{ #category : #testing }
BlDevScripterToolActionStep >> isStepWithTarget [
	^ true
]

{ #category : #accessing }
BlDevScripterToolActionStep >> label: anObject [
	label := anObject
]

{ #category : #'steps - checks' }
BlDevScripterToolActionStep >> mouseMoveOver [
	^ super mouseMoveOver
		onParentStepTarget: self;
		referenceSender
]

{ #category : #'steps - interactions' }
BlDevScripterToolActionStep >> pressEscape [
	^ self shortcut
		combination: BlKeyCombination escape
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

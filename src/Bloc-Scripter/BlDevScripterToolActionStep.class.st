"
I am the abstract superclass for domain-specific tool steps.

My subclasses provide fluent DSLs for testing specific GT tools (coder, inspector, pager, etc.). I combine action creation (via {{gtClass:TBlDevScripterActionStep}}) and assertion creation (via {{gtClass:TBlDevScripterCheckStepCreation}}) into composite steps that group multiple operations under a single label.

I hold a `target` for element targeting and inherit the composite step infrastructure from {{gtClass:BlDevScripterMultipleActionStep}}.

## How to Create a New Tool Step

1. Subclass me in your tool's package
2. Add domain-specific assertion and action methods
3. Add a factory method on {{gtClass:BlScripter}} that creates and returns an instance
"
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

{ #category : #'steps - interactions' }
BlDevScripterToolActionStep >> requestFocus [
	^ super requestFocus onParentStepTarget: self
]

{ #category : #accessing }
BlDevScripterToolActionStep >> target [
	^ target ifNil: [ target := self defaultTarget ]
]

{ #category : #accessing }
BlDevScripterToolActionStep >> target: anObject [
	target := anObject
]

Class {
	#name : #BlDevScripterCheckStep,
	#superclass : #BlDevScripterTargetedStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterCheckStep >> defaultLabel [
	^ 'Check'
]

{ #category : #initialization }
BlDevScripterCheckStep >> initialize [
	super initialize.
	
	self onSelf
]

{ #category : #actions }
BlDevScripterCheckStep >> playOn: aScripter [
	| anElement |
	anElement := self target findTargetStartingInScripter: aScripter.
	self validateOn: anElement
]

{ #category : #asserting }
BlDevScripterCheckStep >> shouldPulse [
	^ false
]

{ #category : #accessing }
BlDevScripterCheckStep >> stepIcon [
	<return: #BlElement or: nil>
	^ BrGlamorousVectorIcons accept
]

{ #category : #actions }
BlDevScripterCheckStep >> validateOn: anElement [
	"validate targeted element"
]

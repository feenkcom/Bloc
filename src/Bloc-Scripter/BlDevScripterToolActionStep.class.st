Class {
	#name : #BlDevScripterToolActionStep,
	#superclass : #BlDevScripterMultipleActionStep,
	#instVars : [
		'target'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #testing }
BlDevScripterToolActionStep >> isStepWithTarget [
	^ true
]

{ #category : #accessing }
BlDevScripterToolActionStep >> realTarget [
	^ self target
]

{ #category : #accessing }
BlDevScripterToolActionStep >> target [
	^ target
]

{ #category : #accessing }
BlDevScripterToolActionStep >> target: anObject [
	target := anObject
]

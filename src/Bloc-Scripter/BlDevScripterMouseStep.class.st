Class {
	#name : #BlDevScripterMouseStep,
	#superclass : #BlDevScripterStep,
	#instVars : [
		'modifiers'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseStep >> initialize [
	super initialize.
	
	modifiers := BlKeyModifiers new
]

{ #category : #accessing }
BlDevScripterMouseStep >> modifiers [
	^ modifiers
]

{ #category : #accessing }
BlDevScripterMouseStep >> modifiers: anObject [
	modifiers := anObject
]

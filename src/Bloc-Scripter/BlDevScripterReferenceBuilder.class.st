Class {
	#name : #BlDevScripterReferenceBuilder,
	#superclass : #Object,
	#instVars : [
		'context',
		'reference',
		'compiledMethod'
	],
	#category : #'Bloc-Scripter-Scripter-Properties'
}

{ #category : #building }
BlDevScripterReferenceBuilder >> build [
	compiledMethod := context blocDefiningMethod.
	compiledMethod isDoIt
		ifTrue: [ self buildDoItReference ]
		ifFalse: [ self buildEditableReference ].
	^ reference
]

{ #category : #private }
BlDevScripterReferenceBuilder >> buildDoItReference [
	reference := BlDevScripterDoItReference new
			compiledMethod: compiledMethod;
			interval: self interval
]

{ #category : #private }
BlDevScripterReferenceBuilder >> buildEditableReference [
	| aDefinition anInterval |
	aDefinition := compiledMethod asRingDefinition.
	anInterval := self interval.
	reference := BlDevScripterReference method: aDefinition interval: anInterval
]

{ #category : #accessing }
BlDevScripterReferenceBuilder >> context [
	<return: #Context>
	^ context
]

{ #category : #accessing }
BlDevScripterReferenceBuilder >> context: anObject [
	context := anObject
]

{ #category : #private }
BlDevScripterReferenceBuilder >> interval [
	^ context pcRangeContextIsActive: false
]

{ #category : #accessing }
BlDevScripterReferenceBuilder >> reference [
	<return: #BlDevScripterReference>
	^ reference
]

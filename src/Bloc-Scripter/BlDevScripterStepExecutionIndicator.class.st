Class {
	#name : #BlDevScripterStepExecutionIndicator,
	#superclass : #DynamicVariable,
	#category : #'Bloc-Scripter-Scripter-Executors'
}

{ #category : #testing }
BlDevScripterStepExecutionIndicator class >> ifScripter: aScripterBlock ifNone: aNoneBlock [
	^ self soleInstance ifScripter: aScripterBlock ifNone: aNoneBlock
]

{ #category : #testing }
BlDevScripterStepExecutionIndicator >> ifScripter: aScripterBlock ifNone: aNoneBlock [
	| aValue |
	aValue := self value.
	^ (aValue isKindOf: BlScripter)
		ifTrue: [ aScripterBlock cull: aValue ]
		ifFalse: aNoneBlock
]

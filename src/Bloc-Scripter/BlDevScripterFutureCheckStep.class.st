Class {
	#name : #BlDevScripterFutureCheckStep,
	#superclass : #BlDevScripterCheckStep,
	#traits : 'TBlDevScripterCheckStep + TBlDevScripterCheckStepCreation + TBlDevScripterCompositeStepTarget',
	#classTraits : 'TBlDevScripterCheckStep classTrait + TBlDevScripterCheckStepCreation classTrait + TBlDevScripterCompositeStepTarget classTrait',
	#instVars : [
		'parent',
		'hasCustomTarget',
		'realStep'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #adding }
BlDevScripterFutureCheckStep >> addStep: aScripterTask [
	<return: #BlDevScripterStep>
	self hasCustomLabel ifTrue: [ aScripterTask label: self label ].
	self hasCustomTarget ifTrue: [ aScripterTask target: self target ].
	self realStep: aScripterTask.
	^ self parent addStep: aScripterTask.
]

{ #category : #accessing }
BlDevScripterFutureCheckStep >> hasCustomTarget [
	<return: #Boolean>
	^ hasCustomTarget
]

{ #category : #'targets - accessing and updating' }
BlDevScripterFutureCheckStep >> hasRealStep [
	<return: #Boolean>
	^ realStep isNotNil
]

{ #category : #initialization }
BlDevScripterFutureCheckStep >> initialize [
	super initialize.
	hasCustomTarget := false.
]

{ #category : #accessing }
BlDevScripterFutureCheckStep >> label: anObject [
	self hasRealStep
		ifFalse: [ super label: anObject ]
		ifTrue: [ self realStep label: anObject ]
]

{ #category : #accessing }
BlDevScripterFutureCheckStep >> parent [
	^ parent
]

{ #category : #accessing }
BlDevScripterFutureCheckStep >> parent: anObject [
	parent := anObject.
	self scripter: anObject scripter
]

{ #category : #actions }
BlDevScripterFutureCheckStep >> playOn: aScripter [
	self hasRealStep
		ifTrue: [ self realStep playOn: aScripter ]
		ifFalse: [ super playOn: aScripter ]
]

{ #category : #'targets - accessing and updating' }
BlDevScripterFutureCheckStep >> previousTarget [
	<return: #BlScripterElementTarget>
	^ self parent previousTarget
]

{ #category : #accessing }
BlDevScripterFutureCheckStep >> realStep [
	<return: #BlDevScripterStep>
	^ realStep
]

{ #category : #accessing }
BlDevScripterFutureCheckStep >> realStep: aScripterTask [
	realStep := aScripterTask
]

{ #category : #accessing }
BlDevScripterFutureCheckStep >> state: aState [
	super state: aState.
	self hasRealStep ifTrue: [ self realStep state: aState ]
]

{ #category : #'targets - accessing and updating' }
BlDevScripterFutureCheckStep >> target: aScripterEventTarget [
	self hasRealStep
		ifFalse: [ 
			super target: aScripterEventTarget.
			hasCustomTarget := true ]
		ifTrue: [ 
			self realStep target: aScripterEventTarget ]
]

{ #category : #'targets - accessing and updating' }
BlDevScripterFutureCheckStep >> updateTarget: aScripterEventTarget [
	self hasRealStep 
		ifFalse: [ super updateTarget: aScripterEventTarget ]
		ifTrue: [ self realStep updateTarget: aScripterEventTarget ]
]

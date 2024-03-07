Class {
	#name : #BlDevScripterParentStepTarget,
	#superclass : #BlDevScripterTarget,
	#instVars : [
		'parentStep'
	],
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #searching }
BlDevScripterParentStepTarget >> findTargetIn: anElement [
	^ parentStep isStepWithTarget
		ifFalse: [ anElement ]
		ifTrue: [ parentStep target findTargetIn: anElement ]
]

{ #category : #searching }
BlDevScripterParentStepTarget >> findTargetStartingInScripter: aScripter [
	^ parentStep isStepWithTarget
		ifFalse: [ aScripter element ]
		ifTrue: [ parentStep target findTargetStartingInScripter: aScripter ]
]

{ #category : #accessing }
BlDevScripterParentStepTarget >> identifier [
	^ 'Inherited'
]

{ #category : #accessing }
BlDevScripterParentStepTarget >> parentStep [
	^ parentStep
]

{ #category : #accessing }
BlDevScripterParentStepTarget >> parentStep: anObject [
	parentStep := anObject
]

{ #category : #printing }
BlDevScripterParentStepTarget >> printOn: aStream [
	self parentStep ifNil: [ ^ super printOn: aStream ].
	aStream nextPutAll: 'Inherited'
]

{ #category : #updating }
BlDevScripterParentStepTarget >> updateUsing: aScripterEventTarget on: aStep [
	| aNestedTarget |
	aNestedTarget := BlDevScripterNestedChildEventTarget new.
	aNestedTarget targets: { self. aScripterEventTarget }.
	aStep target: aNestedTarget.
]

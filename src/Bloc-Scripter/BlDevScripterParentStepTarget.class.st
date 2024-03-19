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
		ifTrue: [ parentStep target
				ifNotNil: [ :aTarget | aTarget findTargetIn: anElement ]
				ifNil: [ anElement ] ]
]

{ #category : #searching }
BlDevScripterParentStepTarget >> findTargetStartingInScripter: aScripter [
	^ parentStep isStepWithTarget
		ifFalse: [ aScripter element ]
		ifTrue: [ parentStep target
				ifNotNil: [ :aTarget | aTarget findTargetStartingInScripter: aScripter ]
				ifNil: [ aScripter element ] ]
]

{ #category : #accessing }
BlDevScripterParentStepTarget >> identifier [
	^ 'inherited'
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
	aStream nextPutAll: 'inherited'
]

{ #category : #updating }
BlDevScripterParentStepTarget >> updateUsing: aScripterEventTarget on: aStep [
	| aNestedTarget |
	aNestedTarget := BlDevScripterNestedChildEventTarget new.
	aNestedTarget targets: { self. aScripterEventTarget }.
	aStep target: aNestedTarget.
]

Class {
	#name : #BlDevScripterNestedChildEventTarget,
	#superclass : #BlScripterElementTarget,
	#instVars : [
		'targets'
	],
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #initialization }
BlDevScripterNestedChildEventTarget >> addTarget: aScripterEventTarget [
	| theNewTargets |
	self 
		assert: [ aScripterEventTarget isNotNil ] 
		description: [ 'Scripter event target must be non-nil' ].
	theNewTargets := self targets copyWith: aScripterEventTarget.
	self targets: theNewTargets
]

{ #category : #searching }
BlDevScripterNestedChildEventTarget >> findTargetIn: anElement [
	<return: #BlElement>
	| aChild |
	
	aChild := anElement.
	self targets do: [ :eachTarget | 
		aChild := eachTarget findTargetIn: aChild ].
	^ aChild
]

{ #category : #'gt-extension' }
BlDevScripterNestedChildEventTarget >> gtTargetsFor: aView [
	<gtView>
	self targets ifNil: [ ^ aView empty ].
	^ (self targets gtItemsFor: aView)
		title: 'Targets'
]

{ #category : #initialization }
BlDevScripterNestedChildEventTarget >> initialize [
	super initialize.
	targets := #().
]

{ #category : #copying }
BlDevScripterNestedChildEventTarget >> postCopy [
	self targets: self targets copy
]

{ #category : #printing }
BlDevScripterNestedChildEventTarget >> printOn: aStream [
	self targets ifNil: [ ^ super printOn: aStream ].
	aStream nextPutAll: 'Child: { '.
	self targets 
		do: [ :eachTarget | aStream nextPutAll: eachTarget identifier asString ] 
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ' }'
]

{ #category : #accessing }
BlDevScripterNestedChildEventTarget >> targetSequence: anArray [
	self targets: (anArray 
			collect: [ :eachTarget | BlScripterElementTarget targetInstanceFor: eachTarget ]
			as: Array)
]

{ #category : #accessing }
BlDevScripterNestedChildEventTarget >> targets [
	^ targets
]

{ #category : #accessing }
BlDevScripterNestedChildEventTarget >> targets: anObject [
	targets := anObject
]

{ #category : #updating }
BlDevScripterNestedChildEventTarget >> updateUsing: aScripterEventTarget on: aStep [
	self addTarget: aScripterEventTarget.
	aStep target: self.
]

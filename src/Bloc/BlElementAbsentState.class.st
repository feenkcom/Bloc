"
Is used to define {{gtClass:BlElementStyle}} for an absent {{gtClass:BlElementState}}.
"
Class {
	#name : #BlElementAbsentState,
	#superclass : #BlElementState,
	#instVars : [
		'state'
	],
	#category : #'Bloc-Core-State'
}

{ #category : #'class factory' }
BlElementAbsentState class >> ofType: aStateType [
	^ self ofType: aStateType priority: UserPriority
]

{ #category : #'class factory' }
BlElementAbsentState class >> ofType: aStateType priority: aPriority [
	^ self new
		type: aStateType
		priority: aPriority
]

{ #category : #testing }
BlElementAbsentState >> matches: aSetOfStates [
	^ (aSetOfStates
		like: state
		ifAbsent: [ nil ]) isNil
]

{ #category : #accessing }
BlElementAbsentState >> priority [
	^ state priority
]

{ #category : #accessing }
BlElementAbsentState >> type [
	"An 'Absent' state can not be element state, so this method should not be implemented"
	<return: #Object>

	^ self shouldNotImplement
]

{ #category : #initialization }
BlElementAbsentState >> type: aStateType priority: aPriority [
	state := BlElementTypedState
		ofType: aStateType
		priority: aPriority
]

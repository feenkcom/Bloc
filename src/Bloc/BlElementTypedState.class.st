"
A state that can be manually built from a state type and a priority.
"
Class {
	#name : #BlElementTypedState,
	#superclass : #BlElementState,
	#instVars : [
		'type',
		'priority'
	],
	#category : #'Bloc-Core-State'
}

{ #category : #'class factory' }
BlElementTypedState class >> ofType: aStateType priority: aPriority [
	^ self new
		type: aStateType
		priority: aPriority
]

{ #category : #accessing }
BlElementTypedState >> priority [
	^ priority
]

{ #category : #accessing }
BlElementTypedState >> type [
	"Return an object used to compare two states when adding to the collection of states in order to prevent
	elements from having duplicated states"
	<return: #Object>

	^ type
]

{ #category : #initialization }
BlElementTypedState >> type: aStateType priority: aPriority [
	type := aStateType.
	priority := aPriority
]

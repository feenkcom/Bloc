Class {
	#name : #BlUniqueIdGenerator,
	#superclass : #Object,
	#instVars : [
		'mutex',
		'nextUniqueId'
	],
	#category : 'Bloc-Space - Support'
}

{ #category : #accessing }
BlUniqueIdGenerator >> generateUniqueId [
	^ mutex critical: [
		| uniqueId |
		
		uniqueId := nextUniqueId.
		nextUniqueId := nextUniqueId + 1.
		uniqueId ]
]

{ #category : #initialization }
BlUniqueIdGenerator >> initialize [
	super initialize.
	
	mutex := Mutex new.
	nextUniqueId := 0
]

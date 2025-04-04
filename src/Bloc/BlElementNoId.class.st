Class {
	#name : #BlElementNoId,
	#superclass : #BlElementId,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Core-Support'
}

{ #category : #accessing }
BlElementNoId class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlElementNoId class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #comparing }
BlElementNoId >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #converting }
BlElementNoId >> asSymbol [
	^ nil
]

{ #category : #comparing }
BlElementNoId >> hash [
	^ self class hash
]

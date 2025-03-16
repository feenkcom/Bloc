"
# Custom id

Is intended to be subclassed for custom object-oriented ids

"
Class {
	#name : #BlElementUniqueId,
	#superclass : #BlElementId,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Core-Support'
}

{ #category : #converting }
BlElementUniqueId class >> asBlocElementId [
	^ self uniqueInstance
]

{ #category : #converting }
BlElementUniqueId class >> asSymbol [
	^ self uniqueInstance asSymbol
]

{ #category : #accessing }
BlElementUniqueId class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #converting }
BlElementUniqueId class >> indexed: anIndex [
	"Convert me to an indexed id with a given index"
	<return: #BlElementId>
	
	^ self asBlocElementId indexed: anIndex
]

{ #category : #testing }
BlElementUniqueId class >> isAbstract [
	^ self = BlElementUniqueId
]

{ #category : #accessing }
BlElementUniqueId class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #comparing }
BlElementUniqueId >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class or: [ (anObject isKindOf: BlElementId) and: [ self asSymbol = anObject asSymbol  ]]
]

{ #category : #accessing }
BlElementUniqueId >> description [
	^ self class comment
]

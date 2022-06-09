"
I represent a pool of objects.

"
Class {
	#name : #BlObjectPool,
	#superclass : #Object,
	#instVars : [
		'pool',
		'monitor',
		'maxPoolSize'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #private }
BlObjectPool class >> arrayType [
	^ IdentitySet
]

{ #category : #'instance creation' }
BlObjectPool class >> new [
	^ self basicNew
		setPool: (self arrayType new);
		initialize;
		maxPoolSize: Float infinity
]

{ #category : #'instance creation' }
BlObjectPool class >> new: anInteger [
	^ self basicNew
		setPool: (self arrayType new: anInteger);
		initialize;
		maxPoolSize: anInteger
]

{ #category : #'instance creation' }
BlObjectPool class >> pool: anObjectPool [
	^ self new initializeWith: anObjectPool
]

{ #category : #pool }
BlObjectPool >> acquire [
	^ monitor
		critical: [ pool size > 0
				ifTrue: [ | object |
					object := pool remove: pool anyOne.
					object ]
				ifFalse: [ nil ] ]
]

{ #category : #initialization }
BlObjectPool >> initialize [
	super initialize.

	monitor := Mutex new.
	maxPoolSize := 0
]

{ #category : #initialization }
BlObjectPool >> initializeWith: anObjectPool [
	pool := anObjectPool
]

{ #category : #testing }
BlObjectPool >> isInPool: anObject [
	"Return true of anObject is currently in the pool,
	false otherwise.
	anObject must not be nil"

	<return: #Boolean>
	self assert: anObject isNotNil.

	^ pool includes: anObject
]

{ #category : #initialization }
BlObjectPool >> maxPoolSize: aNumber [
	maxPoolSize := aNumber
]

{ #category : #pool }
BlObjectPool >> release: anObject [
	"Adds anObject to the pool and return true if successfully added,
	false otherwise.
	anObject must not be nil"

	<return: #Boolean>
	^ monitor
		critical: [ self assert: anObject isNotNil.

			(self isInPool: anObject)
				ifTrue: [ self error: anObject asString , ' is already in the pool!' ].

			pool size < maxPoolSize
				ifTrue: [ pool add: anObject.
					true ]
				ifFalse: [ false ] ]
]

{ #category : #initialization }
BlObjectPool >> setPool: aCollection [
	pool := aCollection
]

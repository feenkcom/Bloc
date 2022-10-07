Class {
	#name : #BlSessionValueHolder,
	#superclass : #Object,
	#instVars : [
		'session',
		'value'
	],
	#category : #'Bloc-Basic-Units'
}

{ #category : #'instance creation' }
BlSessionValueHolder class >> value: aValue [
	^ self new value: aValue
]

{ #category : #accessing }
BlSessionValueHolder >> ifNone: aNoneBlock [
	^ self
		valueDo: [ :aParagraph | aParagraph ]
		ifNone: aNoneBlock
]

{ #category : #accessing }
BlSessionValueHolder >> ifNonePut: aNoneBlock [
	^ self
		valueDo: [ :aParagraph | aParagraph ]
		ifNonePut: aNoneBlock
]

{ #category : #accessing }
BlSessionValueHolder >> value: anObject [
	value := anObject.
	session := Smalltalk session
]

{ #category : #accessing }
BlSessionValueHolder >> valueDo: aBlock [
	^ self
		valueDo: aBlock
		ifNone: [ ]
]

{ #category : #accessing }
BlSessionValueHolder >> valueDo: aBlock ifNone: aNoneBlock [
	^ self
		valueDo: aBlock
		ifNonePut: [ aNoneBlock value. nil ]
]

{ #category : #accessing }
BlSessionValueHolder >> valueDo: aBlock ifNonePut: aNoneBlock [
	^ (value notNil and: [ session == Smalltalk session ])
		ifTrue: [ aBlock value: value ]
		ifFalse: [
			session := Smalltalk session.
			value := aNoneBlock value ]
]

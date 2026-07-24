"
# Null space reference
Null space reference {{gtClass:BlSpaceReference}} is set when an element is `removed` from the scene graph.

"
Class {
	#name : #BlNullSpaceReference,
	#superclass : #BlSpaceReference,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Space'
}

{ #category : #cleanup }
BlNullSpaceReference class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlNullSpaceReference class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #converting }
BlNullSpaceReference >> asAttachedSpaceReference [
	^ BlAttachedSpaceReference uniqueInstance
]

{ #category : #converting }
BlNullSpaceReference >> asTemporarilyDetachedSpaceReference [
	self shouldNotImplement
]

{ #category : #testing }
BlNullSpaceReference >> isNull [
	^ true
]

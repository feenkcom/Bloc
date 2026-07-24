"
# Detached space reference
Detached space reference {{gtClass:BlSpaceReference}} is set when an element is temporarily `detached` from the scene graph.

"
Class {
	#name : #BlTemporarilyDetachedSpaceReference,
	#superclass : #BlSpaceReference,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Space'
}

{ #category : #cleanup }
BlTemporarilyDetachedSpaceReference class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlTemporarilyDetachedSpaceReference class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #converting }
BlTemporarilyDetachedSpaceReference >> asAttachedSpaceReference [
	^ BlAttachedSpaceReference uniqueInstance
]

{ #category : #converting }
BlTemporarilyDetachedSpaceReference >> asTemporarilyDetachedSpaceReference [
	^ self
]

{ #category : #testing }
BlTemporarilyDetachedSpaceReference >> isAddedToSceneGraph [
	^ true
]

{ #category : #testing }
BlTemporarilyDetachedSpaceReference >> isDetachedFromSceneGraph [
	^ true
]

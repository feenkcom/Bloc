"
# Attached space reference
Attached space reference {{gtClass:BlSpaceReference}} is set when an element is `attached` to the scene graph.

"
Class {
	#name : #BlAttachedSpaceReference,
	#superclass : #BlSpaceReference,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Space'
}

{ #category : #cleanup }
BlAttachedSpaceReference class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlAttachedSpaceReference class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #converting }
BlAttachedSpaceReference >> asAttachedSpaceReference [
	^ self
]

{ #category : #converting }
BlAttachedSpaceReference >> asTemporarilyDetachedSpaceReference [
	^ BlTemporarilyDetachedSpaceReference uniqueInstance
]

{ #category : #testing }
BlAttachedSpaceReference >> isAddedToSceneGraph [
	^ true
]

{ #category : #testing }
BlAttachedSpaceReference >> isAttachedToSceneGraph [
	^ true
]

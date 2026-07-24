Class {
	#name : #BlTemporarilyDetachedCachedSpaceReference,
	#superclass : #BlTemporarilyDetachedSpaceReference,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Space'
}

{ #category : #'instance creation' }
BlTemporarilyDetachedCachedSpaceReference class >> forSpace: aBlSpace [
	^ self new space: aBlSpace
]

{ #category : #converting }
BlTemporarilyDetachedCachedSpaceReference >> asAttachedSpaceReference [
	^ BlAttachedCachedSpaceReference forSpace: self space
]

{ #category : #accessing }
BlTemporarilyDetachedCachedSpaceReference >> space [
	^ space
]

{ #category : #accessing }
BlTemporarilyDetachedCachedSpaceReference >> space: aBlSpace [
	space := aBlSpace
]

{ #category : #enumerating }
BlTemporarilyDetachedCachedSpaceReference >> spaceDo: aBlock [
	"Evaluate a given block with a bloc space as an argument"
	
	aBlock value: self space
]

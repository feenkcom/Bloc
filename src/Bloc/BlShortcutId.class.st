Class {
	#name : #BlShortcutId,
	#superclass : #Object,
	#instVars : [
		'description',
		'identifier'
	],
	#category : 'Bloc-Events-KeyBinding'
}

{ #category : #'instance creation' }
BlShortcutId class >> identifier: anIdentifier [ 
	^self identifier: anIdentifier description: nil
]

{ #category : #'instance creation' }
BlShortcutId class >> identifier: anIdentifier description: aDescription [
	^self new 
		initializeWithIdentifier: anIdentifier description: aDescription
]

{ #category : #comparing }
BlShortcutId >> = anObject [
	self == anObject ifTrue: [^true].
	self class = anObject class ifFalse: [^false].
	^self identifier = anObject identifier
]

{ #category : #accessing }
BlShortcutId >> description [
	^description
]

{ #category : #accessing }
BlShortcutId >> description: aString [
	description := aString
]

{ #category : #printing }
BlShortcutId >> gtDisplayOn: aStream [
	aStream nextPutAll: self identifier
]

{ #category : #comparing }
BlShortcutId >> hash [
	^identifier hash 
]

{ #category : #accessing }
BlShortcutId >> identifier [
	^identifier
]

{ #category : #accessing }
BlShortcutId >> identifier: aSynbol [
	identifier := aSynbol
]

{ #category : #initialization }
BlShortcutId >> initializeWithIdentifier: anIdentifier description: aDescription [
	identifier := anIdentifier.
	description := aDescription.
]

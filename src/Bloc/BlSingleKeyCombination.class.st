"
I represent a key combination that consists of one distinct key.

I am play a role of a leaf in `=BlKeyCombination`= composition tree.

Public API and Key Messages

- key: initialize me with a given Key
- key return an instance of Key that I represent as combination

 Examples:

	BlSingleKeyCombination key: Key arrowUp
	
	BlSingleKeyCombination new
		key: Key arrowUp
 
Internal Representation and Key Implementation Points.

    Instance Variables
	key:		<Key>


    Implementation Points

	#matches: returns true if key is pressed, which does not enforce the fact that there should be only one pressed key at a time
	
	#match: return 1 if I match any pressed key and 0 otherwise

"
Class {
	#name : #BlSingleKeyCombination,
	#superclass : #BlKeyCombination,
	#instVars : [
		'key'
	],
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #accessing }
BlSingleKeyCombination class >> key: aKey [
	^ self new key: aKey
]

{ #category : #comparing }
BlSingleKeyCombination >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ key = anObject key
]

{ #category : #visiting }
BlSingleKeyCombination >> accept: aKeyCombinationVisitor [
	^ aKeyCombinationVisitor visitKey: self
]

{ #category : #converting }
BlSingleKeyCombination >> asBufferKeys [
	^ { key } asSet
]

{ #category : #accessing }
BlSingleKeyCombination >> gtDisplayOn: aStream [
	self key isMeta
		ifTrue: [ ^ aStream
				nextPutAll: (self key name copyReplaceAll: 'Meta' with: OSPlatform current defaultModifier name) asString ].
	self key isControl
		ifTrue: [ ^ aStream
				nextPutAll: (self key name copyReplaceAll: 'Control' with: 'Ctrl') asString ].

	aStream nextPutAll: self key name asString
]

{ #category : #comparing }
BlSingleKeyCombination >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ key hash
]

{ #category : #'key matching' }
BlSingleKeyCombination >> includes: aKey [
	^ self key = aKey
]

{ #category : #testing }
BlSingleKeyCombination >> isOnlyAlt [
	^ self key isAlt
]

{ #category : #testing }
BlSingleKeyCombination >> isOnlyControl [
	^ self key isControl
]

{ #category : #testing }
BlSingleKeyCombination >> isOnlyMeta [
	^ self key isMeta
]

{ #category : #testing }
BlSingleKeyCombination >> isOnlyReturnOrEnter [
	^ self key isReturnOrEnter
]

{ #category : #testing }
BlSingleKeyCombination >> isOnlyShift [
	^ self key isShift
]

{ #category : #testing }
BlSingleKeyCombination >> isSingleKey [
	^ true
]

{ #category : #accessing }
BlSingleKeyCombination >> key [
	<return: #BlKeyboardKey>

	^ key
]

{ #category : #accessing }
BlSingleKeyCombination >> key: aKey [
	self
		assert: [ aKey isNotNil ]
		description: [ 'Key must not be nil' ].

	key := aKey
]

{ #category : #'key matching' }
BlSingleKeyCombination >> match: aKeyboardBuffer [
	<return: #Number>
	^ (self partiallyMatchesKeyBuffer: aKeyboardBuffer) asBit
]

{ #category : #'key matching' }
BlSingleKeyCombination >> matchesKeyBuffer: aKeyboardBuffer [
	"Single key matches the keybuffer only if it is the only pressed key"
	<return: #Boolean>
	
	^ aKeyboardBuffer size = 1
		and: [ aKeyboardBuffer isPressed: key ]
]

{ #category : #'key matching' }
BlSingleKeyCombination >> partiallyMatchesKeyBuffer: aKeyboardBuffer [
	"Return true if the key combination partially matches the key buffer"
	<return: #Boolean>
	
	^ aKeyboardBuffer isPressed: key
]

{ #category : #printing }
BlSingleKeyCombination >> printOn: aStream [
	aStream nextPutAll: self key name asString
]

{ #category : #printing }
BlSingleKeyCombination >> storeOn: aStream [
	
	aStream
		store: key;
		space;
		nextPutAll: #asKeyCombination
]

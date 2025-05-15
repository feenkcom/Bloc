"
I represent an alternative ""OR"" combination of multiple distinct keys. (disjunction)

I am very useful to support shortcuts that treat different keyboard keys as identical.
For example there might be two SHIFT keys: SHIFT_L (left shift) and SHIFT_R (right shift). In most cases for the end user there should be no difference between those two.

Here is an example of how to unify two shifts:

BlAlternativeCombination new
	key: Key leftShift;
	key: Key rightShift;
	yourself

Unified meta (cmd):

BlAlternativeCombination new
	with: (BlSingleKeyCombination key: Key leftMeta);
	with: (BlSingleKeyCombination key: Key rightMeta);
	yourself

"
Class {
	#name : #BlAlternativeCombination,
	#superclass : #BlKeyCombination,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #'instance creation' }
BlAlternativeCombination class >> combination: aKeyCombination or: anotherKeyCombination [
	^ self basicNew
		initialize;
		combination: aKeyCombination or: anotherKeyCombination;
		yourself
]

{ #category : #'instance creation' }
BlAlternativeCombination class >> key: aKey or: anotherKey [
	^ self basicNew
		initialize;
		key: aKey or: anotherKey;
		yourself
]

{ #category : #comparing }
BlAlternativeCombination >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].

	^ left = anObject left
		or: [ right = anObject right ]
]

{ #category : #visiting }
BlAlternativeCombination >> accept: aKeyCombinationVisitor [
	^ aKeyCombinationVisitor visitAlternative: self
]

{ #category : #converting }
BlAlternativeCombination >> asBufferKeys [
	^ left asBufferKeys
]

{ #category : #initialization }
BlAlternativeCombination >> combination: aKeyCombination or: anotherKeyCombination [
	self assert: [ aKeyCombination notNil ] description: [ 'Key combination must not be nil' ].
	self assert: [ anotherKeyCombination notNil ] description: [ 'Key combination must not be nil' ].

	left := aKeyCombination.
	right := anotherKeyCombination
]

{ #category : #accessing }
BlAlternativeCombination >> combinations [
	<return: #SequenceableCollection of: #BlKeyCombination>

	^ { left . right }
]

{ #category : #accessing }
BlAlternativeCombination >> gtAlternativeCombinationsFor: aView [
	<gtView>
	^ aView list 
		title: 'Alternative combinations';
		items: [ { left . right } ]
]

{ #category : #printing }
BlAlternativeCombination >> gtDisplayOn: aStream [
	self isOnlyMeta
		ifTrue: [ ^ OSPlatform current defaultModifier printOn: aStream ].
	self isOnlyShift
		ifTrue: [ ^ aStream nextPutAll: 'Shift' ].
	self isOnlyControl
		ifTrue: [ ^ aStream nextPutAll: 'Ctrl' ].
	self isOnlyAlt
		ifTrue: [ ^ aStream nextPutAll: 'Alt' ].
	self isOnlyReturnOrEnter
		ifTrue: [ ^ aStream nextPutAll: 'Return' ].

	left gtDisplayOn: aStream.
	aStream nextPutAll: ' | '.
	right gtDisplayOn: aStream
]

{ #category : #comparing }
BlAlternativeCombination >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ (left hash + right hash) hashMultiply
]

{ #category : #testing }
BlAlternativeCombination >> includes: aKey [
	^ (left includes: aKey)
		or: [ right includes: aKey ]
]

{ #category : #testing }
BlAlternativeCombination >> isAlternative [
	^ true
]

{ #category : #testing }
BlAlternativeCombination >> isOnlyAlt [
	^ left isOnlyAlt or: [ right isOnlyAlt ]
]

{ #category : #testing }
BlAlternativeCombination >> isOnlyControl [
	^ left isOnlyControl or: [ right isOnlyControl ]
]

{ #category : #testing }
BlAlternativeCombination >> isOnlyMeta [
	^ left isOnlyMeta or: [ right isOnlyMeta ]
]

{ #category : #testing }
BlAlternativeCombination >> isOnlyReturnOrEnter [
	^ left isOnlyReturnOrEnter or: [ right isOnlyReturnOrEnter ]
]

{ #category : #testing }
BlAlternativeCombination >> isOnlyShift [
	^ left isOnlyShift or: [ right isOnlyShift ]
]

{ #category : #initialization }
BlAlternativeCombination >> key: aKey or: anotherKey [
	left := BlSingleKeyCombination key: aKey.
	right := BlSingleKeyCombination key: anotherKey
]

{ #category : #accessing }
BlAlternativeCombination >> left [
	^ left
]

{ #category : #'key matching' }
BlAlternativeCombination >> match: aKeyboardBuffer [
	<return: #Number>
	
	^ (left match: aKeyboardBuffer) + (right match: aKeyboardBuffer)
]

{ #category : #'key matching' }
BlAlternativeCombination >> matchesKeyBuffer: aKeyboardBuffer [
	<return: #Boolean>

	^ (left matchesKeyBuffer: aKeyboardBuffer)
		or: [ right matchesKeyBuffer: aKeyboardBuffer ]
]

{ #category : #'key matching' }
BlAlternativeCombination >> partiallyMatchesKeyBuffer: aKeyboardBuffer [
	"Return true if the key combination partially matches the key buffer"
	<return: #Boolean>
	
	^ (left partiallyMatchesKeyBuffer: aKeyboardBuffer)
		or: [ right partiallyMatchesKeyBuffer: aKeyboardBuffer ]
]

{ #category : #printing }
BlAlternativeCombination >> printOn: aStream [
	aStream
		nextPut: $(;
		print: left;
		nextPutAll: ' | ';
		print: right;
		nextPut: $)
]

{ #category : #accessing }
BlAlternativeCombination >> right [
	^ right
]

{ #category : #printing }
BlAlternativeCombination >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self class name; space;
		nextPutAll: 'combination:'; space;
		nextPut: $(;
		store: left;
		nextPut: $);
		space;
		nextPutAll: 'or:'; space;
		nextPut: $(;
		store: right;
		nextPut: $);
		nextPut: $)
]

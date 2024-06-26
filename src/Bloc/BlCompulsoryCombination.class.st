"
I represent a compulsory ""AND"" combination of multiple distinct keys. (conjunction)
I am useful when there is a need to create a key combination that should be matched when all subcombinations are matching.

Example of a key combination that matches then and only then when both ""arrowLeft"" and ""W"" are pressed:

BlCompulsoryCombination new
	key: Key arrowLeft;
	key: Key w;
	yourself

Unified meta (cmd):

BlCompulsoryCombination new
	with: (BlSingleKeyCombination key: Key arrowLeft);
	with: (BlSingleKeyCombination key: Key w);
	yourself

"
Class {
	#name : #BlCompulsoryCombination,
	#superclass : #BlKeyCombination,
	#instVars : [
		'combinations'
	],
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #comparing }
BlCompulsoryCombination >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ combinations = anObject combinations
]

{ #category : #visiting }
BlCompulsoryCombination >> accept: aKeyCombinationVisitor [
	^ aKeyCombinationVisitor visitCompulsory: self
]

{ #category : #controlling }
BlCompulsoryCombination >> and: anotherKeyCombination [
	<return: #BlKeyCombination>

	^ self with: anotherKeyCombination
]

{ #category : #converting }
BlCompulsoryCombination >> asBufferKeys [
	^ combinations flatCollect: [ :eachCombination | eachCombination asBufferKeys ] as: Set
]

{ #category : #accessing }
BlCompulsoryCombination >> combinations [
	<return: #SequenceableCollection of: #BlKeyCombination>
	
	^ combinations
]

{ #category : #printing }
BlCompulsoryCombination >> gtDisplayOn: aStream [
	self combinations
		do: [ :aCombination | aCombination gtDisplayOn: aStream ]
		separatedBy: [ aStream nextPutAll: '+' ]
]

{ #category : #comparing }
BlCompulsoryCombination >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ combinations hash
]

{ #category : #testing }
BlCompulsoryCombination >> includes: aKey [
	^ self combinations anySatisfy: [ :aCombination | aCombination includes: aKey ]
]

{ #category : #initialization }
BlCompulsoryCombination >> initialize [
	super initialize.
	
	combinations := OrderedCollection new
]

{ #category : #testing }
BlCompulsoryCombination >> isCompulsory [
	^ true
]

{ #category : #testing }
BlCompulsoryCombination >> isOnlyAlt [
	^ combinations allSatisfy: #isOnlyAlt
]

{ #category : #testing }
BlCompulsoryCombination >> isOnlyControl [
	^ combinations allSatisfy: #isOnlyControl
]

{ #category : #testing }
BlCompulsoryCombination >> isOnlyMeta [
	^ combinations allSatisfy: #isOnlyMeta
]

{ #category : #testing }
BlCompulsoryCombination >> isOnlyReturnOrEnter [
	^ combinations allSatisfy: #isOnlyReturnOrEnter
]

{ #category : #testing }
BlCompulsoryCombination >> isOnlyShift [
	^ combinations allSatisfy: #isOnlyShift
]

{ #category : #adding }
BlCompulsoryCombination >> key: aKey [
	self with: (BlSingleKeyCombination key: aKey)
]

{ #category : #'key matching' }
BlCompulsoryCombination >> match: aKeyboardBuffer [
	<return: #Number>

	^ self combinations
		inject: 0
		into: [ :aResult :aCombination | aResult + (aCombination match: aKeyboardBuffer) ]
]

{ #category : #'key matching' }
BlCompulsoryCombination >> matchesKeyBuffer: aKeyboardBuffer [
	<return: #Boolean>
	
	"empty key buffer does not match"
	aKeyboardBuffer isEmpty
		ifTrue: [ ^ false ].

	"Since this a compulsory key combination all child combinations must exactly match the key buffer.
	If sizes do not match it means that there is also no match in terms of keys"
	combinations size = aKeyboardBuffer size
		ifFalse: [ ^ false ].

	^ combinations allSatisfy: [ :eachCombination | eachCombination partiallyMatchesKeyBuffer: aKeyboardBuffer ]
]

{ #category : #'key matching' }
BlCompulsoryCombination >> partiallyMatchesKeyBuffer: aKeyboardBuffer [
	<return: #Boolean>

	^ combinations allSatisfy: [ :eachCombination | eachCombination partiallyMatchesKeyBuffer: aKeyboardBuffer ]
]

{ #category : #printing }
BlCompulsoryCombination >> printOn: aStream [
	
	aStream nextPut: $(.
	
	self combinations
		do: [ :aCombination | aCombination printOn: aStream ]
		separatedBy: [ aStream nextPutAll: ' & ' ].

	aStream nextPut: $).
]

{ #category : #printing }
BlCompulsoryCombination >> storeOn: aStream [
	aStream nextPut: $(.

	combinations size <= 1
		ifTrue: [
			aStream nextPutAll: self class name; space; nextPutAll: 'new'.
			combinations size = 1
				ifTrue: [ aStream space nextPutAll: #with:; space; store: combinations first ] ]
		ifFalse: [ 
			1 to: combinations size - 1 do: [ :i | aStream nextPut: $( ].
			combinations
				do: [ :eachCombination | aStream store: eachCombination ]
				separatedBy: [ aStream nextPutAll: ') and: ' ] ].

	aStream nextPut: $)
]

{ #category : #adding }
BlCompulsoryCombination >> with: aCombination [
	
	aCombination isCompulsory
		ifTrue: [ self combinations addAll: aCombination combinations ]
		ifFalse: [ self combinations add: aCombination ]
]

{ #category : #adding }
BlCompulsoryCombination >> withAll: aCollectionOfCombinations [
	aCollectionOfCombinations do: [ :aCombination | self with: aCombination ]
]

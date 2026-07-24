"
Physical key is an actual key on a keyboard. Some defined keys may not exist on a specific platform, or have a different meaning.
"
Class {
	#name : #BlPhysicalKeyboardKey,
	#superclass : #BlKeyboardKey,
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #comparing }
BlPhysicalKeyboardKey >> = anObject [
	"Answer whether the receiver and anObject represent the same object."
	| anotherPhysicalKey |

	self == anObject
		ifTrue: [ ^ true ].

	(anObject isKindOf: BlKeyboardKey)
		ifFalse: [ ^ false ].

	anotherPhysicalKey := anObject asPhysicalKey.
	self isUnkownKey = anotherPhysicalKey isUnkownKey
		ifFalse: [ ^ false ].

	^ self isUnkownKey
		ifTrue: [ value = anotherPhysicalKey value ]
		ifFalse: [ name = anotherPhysicalKey name ]
]

{ #category : #converting }
BlPhysicalKeyboardKey >> asPhysicalKey [
	^ self
]

{ #category : #comparing }
BlPhysicalKeyboardKey >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self isUnkownKey
		ifTrue: [ value hash ]
		ifFalse: [ name hash ]
]

{ #category : #testing }
BlPhysicalKeyboardKey >> isAlt [
	^ self = self class altLeft or: [ self = self class altRight ]
]

{ #category : #testing }
BlPhysicalKeyboardKey >> isArrowLeft [
	^ self = self class arrowLeft
]

{ #category : #testing }
BlPhysicalKeyboardKey >> isArrowRight [
	^ self = self class arrowRight
]

{ #category : #testing }
BlPhysicalKeyboardKey >> isControl [
	^ self = self class controlLeft or: [ self = self class  controlRight ]
]

{ #category : #testing }
BlPhysicalKeyboardKey >> isEscape [
	^ self = self class escape
]

{ #category : #testing }
BlPhysicalKeyboardKey >> isMeta [
	^ self = self class metaLeft or: [ self = self class metaRight ]
]

{ #category : #testing }
BlPhysicalKeyboardKey >> isPrimary [
	"Return true if primary modifier is pressed, false otherwise"

	| aPrimaryModifier |
	aPrimaryModifier := OSPlatform current primaryModifier.

	(self isMeta
		and: [ (aPrimaryModifier includes: BlKeyboardKey metaLeft)
				or: [ aPrimaryModifier includes: BlKeyboardKey metaRight ] ])
		ifTrue: [ ^ true ].

	(self isControl
		and: [ (aPrimaryModifier includes: BlKeyboardKey controlLeft)
				or: [ aPrimaryModifier includes: BlKeyboardKey controlRight ] ])
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #testing }
BlPhysicalKeyboardKey >> isReturn [
	^ self = self class return
]

{ #category : #testing }
BlPhysicalKeyboardKey >> isReturnOrEnter [
	^ self = self class return or: [ self = self class numpadEnter ]
]

{ #category : #testing }
BlPhysicalKeyboardKey >> isShift [
	^ self = self class shiftLeft or: [ self = self class shiftRight ]
]

{ #category : #testing }
BlPhysicalKeyboardKey >> isUnkownKey [
	<return: #Boolean>

	^ self name == self class unknownKeyName
]

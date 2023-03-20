"
Logical key represents a platform dependent key. For example, primary key on MacOS is `Meta`, while primary key on Windows is `Control`. A logical key be solved to a platform specific physical key at runtime {{gtExample:BlLogicalKeyboardKey>>#asPhysicalKey}}.


"
Class {
	#name : #BlLogicalKeyboardKey,
	#superclass : #BlKeyboardKey,
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #comparing }
BlLogicalKeyboardKey >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].

	"if anObject is of the same class as me - we know it is the same logical key "
	self class = anObject class
		ifTrue: [ ^ true ].

	(anObject isKindOf: BlKeyboardKey)
		ifFalse: [ ^ false ].
		
	^ self asPhysicalKey = anObject asPhysicalKey
]

{ #category : #converting }
BlLogicalKeyboardKey >> asPhysicalKey [
	^ self subclassResponsibility
]

{ #category : #comparing }
BlLogicalKeyboardKey >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self asPhysicalKey hash
]

{ #category : #testing }
BlLogicalKeyboardKey >> isAlt [
	^ self asPhysicalKey isAlt
]

{ #category : #testing }
BlLogicalKeyboardKey >> isArrowLeft [
	^ self asPhysicalKey isArrowLeft
]

{ #category : #testing }
BlLogicalKeyboardKey >> isArrowRight [
	^ self asPhysicalKey isArrowRight
]

{ #category : #testing }
BlLogicalKeyboardKey >> isControl [
	^ self asPhysicalKey isControl
]

{ #category : #testing }
BlLogicalKeyboardKey >> isEscape [
	^ self asPhysicalKey isEscape
]

{ #category : #testing }
BlLogicalKeyboardKey >> isMeta [
	^ self asPhysicalKey isMeta
]

{ #category : #testing }
BlLogicalKeyboardKey >> isReturn [
	^ self asPhysicalKey isReturn
]

{ #category : #testing }
BlLogicalKeyboardKey >> isReturnOrEnter [
	^ self asPhysicalKey isReturnOrEnter
]

{ #category : #testing }
BlLogicalKeyboardKey >> isShift [
	^ self asPhysicalKey isShift
]

{ #category : #testing }
BlLogicalKeyboardKey >> isUnkownKey [
	^ false
]

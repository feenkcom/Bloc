Class {
	#name : #BlPrimaryLeftKeyboardKey,
	#superclass : #BlLogicalKeyboardKey,
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #converting }
BlPrimaryLeftKeyboardKey >> asPhysicalKey [
	^ OSPlatform current primaryLeftKey
]

{ #category : #testing }
BlPrimaryLeftKeyboardKey >> isPrimary [
	^ true
]

{ #category : #accessing }
BlPrimaryLeftKeyboardKey >> name [
	^ #PrimaryLeft
]

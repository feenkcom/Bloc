Class {
	#name : #BlPrimaryRightKeyboardKey,
	#superclass : #BlLogicalKeyboardKey,
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #converting }
BlPrimaryRightKeyboardKey >> asPhysicalKey [
	^ OSPlatform current primaryRightKey
]

{ #category : #testing }
BlPrimaryRightKeyboardKey >> isPrimary [
	^ true
]

{ #category : #accessing }
BlPrimaryRightKeyboardKey >> name [
	^ #PrimaryRight
]

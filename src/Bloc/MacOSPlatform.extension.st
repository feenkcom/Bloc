Extension { #name : #MacOSPlatform }

{ #category : #'*Bloc' }
MacOSPlatform >> primaryLeftKey [
	^ BlKeyboardKey metaLeft
]

{ #category : #'*Bloc' }
MacOSPlatform >> primaryModifier [
	^ BlAlternativeCombination
		key: BlKeyboardKey primaryLeft
		or: BlKeyboardKey primaryRight
]

{ #category : #'*Bloc' }
MacOSPlatform >> primaryRightKey [
	^ BlKeyboardKey metaRight
]

{ #category : #'*Bloc' }
MacOSPlatform >> secondaryModifier [
	^ BlAlternativeCombination
		key: BlKeyboardKey controlLeft
		or: BlKeyboardKey controlRight
]

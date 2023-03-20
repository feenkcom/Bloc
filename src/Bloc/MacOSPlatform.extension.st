Extension { #name : #MacOSPlatform }

{ #category : #'*Bloc' }
MacOSPlatform >> primaryLeftKey [
	^ BlKeyboardKey metaLeft
]

{ #category : #'*Bloc' }
MacOSPlatform >> primaryModifier [
	^ BlAlternativeCombination new
		key: BlKeyboardKey primaryLeft;
		key: BlKeyboardKey primaryRight;
		yourself
]

{ #category : #'*Bloc' }
MacOSPlatform >> primaryRightKey [
	^ BlKeyboardKey metaRight
]

{ #category : #'*Bloc' }
MacOSPlatform >> secondaryModifier [
	^ BlAlternativeCombination new
		key: BlKeyboardKey controlLeft;
		key: BlKeyboardKey controlRight;
		yourself
]

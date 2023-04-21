Extension { #name : #UnixPlatform }

{ #category : #'*Bloc' }
UnixPlatform >> blocKeyFor: aKeyValue in: aKeyTable [
	<return: #BlKeyboardKey>

	^ aKeyTable valueForUnixPlatform: aKeyValue
]

{ #category : #'*Bloc' }
UnixPlatform >> primaryLeftKey [
	^ BlKeyboardKey controlLeft
]

{ #category : #'*Bloc' }
UnixPlatform >> primaryModifier [
	^ BlAlternativeCombination
		key: BlKeyboardKey controlLeft
		or: BlKeyboardKey controlRight
]

{ #category : #'*Bloc' }
UnixPlatform >> primaryRightKey [
	^ BlKeyboardKey controlRight
]

{ #category : #'*Bloc' }
UnixPlatform >> secondaryModifier [
	^ BlAlternativeCombination
		key: BlKeyboardKey altLeft
		or: BlKeyboardKey altRight
]

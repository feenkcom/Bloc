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
	^ BlAlternativeCombination new
		key: BlKeyboardKey controlLeft;
		key: BlKeyboardKey controlRight;
		yourself
]

{ #category : #'*Bloc' }
UnixPlatform >> primaryRightKey [
	^ BlKeyboardKey controlRight
]

{ #category : #'*Bloc' }
UnixPlatform >> secondaryModifier [
	^ BlAlternativeCombination new
		key: BlKeyboardKey altLeft;
		key: BlKeyboardKey altRight;
		yourself
]

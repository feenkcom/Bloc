Extension { #name : #WinPlatform }

{ #category : #'*Bloc' }
WinPlatform >> blocKeyFor: aKeyValue in: aKeyTable [
	<return: #BlKeyboardKey>

	^ aKeyTable valueForWindowsPlatform: aKeyValue
]

{ #category : #'*Bloc' }
WinPlatform >> primaryLeftKey [
	^ BlKeyboardKey controlLeft
]

{ #category : #'*Bloc' }
WinPlatform >> primaryModifier [
	^ BlAlternativeCombination
		key: BlKeyboardKey controlLeft
		or: BlKeyboardKey controlRight
]

{ #category : #'*Bloc' }
WinPlatform >> primaryRightKey [
	^ BlKeyboardKey controlRight
]

{ #category : #'*Bloc' }
WinPlatform >> secondaryModifier [
	^ BlAlternativeCombination
		key: BlKeyboardKey altLeft
		or: BlKeyboardKey altRight
]

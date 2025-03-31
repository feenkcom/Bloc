Class {
	#name : #BlWinit30HostSpace,
	#superclass : #BlRustWindowingHostSpace,
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #'as yet unclassified' }
BlWinit30HostSpace >> convertKeyFromEvent: anEvent [
	<return: #BlKeyboardKey>
	
	anEvent keyType = Winit30KeyType UnknownType
		ifTrue: [ ^ BlKeyboardKey unknown: anEvent scanCode ].
		
	^ self keyboardKeyTable keyFromVirtualCode: anEvent key
]

{ #category : #'as yet unclassified' }
BlWinit30HostSpace >> keyboardKeyTable [
	^ BlWinit30KeyboardKeyTable default
]

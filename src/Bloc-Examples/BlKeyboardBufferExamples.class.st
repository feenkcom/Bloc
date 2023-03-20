Class {
	#name : #BlKeyboardBufferExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #accessing }
BlKeyboardBufferExamples >> bufferWithKeyA [
	<gtExample>
	| aBuffer |
	
	aBuffer := BlKeyboardBuffer new
		add: (BlKeyDownEvent new key: BlKeyboardKey a);
		yourself.
		
	self assert: (aBuffer isPressed: BlKeyboardKey a).
	self assert: (aBuffer isPressed: BlKeyboardKey primaryLeft) not.
	
	^ aBuffer
]

{ #category : #accessing }
BlKeyboardBufferExamples >> bufferWithPrimaryLeft [
	<gtExample>
	| aBuffer aPlatformKey |

	aPlatformKey := OSPlatform current primaryLeftKey.

	aBuffer := BlKeyboardBuffer new
		add: (BlKeyDownEvent new key: aPlatformKey);
		yourself.

	self assert: (aBuffer isPressed: BlKeyboardKey a) not.
	self assert: (aBuffer isPressed: BlKeyboardKey primaryLeft).

	^ aBuffer
]

{ #category : #accessing }
BlKeyboardBufferExamples >> bufferWithPrimaryRight [
	<gtExample>
	| aBuffer aPlatformKey |

	aPlatformKey := OSPlatform current primaryRightKey.

	aBuffer := BlKeyboardBuffer new
		add: (BlKeyDownEvent new key: aPlatformKey);
		yourself.

	self assert: (aBuffer isPressed: BlKeyboardKey a) not.
	self assert: (aBuffer isPressed: BlKeyboardKey primaryRight).

	^ aBuffer
]

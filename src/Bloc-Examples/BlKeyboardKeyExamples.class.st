Class {
	#name : #BlKeyboardKeyExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #'instance creation' }
BlKeyboardKeyExamples >> allKeys [
	<gtExample>
	<return: #Array>
	| allKeys |
	allKeys := BlKeyboardKey all.
	self assert: allKeys size > 0.

	^ allKeys
]

{ #category : #'instance creation' }
BlKeyboardKeyExamples >> arrowLeft [
	<gtExample>
	<return: #BlPhysicalKeyboardKey>
	| aKey |
	aKey := BlKeyboardKey arrowLeft.
	self assert: aKey value equals: nil.
	self assert: aKey name equals: #ArrowLeft.

	^ aKey
]

{ #category : #'examples - compare' }
BlKeyboardKeyExamples >> physicalKeysEqual [
	<gtExample>
	<return: #BlKeyboardKeyExamples>
	self assert: BlKeyboardKey a = BlKeyboardKey a.
	self assert: BlKeyboardKey b = BlKeyboardKey b.
	self assert: BlKeyboardKey a ~= BlKeyboardKey b
]

{ #category : #'examples - compare' }
BlKeyboardKeyExamples >> primaryLeftEqualsToControlOnLinux [
	<gtExample>
	<return: #BlPrimaryLeftKeyboardKey>
	| aKey |
	aKey := BlKeyboardKey primaryLeft.

	OSPlatform current isLinux ifFalse: [ ^ aKey ].

	self assert: aKey = BlKeyboardKey controlLeft.
	self assert: BlKeyboardKey controlLeft = aKey.
	self assert: aKey hash = BlKeyboardKey controlLeft hash.

	^ aKey
]

{ #category : #'examples - compare' }
BlKeyboardKeyExamples >> primaryLeftEqualsToControlOnWindows [
	<gtExample>
	<return: #BlPrimaryLeftKeyboardKey>
	| aKey |
	aKey := BlKeyboardKey primaryLeft.

	OSPlatform current isWindows ifFalse: [ ^ aKey ].

	self assert: aKey = BlKeyboardKey controlLeft.
	self assert: BlKeyboardKey controlLeft = aKey.
	self assert: aKey hash = BlKeyboardKey controlLeft hash.

	^ aKey
]

{ #category : #'examples - compare' }
BlKeyboardKeyExamples >> primaryLeftEqualsToMetaOnMac [
	<gtExample>
	<return: #BlPrimaryLeftKeyboardKey>
	| aKey |
	aKey := BlKeyboardKey primaryLeft.

	OSPlatform current isMacOS ifFalse: [ ^ aKey ].

	self assert: aKey = BlKeyboardKey metaLeft.
	self assert: BlKeyboardKey metaLeft = aKey.
	self assert: aKey hash = BlKeyboardKey metaLeft hash.

	^ aKey
]

{ #category : #'instance creation' }
BlKeyboardKeyExamples >> primaryLeftKey [
	<gtExample>
	<return: #BlPrimaryLeftKeyboardKey>
	| aKey |
	aKey := BlKeyboardKey primaryLeft.

	self
		assert: aKey isControl = (OSPlatform current primaryLeftKey = BlKeyboardKey controlLeft).
	self
		assert: aKey isMeta = (OSPlatform current primaryLeftKey = BlKeyboardKey metaLeft).
	self assert: aKey isPrimary.

	self assert: aKey isUnkownKey not.
	self assert: aKey isAlt not.
	self assert: aKey isArrowLeft not.
	self assert: aKey isArrowRight not.
	self assert: aKey isEscape not.
	self assert: aKey isReturn not.
	self assert: aKey isReturnOrEnter not.
	self assert: aKey isShift not.

	^ aKey
]

{ #category : #'instance creation' }
BlKeyboardKeyExamples >> primaryRightKey [
	<gtExample>
	<return: #BlPrimaryRightKeyboardKey>
	| aKey |
	aKey := BlKeyboardKey primaryRight.

	self
		assert: aKey isControl
				= (OSPlatform current primaryRightKey = BlKeyboardKey controlRight).
	self
		assert: aKey isMeta = (OSPlatform current primaryRightKey = BlKeyboardKey metaRight).
	self assert: aKey isPrimary.

	self assert: aKey isUnkownKey not.
	self assert: aKey isAlt not.
	self assert: aKey isArrowLeft not.
	self assert: aKey isArrowRight not.
	self assert: aKey isEscape not.
	self assert: aKey isReturn not.
	self assert: aKey isReturnOrEnter not.
	self assert: aKey isShift not.

	^ aKey
]

{ #category : #'instance creation' }
BlKeyboardKeyExamples >> shiftLeftKey [
	<gtExample>
	<return: #BlPhysicalKeyboardKey>
	| aKey |
	aKey := BlKeyboardKey shiftLeft.

	self assert: aKey isControl not.
	self assert: aKey isMeta not.
	self assert: aKey isPrimary not.

	self assert: aKey isUnkownKey not.
	self assert: aKey isAlt not.
	self assert: aKey isArrowLeft not.
	self assert: aKey isArrowRight not.
	self assert: aKey isEscape not.
	self assert: aKey isReturn not.
	self assert: aKey isReturnOrEnter not.
	self assert: aKey isShift.

	^ aKey
]

{ #category : #'instance creation' }
BlKeyboardKeyExamples >> shiftRightKey [
	<gtExample>
	<return: #BlPhysicalKeyboardKey>
	| aKey |
	aKey := BlKeyboardKey shiftRight.

	self assert: aKey isControl not.
	self assert: aKey isMeta not.
	self assert: aKey isPrimary not.

	self assert: aKey isUnkownKey not.
	self assert: aKey isAlt not.
	self assert: aKey isArrowLeft not.
	self assert: aKey isArrowRight not.
	self assert: aKey isEscape not.
	self assert: aKey isReturn not.
	self assert: aKey isReturnOrEnter not.
	self assert: aKey isShift.

	^ aKey
]

{ #category : #'examples - store' }
BlKeyboardKeyExamples >> storeAllKeys [
	<gtExample>
	<return: #Array>
	| allKeys allRestoredKeys |
	allKeys := BlKeyboardKey all.
	allRestoredKeys := allKeys
			collect: [ :eachKey | Object evaluate: eachKey storeString ].

	self assert: allRestoredKeys equals: allKeys.

	^ allRestoredKeys
]

{ #category : #'examples - store' }
BlKeyboardKeyExamples >> storeArrowLeft [
	<gtExample>
	<return: #ByteString>
	| aKey aStoreString aRestoredKey |
	aKey := BlKeyboardKey arrowLeft.
	aStoreString := aKey storeString.

	self
		assert: aStoreString
		equals: '(BlPhysicalKeyboardKey new setName: #ArrowLeft; setValue: nil)'.

	aRestoredKey := Object evaluate: aStoreString.
	self assert: aRestoredKey equals: aKey.

	^ aStoreString
]

{ #category : #'examples - store' }
BlKeyboardKeyExamples >> storeUnknownKey [
	<gtExample>
	<return: #ByteString>
	| aKey aStoreString aRestoredKey |
	aKey := BlKeyboardKey unknown.
	aStoreString := aKey storeString.

	self
		assert: aStoreString
		equals: '(BlPhysicalKeyboardKey new setName: #Unknown; setValue: nil)'.

	aRestoredKey := Object evaluate: aStoreString.
	self assert: aRestoredKey equals: aKey.

	^ aStoreString
]

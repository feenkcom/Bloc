Class {
	#name : #BlCompulsoryCombinationExamples,
	#superclass : #BlKeyCombinationExamples,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #'examples - combination' }
BlCompulsoryCombinationExamples >> combinationWithA [
	<gtExample>
	<return: #BlCompulsoryCombination>
	| aCombination |
	aCombination := self emptyCombination.
	aCombination key: BlKeyboardKey a.

	self
		assert: (aCombination combinations asArray collect: #key)
		equals: {BlKeyboardKey a}.
	self assert: aCombination printString equals: '(A)'.
	self assert: aCombination gtDisplayString equals: 'A'.

	^ aCombination
]

{ #category : #'examples - combination' }
BlCompulsoryCombinationExamples >> combinationWithAB [
	<gtExample>
	<return: #BlCompulsoryCombination>
	| aCombination |
	aCombination := self combinationWithA.
	aCombination key: BlKeyboardKey b.

	self
		assert: (aCombination combinations asArray collect: #key)
		equals: {BlKeyboardKey a.
				BlKeyboardKey b}.
	self assert: aCombination printString equals: '(A & B)'.
	self assert: aCombination gtDisplayString equals: 'A+B'.

	^ aCombination
]

{ #category : #'examples - combination' }
BlCompulsoryCombinationExamples >> combinationWithABC [
	<gtExample>
	<return: #BlCompulsoryCombination>
	| aCombination |
	aCombination := self combinationWithAB.
	aCombination key: BlKeyboardKey c.

	self
		assert: (aCombination combinations asArray collect: #key)
		equals: {BlKeyboardKey a.
				BlKeyboardKey b.
				BlKeyboardKey c}.
	self assert: aCombination printString equals: '(A & B & C)'.
	self assert: aCombination gtDisplayString equals: 'A+B+C'.

	^ aCombination
]

{ #category : #'examples - combination' }
BlCompulsoryCombinationExamples >> emptyCombination [
	<gtExample>
	<return: #BlCompulsoryCombination>
	| aCombination |
	aCombination := BlCompulsoryCombination new.

	self assert: aCombination isCompulsory.
	self assert: aCombination combinations isEmpty.
	self assert: aCombination printString equals: '()'.
	self assert: aCombination gtDisplayString equals: ''.

	^ aCombination
]

{ #category : #'examples - store' }
BlCompulsoryCombinationExamples >> storeCombinationWithA [
	<gtExample>
	<return: #ByteString>
	| aCombination aStoreString aRestoredCombination |
	aCombination := self combinationWithA.
	aStoreString := aCombination storeString.

	self
		assert: aStoreString
		equals: '(BlCompulsoryCombination new with: (BlPhysicalKeyboardKey new setName: #A; setValue: nil) asKeyCombination)'.

	aRestoredCombination := Smalltalk compiler evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.

	^ aStoreString
]

{ #category : #'examples - store' }
BlCompulsoryCombinationExamples >> storeCombinationWithAB [
	<gtExample>
	<return: #ByteString>
	| aCombination aStoreString aRestoredCombination |
	aCombination := self combinationWithAB.
	aStoreString := aCombination storeString.

	self
		assert: aStoreString
		equals: '(((BlPhysicalKeyboardKey new setName: #A; setValue: nil) asKeyCombination) and: (BlPhysicalKeyboardKey new setName: #B; setValue: nil) asKeyCombination)'.

	aRestoredCombination := Smalltalk compiler evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.

	^ aStoreString
]

{ #category : #'examples - store' }
BlCompulsoryCombinationExamples >> storeCombinationWithABC [
	<gtExample>
	<return: #ByteString>
	| aCombination aStoreString aRestoredCombination |
	aCombination := self combinationWithABC.
	aStoreString := aCombination storeString.

	self
		assert: aStoreString
		equals: '((((BlPhysicalKeyboardKey new setName: #A; setValue: nil) asKeyCombination) and: (BlPhysicalKeyboardKey new setName: #B; setValue: nil) asKeyCombination) and: (BlPhysicalKeyboardKey new setName: #C; setValue: nil) asKeyCombination)'.

	aRestoredCombination := Smalltalk compiler evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.

	^ aStoreString
]

{ #category : #'examples - store' }
BlCompulsoryCombinationExamples >> storeEmptyCombination [
	<gtExample>
	<return: #ByteString>
	| aCombination aStoreString aRestoredCombination |
	aCombination := self emptyCombination.
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '(BlCompulsoryCombination new)'.

	aRestoredCombination := Smalltalk compiler evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.

	^ aStoreString
]

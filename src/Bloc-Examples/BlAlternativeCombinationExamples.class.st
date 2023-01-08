Class {
	#name : #BlAlternativeCombinationExamples,
	#superclass : #BlKeyCombinationExamples,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithA [
	<gtExample>
	| aCombination |
	
	aCombination := self emptyCombination.
	aCombination key: BlKeyboardKey a.

	self assert: (aCombination combinations asArray collect: #key) equals: { BlKeyboardKey a }.
	self assert: aCombination printString equals: '(A)'.
	
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithAB [
	<gtExample>
	| aCombination |
	
	aCombination := self combinationWithA.
	aCombination key: BlKeyboardKey b.

	self assert: (aCombination combinations asArray collect: #key) equals: { BlKeyboardKey a. BlKeyboardKey b }.
	self assert: aCombination printString equals: '(A | B)'.
	
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithABC [
	<gtExample>
	| aCombination |
	
	aCombination := self combinationWithAB.	
	aCombination key: BlKeyboardKey c.

	self assert: (aCombination combinations asArray collect: #key) equals: { BlKeyboardKey a. BlKeyboardKey b. BlKeyboardKey c }.
	self assert: aCombination printString equals: '(A | B | C)'.
	
	^ aCombination
]

{ #category : #accessing }
BlAlternativeCombinationExamples >> combinationWithABOrCD [
	<gtExample>
	| aCombination |
	aCombination := self combinationWithAB.
	aCombination or: ((self emptyCombination key: BlKeyboardKey c) key: BlKeyboardKey d).
	self assert: aCombination printString equals: '(A | B | C | D)'.
	^ aCombination
]

{ #category : #accessing }
BlAlternativeCombinationExamples >> combinationWithAltLeft [
	<gtExample>
	| aCombination |
	aCombination := self emptyCombination.
	aCombination key: BlKeyboardKey altLeft.
	self assert: aCombination printString equals: '(AltLeft)'.
	self assert: aCombination gtDisplayString equals: 'AltLeft'.

	^ aCombination
]

{ #category : #accessing }
BlAlternativeCombinationExamples >> combinationWithAltLeftAltRight [
	<gtExample>
	| aCombination |
	aCombination := self combinationWithAltLeft.
	aCombination key: BlKeyboardKey altRight.
	self assert: aCombination printString equals: '(AltLeft | AltRight)'.
	self assert: aCombination gtDisplayString equals: 'Alt'.
	^ aCombination
]

{ #category : #accessing }
BlAlternativeCombinationExamples >> combinationWithControlLeft [
	<gtExample>
	| aCombination |
	aCombination := self emptyCombination.
	aCombination key: BlKeyboardKey controlLeft.
	self assert: aCombination gtDisplayString equals: 'CtrlLeft'.
	^ aCombination
]

{ #category : #accessing }
BlAlternativeCombinationExamples >> combinationWithControlLeftControlRight [
	<gtExample>
	| aCombination |
	aCombination := self combinationWithControlLeft.
	aCombination key: BlKeyboardKey controlRight.
	self assert: aCombination gtDisplayString equals: 'Ctrl'.
]

{ #category : #accessing }
BlAlternativeCombinationExamples >> combinationWithMetaLeft [
	<gtExample>
	| aCombination |
	aCombination := self emptyCombination.
	aCombination key: BlKeyboardKey metaLeft.
	self assert: aCombination printString equals: '(MetaLeft)'.
	self assert: aCombination gtDisplayString equals: OSPlatform current defaultModifier printString, 'Left'.

	^ aCombination
]

{ #category : #accessing }
BlAlternativeCombinationExamples >> combinationWithMetaLeftMetaRight [
	<gtExample>
	| aCombination |
	aCombination := self combinationWithMetaLeft.
	aCombination key: BlKeyboardKey metaRight.
	self assert: aCombination printString equals: '(MetaLeft | MetaRight)'.

	^ aCombination
]

{ #category : #accessing }
BlAlternativeCombinationExamples >> combinationWithNumpadEnterReturnCompulsory [
	<gtExample>
	| aCombination |
	aCombination := BlKeyCombination enter.
	self assert: aCombination gtDisplayString equals: 'Enter'.
	^ aCombination
]

{ #category : #accessing }
BlAlternativeCombinationExamples >> combinationWithShiftLeft [
	<gtExample>
	| aCombination |
	aCombination := self emptyCombination.
	aCombination key: BlKeyboardKey shiftLeft.
	self assert: aCombination printString equals: '(ShiftLeft)'.
	self assert: aCombination gtDisplayString equals: 'ShiftLeft'.
	^ aCombination
]

{ #category : #accessing }
BlAlternativeCombinationExamples >> combinationWithShiftLeftShiftRight [
	<gtExample>
	| aCombination |
	aCombination := self combinationWithShiftLeft.
	aCombination key: BlKeyboardKey shiftRight.
	self assert: aCombination printString equals: '(ShiftLeft | ShiftRight)'.
	self assert: aCombination gtDisplayString equals: 'Shift'
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> emptyCombination [
	<gtExample>
	| aCombination |
	
	aCombination := BlAlternativeCombination new.

	self assert: aCombination isAlternative.
	self assert: aCombination combinations isEmpty.
	self assert: aCombination printString equals: '()'.
 
	^ aCombination
]

{ #category : #accessing }
BlAlternativeCombinationExamples >> leftRightUserPrintstringSimplification [
	<gtExample>
	| aCombo mod |
	mod := OSPlatform current defaultModifier name.
	
	aCombo := BlKeyCombination builder primary c build.
	self assert: aCombo gtDisplayString equals: mod, '+C'.
	^aCombo
	
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> matchCombinationWithA [
	<gtExample>
	| aCombination aBuffer |
	
	aCombination := self combinationWithA.
	
	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: true key: BlKeyboardKey a.
	aBuffer pressed: false key: BlKeyboardKey b.
	aBuffer pressed: false key: BlKeyboardKey c.
	
	self assert: (aCombination match: aBuffer) equals: 1.
	
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> matchCombinationWithAB [
	<gtExample>
	| aCombination aBuffer |
	
	aCombination := self combinationWithAB.
	
	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: false key: BlKeyboardKey a.
	aBuffer pressed: true key: BlKeyboardKey b.
	aBuffer pressed: false key: BlKeyboardKey c.
	
	"it should be precise match"
	self assert: (aCombination match: aBuffer) equals: 1.
	
	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: true key: BlKeyboardKey a.
	aBuffer pressed: false key: BlKeyboardKey b.
	aBuffer pressed: false key: BlKeyboardKey c.
	
	"it should be precise match"
	self assert: (aCombination match: aBuffer) equals: 1.
	
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> noMatchCombinationWithA [
	<gtExample>
	| aCombination aBuffer |
	
	aCombination := self combinationWithA.
	
	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: false key: BlKeyboardKey a.
	aBuffer pressed: true key: BlKeyboardKey b.
	aBuffer pressed: false key: BlKeyboardKey c.
	
	self assert: (aCombination match: aBuffer) equals: 0.
	
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> noMatchCombinationWithAB [
	<gtExample>
	| aCombination aBuffer |
	
	aCombination := self combinationWithAB.
	
	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: true key: BlKeyboardKey a.
	aBuffer pressed: true key: BlKeyboardKey b.
	aBuffer pressed: false key: BlKeyboardKey c.
	
	"it should be precise match"
	self assert: (aCombination match: aBuffer) equals: 0.
	
	^ aCombination
]

{ #category : #'examples - store' }
BlAlternativeCombinationExamples >> storeCombinationWithA [
	<gtExample>
	| aCombination aStoreString aRestoredCombination |
	
	aCombination := self combinationWithA.	
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '(BlAlternativeCombination new with: (BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination)'.
	
	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.
	
	^ aStoreString
]

{ #category : #'examples - store' }
BlAlternativeCombinationExamples >> storeCombinationWithAB [
	<gtExample>
	| aCombination aStoreString aRestoredCombination |
	
	aCombination := self combinationWithAB.	
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '(((BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination) or: (BlKeyboardKey new setName: #B; setValue: nil) asKeyCombination)'.
	
	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.
	
	^ aStoreString
]

{ #category : #'examples - store' }
BlAlternativeCombinationExamples >> storeCombinationWithABC [
	<gtExample>
	| aCombination aStoreString aRestoredCombination |
	
	aCombination := self combinationWithABC.	
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '((((BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination) or: (BlKeyboardKey new setName: #B; setValue: nil) asKeyCombination) or: (BlKeyboardKey new setName: #C; setValue: nil) asKeyCombination)'.
	
	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.
	
	^ aStoreString
]

{ #category : #'examples - store' }
BlAlternativeCombinationExamples >> storeEmptyCombination [
	<gtExample>
	| aCombination aStoreString aRestoredCombination |
	
	aCombination := self emptyCombination.	
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '(BlAlternativeCombination new)'.
	
	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.
	
	^ aStoreString
]

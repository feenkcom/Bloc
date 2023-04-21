Class {
	#name : #BlAlternativeCombinationExamples,
	#superclass : #BlKeyCombinationExamples,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithAB [
	<gtExample>
	| aCombination |
	
	aCombination := BlAlternativeCombination
		key: BlKeyboardKey a
		or: BlKeyboardKey b.

	self assert: (aCombination combinations collect: #key) equals: { BlKeyboardKey a. BlKeyboardKey b }.
	self assert: aCombination printString equals: '(A | B)'.
	self assert: aCombination gtDisplayString equals: 'A | B'.
	
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithABOrCD [
	<gtExample>
	| aCombination |
	aCombination := self combinationWithAB.

	aCombination := ((aCombination or: BlKeyboardKey c asKeyCombination) or: BlKeyboardKey d asKeyCombination).

	self assert: aCombination printString equals: '(((A | B) | C) | D)'.

	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithAltLeftAltRight [
	<gtExample>
	| aCombination |

	aCombination := BlAlternativeCombination
		key: BlKeyboardKey altLeft
		or: BlKeyboardKey altRight.

	self assert: aCombination printString equals: '(AltLeft | AltRight)'.
	self assert: aCombination gtDisplayString equals: 'Alt'.

	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithControlLeftControlRight [
	<gtExample>
	| aCombination |
	
	aCombination := BlAlternativeCombination
		key: BlKeyboardKey controlLeft
		or: BlKeyboardKey controlRight.

	self assert: aCombination printString equals: '(ControlLeft | ControlRight)'.
	self assert: aCombination gtDisplayString equals: 'Ctrl'.
	
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithMetaLeftMetaRight [
	<gtExample>
	| aCombination |
	
	aCombination := BlAlternativeCombination
		key: BlKeyboardKey metaLeft
		or: BlKeyboardKey metaRight.

	self assert: aCombination printString equals: '(MetaLeft | MetaRight)'.
	self assert: aCombination gtDisplayString equals: 'Cmd'.

	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithNumpadEnterReturnCompulsory [
	<gtExample>
	| aCombination |

	aCombination := BlKeyCombination enter.

	self assert: aCombination gtDisplayString equals: 'Enter'.

	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithShiftLeftShiftRight [
	<gtExample>
	| aCombination |

	aCombination := BlAlternativeCombination
		key: BlKeyboardKey shiftLeft
		or: BlKeyboardKey shiftRight.

	self assert: aCombination printString equals: '(ShiftLeft | ShiftRight)'.
	self assert: aCombination gtDisplayString equals: 'Shift'.
	
	^ aCombination
]

{ #category : #'examples - printing' }
BlAlternativeCombinationExamples >> leftRightUserPrintstringSimplification [
	<gtExample>
	| aCombo mod |

	mod := OSPlatform current defaultModifier name.	
	aCombo := BlKeyCombination builder primary c build.
	self assert: aCombo gtDisplayString equals: mod, '+C'.

	^ aCombo
	
]

{ #category : #'examples - matching' }
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
	self assert: (aCombination matchesKeyBuffer: aBuffer) equals: true.
	self assert: (aCombination partiallyMatchesKeyBuffer: aBuffer) equals: true.
	
	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: true key: BlKeyboardKey a.
	aBuffer pressed: false key: BlKeyboardKey b.
	aBuffer pressed: false key: BlKeyboardKey c.
	
	"it should be precise match"
	self assert: (aCombination match: aBuffer) equals: 1.
	self assert: (aCombination matchesKeyBuffer: aBuffer) equals: true.
	self assert: (aCombination partiallyMatchesKeyBuffer: aBuffer) equals: true.
	
	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: true key: BlKeyboardKey a.
	aBuffer pressed: true key: BlKeyboardKey b.
	aBuffer pressed: false key: BlKeyboardKey c.

	self assert: (aCombination match: aBuffer) equals: 2.
	self assert: (aCombination matchesKeyBuffer: aBuffer) equals: false.
	self assert: (aCombination partiallyMatchesKeyBuffer: aBuffer) equals: true.
	
	^ aCombination
]

{ #category : #'examples - matching' }
BlAlternativeCombinationExamples >> matchNumEnterOrReturn [
	<gtExample>
	| combination |
	
	combination := BlAlternativeCombination
		key: BlKeyboardKey numpadEnter
		or: BlKeyboardKey return.
	
	self assert: (combination matchesKeyBuffer: (BlKeyboardBuffer withPressedKeys: { BlKeyboardKey numpadEnter })).
	self assert: (combination matchesKeyBuffer: (BlKeyboardBuffer withPressedKeys: { BlKeyboardKey return })).
	self assert: (combination matchesKeyBuffer: (BlKeyboardBuffer withPressedKeys: { BlKeyboardKey shiftLeft })) not.
	"more than one key is pressed -> no match"
	self assert: (combination matchesKeyBuffer: (BlKeyboardBuffer withPressedKeys: { BlKeyboardKey numpadEnter . BlKeyboardKey return })) not.
	self assert: (combination matchesKeyBuffer: (BlKeyboardBuffer withPressedKeys: { BlKeyboardKey numpadEnter . BlKeyboardKey shiftLeft })) not.
		
	^ combination
]

{ #category : #'examples - matching' }
BlAlternativeCombinationExamples >> noMatchCombinationWithAB [
	<gtExample>
	| aCombination aBuffer |
	aCombination := self combinationWithAB.

	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: false key: BlKeyboardKey a.
	aBuffer pressed: false key: BlKeyboardKey b.
	aBuffer pressed: false key: BlKeyboardKey c.

	self assert: (aCombination matchesKeyBuffer: aBuffer) equals: false.
	self assert: (aCombination match: aBuffer) equals: 0.

	^ aCombination
]

{ #category : #'examples - store' }
BlAlternativeCombinationExamples >> storeCombinationWithAB [
	<gtExample>
	| aCombination aStoreString aRestoredCombination |
	
	aCombination := self combinationWithAB.	
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '(BlAlternativeCombination combination: ((BlPhysicalKeyboardKey new setName: #A; setValue: nil) asKeyCombination) or: ((BlPhysicalKeyboardKey new setName: #B; setValue: nil) asKeyCombination))'.
	
	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.
	
	^ aStoreString
]

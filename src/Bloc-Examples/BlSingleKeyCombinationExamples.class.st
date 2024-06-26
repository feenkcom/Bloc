Class {
	#name : #BlSingleKeyCombinationExamples,
	#superclass : #BlKeyCombinationExamples,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #'examples - combination' }
BlSingleKeyCombinationExamples >> arrowLeftCombination [
	<gtExample>
	| aKeyCombination |
	
	aKeyCombination := self arrowLeft asKeyCombination.
	self assert: (aKeyCombination isKindOf: BlSingleKeyCombination).
	self assert: aKeyCombination key equals: self arrowLeft.
	
	^ aKeyCombination
]

{ #category : #accessing }
BlSingleKeyCombinationExamples >> cGtDisplayString [
	<gtExample>
	| combo |
	combo := self c asKeyCombination.
	self assert: combo gtDisplayString equals: 'C'.
	^combo
]

{ #category : #'examples - store' }
BlSingleKeyCombinationExamples >> storeArrowLeftCombination [
	<gtExample>
	| aKeyCombination aStoreString aRestoredKeyCombination |
	
	aKeyCombination := self arrowLeftCombination.
	aStoreString := aKeyCombination storeString.
	
	self assert: aStoreString equals: '(BlPhysicalKeyboardKey new setName: #ArrowLeft; setValue: nil) asKeyCombination'.
	
	aRestoredKeyCombination := Object evaluate: aStoreString.
	self assert: aRestoredKeyCombination equals: aKeyCombination.
	
	^ aStoreString
]

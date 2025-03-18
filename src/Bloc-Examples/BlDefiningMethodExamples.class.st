"
I exemplify [](https://github.com/feenkcom/gtoolkit/issues/4361). 
"
Class {
	#name : #BlDefiningMethodExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Defining method'
}

{ #category : #'examples - methods' }
BlDefiningMethodExamples >> caseEight [
	^ [ :a :b | ]
]

{ #category : #'examples - methods' }
BlDefiningMethodExamples >> caseFour [
	<gtExample>
	^ self class compiler 
		source: self caseFourSource;
		class: self class;
		noPattern: true;
		receiver: self;
		compile
]

{ #category : #'examples - methods' }
BlDefiningMethodExamples >> caseFourSource [
	^ '[ :argument | 
		| aBlock |
		aBlock := argument 
			ifTrue: [ [ :a :b | a + b ] ] 
			ifFalse: [ self caseSix ].
		aBlock ]'
]

{ #category : #'examples - methods' }
BlDefiningMethodExamples >> caseNine [
	^ [ :a | ]
]

{ #category : #'examples - methods' }
BlDefiningMethodExamples >> caseOne [ 
	^ [ self caseTwo ]
]

{ #category : #'examples - methods' }
BlDefiningMethodExamples >> caseSeven [
	^ [ :a :b :c | ]
]

{ #category : #'examples - methods' }
BlDefiningMethodExamples >> caseSix [
	^ [ :a :b | a - b ]
]

{ #category : #'examples - methods' }
BlDefiningMethodExamples >> caseTwo [
	^ [ :argument | 
		| aBlock |
		aBlock := argument 
			ifTrue: [ [ :a :b | a + b ] ] 
			ifFalse: [ [ :a :b | a - b ] ].
		aBlock ]
]

{ #category : #'examples - defining methods' }
BlDefiningMethodExamples >> definingMethodCaseEight [
	<gtExample>
	| aBlock aMethod |
	aBlock := self caseEight.

	aMethod := aBlock blocDefiningMethod.
	self assert: aMethod equals: BlDefiningMethodExamples >> #caseEight.

	^ aBlock
]

{ #category : #'examples - defining methods' }
BlDefiningMethodExamples >> definingMethodCaseFive [
	<gtExample>
	| aBlock aMethod |
	aBlock := self definingMethodCaseFour value: true.

	aMethod := aBlock blocDefiningMethod.
	self assert: aMethod isDoIt.
	self assert: (aMethod = (BlDefiningMethodExamples >> #caseFour)) not.

	^ aBlock
]

{ #category : #'examples - defining methods' }
BlDefiningMethodExamples >> definingMethodCaseFour [
	<gtExample>
	| aCompiledMethod aDefiningMethod aBlock |
	aCompiledMethod := self caseFour.
	aDefiningMethod := aCompiledMethod blocDefiningMethod.
	self assert: aDefiningMethod isDoIt.
	self assert: aDefiningMethod == aCompiledMethod.
	self assert: (aDefiningMethod = (BlDefiningMethodExamples >> #caseFour)) not.

	aBlock := self withArgs: #() executeMethod: aCompiledMethod.
	
	^ aBlock
]

{ #category : #'examples - defining methods' }
BlDefiningMethodExamples >> definingMethodCaseNine [
	<gtExample>
	| aBlock aMethod |
	aBlock := self caseNine.

	aMethod := aBlock blocDefiningMethod.
	self assert: aMethod equals: BlDefiningMethodExamples >> #caseNine.

	^ aBlock
]

{ #category : #'examples - defining methods' }
BlDefiningMethodExamples >> definingMethodCaseOne [
	<gtExample>
	| aBlock aMethod |
	aBlock := self caseOne.

	aMethod := aBlock blocDefiningMethod.
	self assert: aMethod equals: BlDefiningMethodExamples >> #caseOne.

	^ aBlock
]

{ #category : #'examples - defining methods' }
BlDefiningMethodExamples >> definingMethodCaseSeven [
	<gtExample>
	| aBlock aMethod |
	aBlock := self caseSeven.

	aMethod := aBlock blocDefiningMethod.
	self assert: aMethod equals: BlDefiningMethodExamples >> #caseSeven.

	^ aBlock
]

{ #category : #'examples - defining methods' }
BlDefiningMethodExamples >> definingMethodCaseSix [
	<gtExample>
	| aBlock aMethod |
	aBlock := self definingMethodCaseFour value: false.

	aMethod := aBlock blocDefiningMethod.
	self assert: aMethod isDoIt not.
	self assert: aMethod equals: BlDefiningMethodExamples >> #caseSix.

	^ aBlock
]

{ #category : #'examples - defining methods' }
BlDefiningMethodExamples >> definingMethodCaseThree [
	<gtExample>
	| aBlock aMethod |
	aBlock := self caseOne value value: true.

	aMethod := aBlock blocDefiningMethod.
	self assert: aMethod equals: BlDefiningMethodExamples >> #caseTwo.

	^ aBlock
]

{ #category : #'examples - defining methods' }
BlDefiningMethodExamples >> definingMethodCaseTwo [
	<gtExample>
	| aBlock aMethod |
	aBlock := self caseOne value.

	aMethod := aBlock blocDefiningMethod.
	self assert: aMethod equals: BlDefiningMethodExamples >> #caseTwo.

	^ aBlock
]

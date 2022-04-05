Extension { #name : #WriteStream }

{ #category : #'*Bloc' }
WriteStream >> nextPut: aCollection around: aBlock [
	"aCollection should have 2 elements. The first goes before, the second after the evaluation of aBlock"

	self nextPut: aCollection first.
	aBlock ensure: [ self nextPut: aCollection second ]
]

{ #category : #'*Bloc' }
WriteStream >> parenthesize: aBlock [
	self nextPut: '()' around: aBlock
]

{ #category : #'*Bloc' }
WriteStream >> stringQuote: aBlock [
	self nextPut: '''''' around: aBlock
]

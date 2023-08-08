Extension { #name : #Symbol }

{ #category : #'*Bloc' }
Symbol >> cull: anObject cull: secondArg [
	^ anObject perform: self withEnoughArguments: { secondArg }
]

{ #category : #'*Bloc' }
Symbol >> cull: anObject cull: secondArg cull: thirdArg [
	^anObject perform: self withEnoughArguments: { secondArg. thirdArg }
]

{ #category : #'*Bloc' }
Symbol >> cull: anObject cull: secondArg cull: thirdArg cull: fourthArg [
	^anObject perform: self withEnoughArguments: { secondArg. thirdArg. fourthArg }
]

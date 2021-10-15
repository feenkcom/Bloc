Extension { #name : #Symbol }

{ #category : #'*Bloc' }
Symbol >> cull: anObject cull: secondArg [
	^anObject perform: self.
]

{ #category : #'*Bloc' }
Symbol >> cull: anObject cull: secondArg cull: thirdArg [
	^anObject perform: self.
]

{ #category : #'*Bloc' }
Symbol >> cull: anObject cull: secondArg cull: thirdArg cull: fourthArg [
	^anObject perform: self.
]

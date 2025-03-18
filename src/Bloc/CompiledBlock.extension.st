Extension { #name : #CompiledBlock }

{ #category : #'*Bloc' }
CompiledBlock >> blocDefiningMethod [
	^ self method ifNotNil: #blocDefiningMethod
]

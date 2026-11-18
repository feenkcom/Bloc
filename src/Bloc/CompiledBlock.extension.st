Extension { #name : #CompiledBlock }

{ #category : #'*Bloc' }
CompiledBlock >> blocDefiningMethod [
	^ self method ifNotNil: [ :v | v blocDefiningMethod ]
]

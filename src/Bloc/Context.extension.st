Extension { #name : #Context }

{ #category : #'*Bloc' }
Context >> blocDefiningMethod [
	"Return a CompiledMethod this context belongs to"
	^ self outerMostContext compiledCode blocDefiningMethod
]

{ #category : #'*Bloc' }
Context >> blocMethodDefinition [
	"Return a Ring method definition for the CompiledMethod this context belongs to"

	^ self blocDefiningMethod asRingDefinition
]

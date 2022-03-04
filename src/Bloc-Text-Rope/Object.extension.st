Extension { #name : #Object }

{ #category : #'*Bloc-Text-Rope' }
Object >> asRopedText [
	^ BlRunRopedText string: self asString
]

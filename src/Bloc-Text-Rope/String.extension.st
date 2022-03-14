Extension { #name : #String }

{ #category : #'*Bloc-Text-Rope' }
String >> asRopedText [
	^ BlRunRopedText string: self
]

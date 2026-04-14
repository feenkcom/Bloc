Extension { #name : #BlTextUnderlayAttribute }

{ #category : #'*Bloc-Sparta' }
BlTextUnderlayAttribute >> applyOnTextParagraph: aTextParagraph from: aStartIndex to: aToIndex [
	aTextParagraph highlight: self from: aStartIndex to: aToIndex
]

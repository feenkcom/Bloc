Extension { #name : #TBlWithChildrenTransformation }

{ #category : #'*Bloc-Sparta' }
TBlWithChildrenTransformation >> drawChildrenOnSpartaCanvas: aCanvas [
	self childrenTransformation isIdentity
		ifTrue: [ super drawChildrenOnSpartaCanvas: aCanvas ]
		ifFalse: [
			aCanvas transform
				by: self childrenTransformation matrix
				translated: 0@0
				during: [ :aTransformedCanvas | super drawChildrenOnSpartaCanvas: aCanvas ] ]
]

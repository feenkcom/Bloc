Extension { #name : #TBlWithChildrenTransformation }

{ #category : #'*Bloc-Sparta' }
TBlWithChildrenTransformation >> drawChildrenOnSpartaCanvas: aCanvas [
	"If there are not children no need to draw and clip"
	self hasChildren
		ifFalse: [ ^ self ].

	self childrenTransformation isIdentity
		ifTrue: [ super drawChildrenOnSpartaCanvas: aCanvas ]
		ifFalse: [
			aCanvas clip
				when: [ self clipChildren ]
				by: [ self geometry pathOnSpartaCanvas: aCanvas of: self ]
				during: [
					aCanvas transform
						by: self childrenTransformation matrix
						translated: 0@0
						during: [ :aTransformedCanvas |
						self children sortedByElevation
							do: [ :anElement | anElement fullDrawOnSpartaCanvas: aCanvas ] ] ] ]
]

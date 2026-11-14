Extension { #name : #BlOutskirtsInside }

{ #category : #'*Bloc-Sparta' }
BlOutskirtsInside >> drawBackground: aBackgroundBlock border: aBorderBlock of: anElement onSpartaCanvas: aCanvas [
	aCanvas clip
		when: [ anElement border isTransparent not ]
		by: [ anElement geometry pathOnSpartaCanvas: aCanvas of: anElement ]
		during: aBackgroundBlock.
	anElement border isTransparent ifFalse: [ aBorderBlock value ]
]

{ #category : #'*Bloc-Sparta' }
BlOutskirtsInside >> drawBorder: aBorder path: aPath onSpartaCanvas: aCanvas [
	aCanvas clip
		by: aPath
		during: [ self
				strokeBorder: aBorder
				path: aPath
				width: aBorder width * 2
				onSpartaCanvas: aCanvas ]
]

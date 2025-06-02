Extension { #name : #BlThemeableColor }

{ #category : #'*Bloc-Sparta' }
BlThemeableColor >> asSpartaPaintOn: aSpartaCanvas [
	^ aSpartaCanvas paint color: color
]

{ #category : #'*Bloc-Sparta' }
BlThemeableColor >> asStrokePaintOn: aCanvas [
	^ aCanvas surface createStrokePaintFor: color
]

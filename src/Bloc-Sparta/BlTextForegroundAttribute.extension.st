Extension { #name : #BlTextForegroundAttribute }

{ #category : #'*Bloc-Sparta' }
BlTextForegroundAttribute >> applyOnFontAndStyleBuilder: aBlTextStyleBuilder theme: aBlTheme [
	aBlTextStyleBuilder color: (self paint blocResolveColorForTheme: aBlTheme)
]

{ #category : #'*Bloc-Sparta' }
BlTextForegroundAttribute >> applyOnSpartaTextPainter: aTextPainter theme: aBlTheme [
	aTextPainter paint: (self paint blocResolveColorForTheme: aBlTheme)
]

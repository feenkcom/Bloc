Extension { #name : #BlOutskirtsOutside }

{ #category : #'*Bloc-Sparta' }
BlOutskirtsOutside >> drawBackground: aBackgroundBlock border: aBorderBlock of: anElement onSpartaCanvas: aCanvas [
	anElement border isTransparent ifFalse: [ aBorderBlock value ].
	aBackgroundBlock value
]

{ #category : #'*Bloc-Sparta' }
BlOutskirtsOutside >> drawBorder: aBorder path: aPath onSpartaCanvas: aCanvas [
	aCanvas layer
		during: [ self
				strokeBorder: aBorder
				path: aPath
				width: aBorder width * 2
				onSpartaCanvas: aCanvas.
			aCanvas clip
				by: aPath
				during: [ aCanvas fill
						path: aPath;
						paint: Color white;
						drawOptions: (aCanvas drawOptions
								composeDestOut;
								antialiasGray);
						draw ] ]
]

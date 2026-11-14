Extension { #name : #BlOutskirtsCentered }

{ #category : #'*Bloc-Sparta' }
BlOutskirtsCentered >> drawBackground: aBackgroundBlock border: aBorderBlock of: anElement onSpartaCanvas: aCanvas [

	"draw background"
	aBackgroundBlock value.

	"draw border"
	aBorderBlock value
]

{ #category : #'*Bloc-Sparta' }
BlOutskirtsCentered >> drawBorder: aBorder path: aPath onSpartaCanvas: aCanvas [
	self
		strokeBorder: aBorder
		path: aPath
		width: aBorder width
		onSpartaCanvas: aCanvas
]

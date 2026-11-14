Extension { #name : #BlOutskirts }

{ #category : #'*Bloc-Sparta' }
BlOutskirts >> drawBackground: aBackgroundBlock border: aBorderBlock of: anElement onSpartaCanvas: aCanvas [
	self subclassResponsibility
]

{ #category : #'*Bloc-Sparta' }
BlOutskirts >> drawBorder: aBorder onSpartaCanvas: aCanvas of: anElement [
	self
		drawBorder: aBorder
		path: (anElement geometry pathOnSpartaCanvas: aCanvas of: anElement)
		onSpartaCanvas: aCanvas
]

{ #category : #'*Bloc-Sparta' }
BlOutskirts >> drawBorder: aBorder path: aPath onSpartaCanvas: aCanvas [
	"Draw a border relative to a closed path using this placement strategy."

	self subclassResponsibility
]

{ #category : #'*Bloc-Sparta' }
BlOutskirts >> strokeBorder: aBorder path: aPath width: aWidth onSpartaCanvas: aCanvas [
	aCanvas stroke
		alpha: aBorder opacity;
		paint: aBorder paint;
		path: aPath;
		width: aWidth;
		in: [ :painter | aBorder style applyOn: painter ];
		draw
]

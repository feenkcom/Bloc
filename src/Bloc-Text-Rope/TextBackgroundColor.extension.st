Extension { #name : #TextBackgroundColor }

{ #category : #'*Bloc-Text-Rope' }
TextBackgroundColor >> applyToBlText: aBlText [
	"Apply the receiver to the supplied BlText"

	aBlText highlight: self color
]

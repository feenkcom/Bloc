Extension { #name : #BlBlurEffect }

{ #category : #'*Bloc-Sparta' }
BlBlurEffect >> applyOnSpartaCanvas: aSpartaCanvas for: anElement [
	| anEffectBounds aCanvasTransform aCanvasScale |

	aCanvasTransform := aSpartaCanvas transform current.
	anEffectBounds := aCanvasTransform
		transformRectangle: (SpartaRectangle fromRectangle: anElement effectBounds).
	aCanvasScale := aCanvasTransform scale.
	
	aSpartaCanvas clip
		by: (anElement geometry pathOnSpartaCanvas: aSpartaCanvas of: anElement)
		during: [
			aSpartaCanvas transform
				by: [ :t | t scaleBy: (1.0 / aCanvasScale x) @ (1.0 / aCanvasScale y) ]
				during: [
					aSpartaCanvas filter
						area: anEffectBounds; "source in canvas device coordinates"
						to: 0@0; "destination in local coordinates of canvas"
						type: (aSpartaCanvas filters blur
							stdDeviation: self radius;
							source: aSpartaCanvas);
						draw ] ]
]

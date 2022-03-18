Extension { #name : #BlCrosshairCursor }

{ #category : #'*BlocHost-Glutin' }
BlCrosshairCursor >> asWinitCursor [
	^ WinitCursorIcon Crosshair
]

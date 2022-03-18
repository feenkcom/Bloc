Extension { #name : #BlResizeTopLeftCursor }

{ #category : #'*BlocHost-Glutin' }
BlResizeTopLeftCursor >> asWinitCursor [
	^ WinitCursorIcon NwseResize
]

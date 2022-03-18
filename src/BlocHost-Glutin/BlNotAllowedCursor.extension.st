Extension { #name : #BlNotAllowedCursor }

{ #category : #'*BlocHost-Glutin' }
BlNotAllowedCursor >> asWinitCursor [
	^ WinitCursorIcon NotAllowed
]

Extension { #name : #BlContextMenuCursor }

{ #category : #'*BlocHost-Glutin' }
BlContextMenuCursor >> asWinitCursor [
	^ WinitCursorIcon ContextMenu
]

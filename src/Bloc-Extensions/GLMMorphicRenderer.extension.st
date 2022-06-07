Extension { #name : #GLMMorphicRenderer }

{ #category : #'*Bloc-Extensions' }
GLMMorphicRenderer >> renderBlocPresentation: aBlocPresentation [ 
	| container |

	container := Morph new.
	container color: Color transparent.
	container changeTableLayout.
	container vResizing: #spaceFill.
	container hResizing: #spaceFill.

	^ container
]

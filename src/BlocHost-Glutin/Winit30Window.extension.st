Extension { #name : #Winit30Window }

{ #category : #'*BlocHost-Glutin' }
Winit30Window >> blocCreateCallbackRegistry [
	^ BlWinit30SurfaceCallbackRegistry new
		window: self
]

{ #category : #'*BlocHost-Glutin' }
Winit30Window >> blocCreateHostSpace [
	^ BlWinit30HostSpace new
]

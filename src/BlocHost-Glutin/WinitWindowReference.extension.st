Extension { #name : #WinitWindowReference }

{ #category : #'*BlocHost-Glutin' }
WinitWindowReference >> blocCreateCallbackRegistry [
	^ BlWinitSurfaceCallbackRegistry new
		eventLoop: self eventLoop;
		windowId: self primGetRawId;
		yourself
]

{ #category : #'*BlocHost-Glutin' }
WinitWindowReference >> blocCreateHostSpace [
	^ BlRustWindowingHostSpace new
]

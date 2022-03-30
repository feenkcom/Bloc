Extension { #name : #BlParallelUniverse }

{ #category : #'*BlocHost-Glutin' }
BlParallelUniverse class >> winit [
	<blocHost>

	^ self forHost: BlWinitHost
]

Class {
	#name : #BlWinitSurfaceCallbackRegistry,
	#superclass : #BlHostSurfaceCallbackRegistry,
	#instVars : [
		'windowId',
		'eventLoop'
	],
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #accessing }
BlWinitSurfaceCallbackRegistry >> eventLoop [

	^ eventLoop
]

{ #category : #accessing }
BlWinitSurfaceCallbackRegistry >> eventLoop: anObject [

	eventLoop := anObject
]

{ #category : #'api - callbacks' }
BlWinitSurfaceCallbackRegistry >> onDrawCall: anExternalFunction with: anExternalObject [
	eventLoop
		primOnRedrawCall: anExternalFunction
		with: anExternalObject
		for: windowId
]

{ #category : #'api - callbacks' }
BlWinitSurfaceCallbackRegistry >> onResizeCall: anExternalFunction with: anExternalObject [
	eventLoop
		primOnResizeCall: anExternalFunction
		with: anExternalObject
		for: windowId
]

{ #category : #accessing }
BlWinitSurfaceCallbackRegistry >> windowId [

	^ windowId
]

{ #category : #accessing }
BlWinitSurfaceCallbackRegistry >> windowId: anObject [

	windowId := anObject
]

Class {
	#name : #BlWinit30SurfaceCallbackRegistry,
	#superclass : #BlHostSurfaceCallbackRegistry,
	#instVars : [
		'window'
	],
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #'api - callbacks' }
BlWinit30SurfaceCallbackRegistry >> onDrawCall: anExternalFunction with: anExternalObject [
	window
		primAddRedrawListener: anExternalFunction
		thunk: anExternalObject
]

{ #category : #'api - callbacks' }
BlWinit30SurfaceCallbackRegistry >> onResizeCall: anExternalFunction with: anExternalObject [
	window
		primAddResizeListener: anExternalFunction
		thunk: anExternalObject
]

{ #category : #accessing }
BlWinit30SurfaceCallbackRegistry >> window [
	^ window
]

{ #category : #accessing }
BlWinit30SurfaceCallbackRegistry >> window: anObject [
	window := anObject
]

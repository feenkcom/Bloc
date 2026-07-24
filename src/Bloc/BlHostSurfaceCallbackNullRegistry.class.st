Class {
	#name : #BlHostSurfaceCallbackNullRegistry,
	#superclass : #BlHostSurfaceCallbackRegistry,
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #testing }
BlHostSurfaceCallbackNullRegistry >> isNullRegistry [
	^ true
]

{ #category : #'api - callbacks' }
BlHostSurfaceCallbackNullRegistry >> onDrawCall: anExternalFunction with: anExternalObject [
]

{ #category : #'api - callbacks' }
BlHostSurfaceCallbackNullRegistry >> onResizeCall: anExternalFunction with: anExternalObject [
]

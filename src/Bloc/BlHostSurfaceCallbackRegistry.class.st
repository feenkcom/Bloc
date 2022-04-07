Class {
	#name : #BlHostSurfaceCallbackRegistry,
	#superclass : #Object,
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #testing }
BlHostSurfaceCallbackRegistry >> isNullRegistry [
	^ false
]

{ #category : #'api - callbacks' }
BlHostSurfaceCallbackRegistry >> onDrawCall: anExternalFunction with: anExternalObject [
	self subclassResponsibility
]

{ #category : #'api - callbacks' }
BlHostSurfaceCallbackRegistry >> onResizeCall: anExternalFunction with: anExternalObject [
	self subclassResponsibility
]

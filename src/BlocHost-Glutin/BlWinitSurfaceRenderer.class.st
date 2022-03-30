Class {
	#name : #BlWinitSurfaceRenderer,
	#superclass : #BlHostSurfaceRenderer,
	#instVars : [
		'window'
	],
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #'private - gl' }
BlWinitSurfaceRenderer >> makeCurrent [
	self window isValid
		ifFalse: [ ^ self ].
	
	self window makeCurrent
]

{ #category : #'private - gl' }
BlWinitSurfaceRenderer >> swapBuffers [
	self window swapBuffers
]

{ #category : #accessing }
BlWinitSurfaceRenderer >> window [
	<return: #GlutinWindowedContext>

	^ window
]

{ #category : #accessing }
BlWinitSurfaceRenderer >> window: aGlutinWindowedContext [
	window := aGlutinWindowedContext
]

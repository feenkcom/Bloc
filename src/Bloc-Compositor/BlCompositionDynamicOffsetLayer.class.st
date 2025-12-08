Class {
	#name : #BlCompositionDynamicOffsetLayer,
	#superclass : #BlCompositionContainerLayer,
	#instVars : [
		'offsetFn',
		'payload',
		'cloneFn',
		'freeFn'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #accessing }
BlCompositionDynamicOffsetLayer >> asSymbolTree [
	^ {
		#DynamicOffset.
			self layers collect: [ :eachLayer | eachLayer asSymbolTree ] as: Array
	}
]

{ #category : #accessing }
BlCompositionDynamicOffsetLayer >> name [
	^ 'Dynamic Offset'
]

{ #category : #accessing }
BlCompositionDynamicOffsetLayer >> newSkiaLayer [
	 ^ SkiaCompositionDynamicOffsetLayer
	 	offsetFn: offsetFn
	 	payload: payload
	 	cloneFn: cloneFn
	 	freeFn: freeFn
]

{ #category : #initialization }
BlCompositionDynamicOffsetLayer >> setOffsetFn: anOffsetFn payload: aPayload cloneFn: aCloneFn freeFn: aFreeFn [
	offsetFn := anOffsetFn.
	payload := aPayload.
	cloneFn := aCloneFn.
	freeFn := aFreeFn
]

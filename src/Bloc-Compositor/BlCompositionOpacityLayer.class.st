Class {
	#name : #BlCompositionOpacityLayer,
	#superclass : #BlCompositionContainerLayer,
	#instVars : [
		'opacity'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #accessing }
BlCompositionOpacityLayer >> asSymbolTree [
	^ {
		#Opacity .
			#opacity. self opacity.
			self layers collect: [ :eachLayer | eachLayer asSymbolTree ] as: Array
	}
]

{ #category : #accessing }
BlCompositionOpacityLayer >> name [
	^ 'Opacity'
]

{ #category : #accessing }
BlCompositionOpacityLayer >> newSkiaLayer [
	 ^ SkiaCompositionOpacityLayer opacity: self opacity
]

{ #category : #accessing }
BlCompositionOpacityLayer >> opacity [
	^ opacity
]

{ #category : #accessing }
BlCompositionOpacityLayer >> opacity: anObject [
	opacity := anObject.
	self markNeedsComposition
]

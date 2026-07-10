Class {
	#name : #BlCompositionFilterBelowLayer,
	#superclass : #BlCompositionWithOffsetLayer,
	#instVars : [
		'filter',
		'path'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionFilterBelowLayer >> asSkiaLayer [
	| theChildLayers |

	theChildLayers := self children collect: [ :eachLayer | eachLayer asSkiaLayer ].
	^ self newSkiaLayer withLayers: theChildLayers
]

{ #category : #converting }
BlCompositionFilterBelowLayer >> asSymbolTree [
	^ {
		#FilterBelow .
			#offset . { self offset x . self offset y }.
			#filter . self filter asSymbolTree.
			#path . self path class name.
			self layers collect: [ :eachLayer | eachLayer asSymbolTree ] as: Array
	}
]

{ #category : #accessing }
BlCompositionFilterBelowLayer >> filter [
	^ filter
]

{ #category : #accessing }
BlCompositionFilterBelowLayer >> filter: anObject [
	filter = anObject
		ifFalse: [ self markNeedsComposition ].
	filter := anObject
]

{ #category : #accessing }
BlCompositionFilterBelowLayer >> name [
	^ 'Filter below'
]

{ #category : #converting }
BlCompositionFilterBelowLayer >> newSkiaLayer [
	<return: #SkiaCompositionFilterBelowLayer>
	| aBuilder |

	aBuilder := SkiaCompositorFilterBelowLayerBuilder new
		filter: self filter asSkiaFilter;
		offset: self offset.

	^ self path spartaClipOn: self with: aBuilder
]

{ #category : #accessing }
BlCompositionFilterBelowLayer >> path [
	^ path
]

{ #category : #accessing }
BlCompositionFilterBelowLayer >> path: anObject [
	path := anObject.
	self markNeedsComposition
]

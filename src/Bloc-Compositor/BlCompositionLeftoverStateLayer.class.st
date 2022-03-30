Class {
	#name : #BlCompositionLeftoverStateLayer,
	#superclass : #BlCompositionContainerLayer,
	#instVars : [
		'state'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionLeftoverStateLayer >> asSymbolTree [
	^ {
		#Leftover.
			#state. self state asSymbolTree.
			self layers collect: [ :eachLayer | eachLayer asSymbolTree ] as: Array
	}
]

{ #category : #accessing }
BlCompositionLeftoverStateLayer >> commands [
	<return: #Array of: #BlCompositionPainterStateCommand>
	
	^ self state commands
]

{ #category : #'private - context' }
BlCompositionLeftoverStateLayer >> multiplyOn: aBlMatrix2D [
	self commands do: [ :eachCommand | eachCommand multiplyOn: aBlMatrix2D ]
]

{ #category : #accessing }
BlCompositionLeftoverStateLayer >> name [
	^ 'Leftover state {1}' format: { self state asSymbolTree }
]

{ #category : #converting }
BlCompositionLeftoverStateLayer >> newSkiaLayer [
	^ self state asCompositorCommandsDuring: [ :theLeftoverCommands |
		SkiaCompositionLeftoverStateLayer commands: theLeftoverCommands ]
]

{ #category : #accessing }
BlCompositionLeftoverStateLayer >> offset: anOffset [
	self children do: [ :eachLayer | eachLayer offset: anOffset ]
]

{ #category : #accessing }
BlCompositionLeftoverStateLayer >> state [
	^ state
]

{ #category : #accessing }
BlCompositionLeftoverStateLayer >> state: anObject [
	state := anObject.
	self markNeedsComposition
]

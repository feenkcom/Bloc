Class {
	#name : #BlCompositionPainterState,
	#superclass : #Object,
	#instVars : [
		'commands'
	],
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #'api - playback' }
BlCompositionPainterState >> applyOnCanvas: aCanvas [
	commands reverseDo: [ :eachCommand | eachCommand pushOn: aCanvas ]
]

{ #category : #'api - playback' }
BlCompositionPainterState >> asCompositorCommandsDuring: aBlock [
	^ SkiaCompositorLeftoverCommandsBuilder
		build: [ :aBuilder |
			commands
				reverseDo: [ :eachCommand | eachCommand asCompositorCommandOn: aBuilder ] ]
		during: aBlock
]

{ #category : #converting }
BlCompositionPainterState >> asSymbolTree [
	^ self commands collect: [ :eachCommand | eachCommand asSymbolTree ]
]

{ #category : #'api - commands' }
BlCompositionPainterState >> commands [
	"Return a snapshot of current commands as an array"
	<return: #Array of: #BlCompositionPainterStateCommand>
	
	^ Array
		new: commands size
		streamContents: [ :aStream | commands reverseDo: [ :eachCommand | aStream nextPut: eachCommand ] ]
]

{ #category : #initialization }
BlCompositionPainterState >> initialize [
	super initialize.
	
	commands := Stack new
]

{ #category : #initialization }
BlCompositionPainterState >> initializeWithCommands: aStackOfCommands [
	commands := aStackOfCommands
]

{ #category : #testing }
BlCompositionPainterState >> isEmpty [
	^ commands isEmpty
]

{ #category : #copying }
BlCompositionPainterState >> optimizedCopy [
	| anOptimizedStack |
	
	anOptimizedStack := Stack new.
	commands reverseDo: [ :aNextCommand |
		anOptimizedStack
			ifEmpty: [ anOptimizedStack push: aNextCommand ]
			ifNotEmpty: [
				| aPreviousCommand |
				
				aPreviousCommand := anOptimizedStack top.
				aPreviousCommand
					tryToMergeWith: aNextCommand
					ifMerged: [ :aMergedCommand |
						anOptimizedStack
							pop;
							push: aMergedCommand ]
					ifNot: [ anOptimizedStack push: aNextCommand ] ] ].

	^ self class new initializeWithCommands: anOptimizedStack
]

{ #category : #'api - commands' }
BlCompositionPainterState >> pop [
	^ commands pop
]

{ #category : #copying }
BlCompositionPainterState >> postCopy [
	commands := commands copy
]

{ #category : #'api - commands' }
BlCompositionPainterState >> pushClip: aPath offset: anOffset [
	commands push: (BlCompositionPainterStateClip new clip: aPath; offset: anOffset)
]

{ #category : #'api - commands' }
BlCompositionPainterState >> pushTransform: aMatrix offset: anOffset [
	commands push: (BlCompositionPainterStateTransformation new matrix: aMatrix; offset: anOffset)
]

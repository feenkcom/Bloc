Class {
	#name : #BlCompositionPainterStateClip,
	#superclass : #BlCompositionPainterStateCommand,
	#instVars : [
		'clip'
	],
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #comparing }
BlCompositionPainterStateClip >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ offset = anObject offset and: [ clip = anObject clip ]
]

{ #category : #converting }
BlCompositionPainterStateClip >> asCompositorCommandOn: aCommandsBuilder [
	aCommandsBuilder
		offset: self offset.
	self clip spartaClipOn: self with: aCommandsBuilder
]

{ #category : #converting }
BlCompositionPainterStateClip >> asSymbolTree [
	^ { #Clip . self clip class name }
]

{ #category : #testing }
BlCompositionPainterStateClip >> canBeMergedWith: aStateCommand [
	<return: #Boolean>

	self class = aStateCommand class
		ifFalse: [ ^ false ].

	(clip isKindOf: Rectangle)
		ifFalse: [ ^ false ].

	(aStateCommand clip isKindOf: Rectangle)
		ifFalse: [ ^ false ].

	^ true
]

{ #category : #accessing }
BlCompositionPainterStateClip >> clip [
	^ clip
]

{ #category : #accessing }
BlCompositionPainterStateClip >> clip: anObject [
	clip := anObject
]

{ #category : #accessing }
BlCompositionPainterStateClip >> commandString [
	^ self clip asString
]

{ #category : #comparing }
BlCompositionPainterStateClip >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ offset hash bitXor: clip hash
]

{ #category : #'mathematical functions' }
BlCompositionPainterStateClip >> multiplyOn: aBlMatrix2D [
]

{ #category : #hook }
BlCompositionPainterStateClip >> popOn: aCanvas [
	aCanvas clip pop
]

{ #category : #hook }
BlCompositionPainterStateClip >> pushOn: aCanvas [
	aCanvas clip push: clip offset: offset
]

{ #category : #hook }
BlCompositionPainterStateClip >> pushOnLayer: aSkiaOffsetLayer [	
	
]

{ #category : #testing }
BlCompositionPainterStateClip >> tryToMergeWith: aStateCommand ifMerged: aMergedBlock ifNot: anExceptionBlock [
	| anIntersectedRectangle |

	self class = aStateCommand class
		ifFalse: [ ^ anExceptionBlock value ].

	(clip isKindOf: Rectangle)
		ifFalse: [ ^ anExceptionBlock value ].

	(aStateCommand clip isKindOf: Rectangle)
		ifFalse: [ ^ anExceptionBlock value ].

	anIntersectedRectangle := (clip translateBy: offset)
		intersect: (aStateCommand clip translateBy: aStateCommand offset).
		
	^ aMergedBlock value: (BlCompositionPainterStateClip new
		offset: 0@0;
		clip: anIntersectedRectangle)
]

{ #category : #accessing }
BlCompositionPainterStateClip >> type [
	^ 'Clip'
]

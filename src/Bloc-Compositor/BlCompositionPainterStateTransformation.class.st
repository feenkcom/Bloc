Class {
	#name : #BlCompositionPainterStateTransformation,
	#superclass : #BlCompositionPainterStateCommand,
	#instVars : [
		'matrix'
	],
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #converting }
BlCompositionPainterStateTransformation >> asCompositorCommandOn: aCommandsBuilder [
	aCommandsBuilder
		offset: self offset;
		pushTransform: self matrix
]

{ #category : #converting }
BlCompositionPainterStateTransformation >> asSymbolTree [
	^ { #Transform . self matrix asMatrixCollection asArray }
]

{ #category : #accessing }
BlCompositionPainterStateTransformation >> commandString [
	^ String streamContents: [ :aStream | self matrix decomposition asDictionary associations
		do: [ :eachAssociation | aStream
			nextPutAll: eachAssociation key;
			nextPutAll: ': ';
			nextPutAll: (eachAssociation value printString copyReplaceAll: String cr with: ' ') ]
		separatedBy: [ aStream cr ] ]
]

{ #category : #accessing }
BlCompositionPainterStateTransformation >> matrix [
	^ matrix
]

{ #category : #accessing }
BlCompositionPainterStateTransformation >> matrix: anObject [
	matrix := anObject
]

{ #category : #'mathematical functions' }
BlCompositionPainterStateTransformation >> multiplyOn: aBlMatrix2D [
	aBlMatrix2D translateBy: self offset.
	aBlMatrix2D multiplyBy: self matrix
]

{ #category : #hook }
BlCompositionPainterStateTransformation >> popOn: aCanvas [
	aCanvas transform
		translateBy: offset;
		multiplyBy: matrix;
		pop
]

{ #category : #hook }
BlCompositionPainterStateTransformation >> pushOn: aCanvas [
	aCanvas transform
		translateBy: offset;
		multiplyBy: matrix;
		push
]

{ #category : #accessing }
BlCompositionPainterStateTransformation >> type [
	^ 'Transform'
]

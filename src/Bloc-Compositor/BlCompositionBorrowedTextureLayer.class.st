Class {
	#name : #BlCompositionBorrowedTextureLayer,
	#superclass : #BlCompositionLayer,
	#instVars : [
		'extent',
		'callback',
		'payload'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #'as yet unclassified' }
BlCompositionBorrowedTextureLayer >> asSkiaLayer [
	^ SkiaCompositionTextureLayer
		extent: self extent
		rendering: self callback
		payload: self payload
]

{ #category : #'as yet unclassified' }
BlCompositionBorrowedTextureLayer >> asSymbolTree [
	^ {
		#Texture .
			#extent . self extent.
	}
]

{ #category : #accessing }
BlCompositionBorrowedTextureLayer >> callback [
	^ callback
]

{ #category : #accessing }
BlCompositionBorrowedTextureLayer >> callback: anObject [
	callback := anObject
]

{ #category : #accessing }
BlCompositionBorrowedTextureLayer >> extent [
	^ extent
]

{ #category : #accessing }
BlCompositionBorrowedTextureLayer >> extent: anObject [
	extent := anObject
]

{ #category : #accessing }
BlCompositionBorrowedTextureLayer >> payload [
	^ payload
]

{ #category : #accessing }
BlCompositionBorrowedTextureLayer >> payload: anObject [
	payload := anObject
]

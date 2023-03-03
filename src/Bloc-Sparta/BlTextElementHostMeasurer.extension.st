Extension { #name : #BlTextElementHostMeasurer }

{ #category : #'*Bloc-Sparta' }
BlTextElementHostMeasurer >> fallbackMeasureTextParagraph: aBlTextParagraph of: aTextElement [
	| aCanvas |
	[ aCanvas := Bloc preferableSpartaCanvas offscreen ]
		on: Error
		do: [ :anError |
			NonInteractiveTranscript stderr
				nextPutAll: 'Failed to get offscreen canvas: ';
				nextPutAll: anError printString;
				cr.
			^ self ].

	(BlSpartaCanvasTextMeasurer new canvas: aCanvas)
		measureTextParagraph: aBlTextParagraph
]

{ #category : #'*Bloc-Sparta' }
BlTextElementHostMeasurer >> measureTextParagraph: aBlTextParagraph of: aTextElement [

	self flag: #TODO.
	aTextElement isAttachedToSceneGraph
		ifTrue: [
			aTextElement space
				measureTextParagraph: aBlTextParagraph
				ifNotAvailable: [ self fallbackMeasureTextParagraph: aBlTextParagraph of: aTextElement ] ]
		ifFalse: [ self fallbackMeasureTextParagraph: aBlTextParagraph of: aTextElement ]
]

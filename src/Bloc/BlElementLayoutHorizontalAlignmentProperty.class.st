Class {
	#name : #BlElementLayoutHorizontalAlignmentProperty,
	#superclass : #BlElementLayoutAlignmentProperty,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'api - property' }
BlElementLayoutHorizontalAlignmentProperty >> applyOnElement: anElement [
	anElement layout supportsAlignment
		ifFalse: [ ^ self ].
		
	anElement layout horizontalAlignment = self alignment
		ifTrue: [ ^ self ].
		
	anElement layoutDo: [ :aLayout | aLayout horizontalAlignment: self alignment ]
]

{ #category : #'api - property' }
BlElementLayoutHorizontalAlignmentProperty >> cleanUpOnElement: anElement [
	anElement layout supportsAlignment
		ifFalse: [ ^ self ].
		
	anElement layout horizontalAlignment = BlElementAlignment horizontal null
		ifTrue: [ ^ self ].
		
	anElement layoutDo: [ :aLayout | aLayout horizontalAlignment: BlElementAlignment horizontal null ]
]

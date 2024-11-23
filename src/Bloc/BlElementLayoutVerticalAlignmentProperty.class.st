Class {
	#name : #BlElementLayoutVerticalAlignmentProperty,
	#superclass : #BlElementLayoutAlignmentProperty,
	#category : #'Bloc-Core-Properties'
}

{ #category : #'api - property' }
BlElementLayoutVerticalAlignmentProperty >> applyOnElement: anElement [
	anElement layout supportsAlignment
		ifFalse: [ ^ self ].
		
	anElement layout verticalAlignment = self alignment
		ifTrue: [ ^ self ].
		
	anElement layoutDo: [ :aLayout | aLayout verticalAlignment: self alignment ]
]

{ #category : #'api - property' }
BlElementLayoutVerticalAlignmentProperty >> cleanUpOnElement: anElement [
	anElement layout supportsAlignment
		ifFalse: [ ^ self ].

	anElement layout verticalAlignment = BlElementAlignment vertical null
		ifTrue: [ ^ self ].

	anElement layoutDo: [ :aLayout | aLayout verticalAlignment: BlElementAlignment vertical null ]
]

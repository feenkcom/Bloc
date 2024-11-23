Class {
	#name : #BlFocusabilityNone,
	#superclass : #BlFocusability,
	#category : #'Bloc-Core-Properties'
}

{ #category : #focus }
BlFocusabilityNone >> focusables: anOrderedCollection along: aBlFocusSearchDirection of: anElement [
	"Add focusable elements that are descendants of a given element (possibly including anElement) to anOrderedCollection"
]

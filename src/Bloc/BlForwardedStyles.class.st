"
# Forwarded element styles
Extends {{gtClass:BlAbstractStyles}} by adding an ability to customise {{gtMethod:BlForwardedStyles>>#targetObject}} on which styles are applied.

"
Class {
	#name : #BlForwardedStyles,
	#superclass : #BlAbstractStyles,
	#instVars : [
		'styles',
		'targetObject'
	],
	#category : #'Bloc-Core-Style'
}

{ #category : #'private - adding' }
BlForwardedStyles >> newStyleForState: aBlElementState [
	^ BlElementForwardedStyle new
		state: aBlElementState;
		targetObject: self targetObject
]

{ #category : #accessing }
BlForwardedStyles >> styles [
	^ styles
]

{ #category : #private }
BlForwardedStyles >> styles: aCollectionOfStyles [
	"Private! #styles must be correctly initialized with a proper sorted collection"

	styles := aCollectionOfStyles
]

{ #category : #accessing }
BlForwardedStyles >> targetObject [
	^ targetObject
]

{ #category : #accessing }
BlForwardedStyles >> targetObject: anObject [
	targetObject := anObject
]

Class {
	#name : #BlEagerStyles,
	#superclass : #BlAbstractStyles,
	#instVars : [
		'styles'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #converting }
BlEagerStyles >> asForwarded: aTargetObject [
	^ BlForwardedStyles new
		styles: (self styles collect: [ :eachStyle | eachStyle asForwarded: aTargetObject ]);
		targetObject: aTargetObject
]

{ #category : #initialization }
BlEagerStyles >> initialize [
	super initialize.

	styles := OrderedCollection new: 10
]

{ #category : #'private - instance creation' }
BlEagerStyles >> newStyleForState: anElementState [
	^ BlElementStyle new state: anElementState
]

{ #category : #private }
BlEagerStyles >> styleFor: anElementState [
	<return: #BlElementStyle>

	^ styles
		detect: [ :eachStyle | eachStyle state = anElementState ]
		ifNone: [
			| aNewStyle |
			aNewStyle := self newStyleForState: anElementState.
			styles add: aNewStyle.
			aNewStyle ]
]

{ #category : #private }
BlEagerStyles >> styles [
	<return: #Collection of: #BlElementStyle>

	^ styles
]

{ #category : #enumerating }
BlEagerStyles >> stylesDo: aBlock [
	styles do: aBlock
]

{ #category : #'api - styles' }
BlEagerStyles >> when: aState style: aStyleBlock [
	aStyleBlock value: (self styleFor: aState)
]

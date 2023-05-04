Class {
	#name : #BlStatelessStyles,
	#superclass : #BlAbstractStyles,
	#instVars : [
		'styles'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #initialization }
BlStatelessStyles >> initialize [
	super initialize.

	styles := BlEagerStyles new
]

{ #category : #'api - styles' }
BlStatelessStyles >> stylesDo: aBlock [
	styles stylesDo: aBlock
]

{ #category : #'api - styles' }
BlStatelessStyles >> when: aState style: aStyleBlock [
	aState optionalEventHandlerDo: [ :anEventhandler |
		self error: ('Can not define a stateless style because {1} requires an event handler {2}' format: { aState . anEventhandler }) ].

	styles when: aState style: aStyleBlock
]

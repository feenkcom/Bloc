Class {
	#name : #BlTextAttributesRunFinder,
	#superclass : #Object,
	#traits : 'TBlTextAttributesFinder',
	#classTraits : 'TBlTextAttributesFinder classTrait',
	#instVars : [
		'attributes'
	],
	#category : #'Bloc-Text-Text-Attributes Finder'
}

{ #category : #enumerating }
BlTextAttributesRunFinder >> findAttribute: aBlTextAttribute indicesDo: aBlock [
	| first last |
	attributes
		withStartStopAndValueDo: [ :start :stop :value | 
			(value includes: aBlTextAttribute)
				ifTrue: [ first ifNil: [ first := start ].
					last := stop ]
				ifFalse: [ first
						ifNotNil: [ aBlock
								cull: first
								cull: last
								cull: aBlTextAttribute ] ] ].
	first
		ifNotNil: [ aBlock
				cull: first
				cull: last
				cull: aBlTextAttribute ]
]

{ #category : #enumerating }
BlTextAttributesRunFinder >> findAttributesSuchThat: aFilterBlock indicesDo: anIterationBlock [
	attributes
		withStartStopAndValueDo:
			[ :start :stop :value | 
			value
				select: aFilterBlock
				thenDo:
					[ :att | 
					anIterationBlock
						cull: start
						cull: stop
						cull: att ] ]
]

{ #category : #accessing }
BlTextAttributesRunFinder >> initializeForText: aBlText [
	attributes := aBlText attributeRuns
]

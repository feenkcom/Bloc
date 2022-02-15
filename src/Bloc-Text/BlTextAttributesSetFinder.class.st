Class {
	#name : #BlTextAttributesSetFinder,
	#superclass : #Object,
	#traits : 'TBlTextAttributesFinder',
	#classTraits : 'TBlTextAttributesFinder classTrait',
	#instVars : [
		'attributes'
	],
	#category : #'Bloc-Text-Text-Attributes Finder'
}

{ #category : #enumerating }
BlTextAttributesSetFinder >> findAttribute: aBlTextAttribute indicesDo: aBlock [
	attributes
		do:
			[ :assoc | 
			(assoc value includes: aBlTextAttribute)
				ifTrue:
					[ aBlock
						cull: assoc key first
						cull: assoc key last
						cull: aBlTextAttribute ] ]
]

{ #category : #enumerating }
BlTextAttributesSetFinder >> findAttributesSuchThat: aFilterBlock indicesDo: anIterationBlock [
	attributes
		do:
			[ :assoc | 
			assoc value
				do:
					[ :attr | 
					(aFilterBlock value: attr)
						ifTrue:
							[ anIterationBlock
								cull: assoc key first
								cull: assoc key last
								cull: attr ] ] ]
]

{ #category : #accessing }
BlTextAttributesSetFinder >> initializeForText: aBlText [
	attributes := aBlText newAttributes
]

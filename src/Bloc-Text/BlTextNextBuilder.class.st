Class {
	#name : #BlTextNextBuilder,
	#superclass : #Object,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'stream',
		'attributesBuilder'
	],
	#category : #'Bloc-Text-Builder'
}

{ #category : #accessing }
BlTextNextBuilder >> attribute: anAttribute [
	self attributesBuilder attribute: anAttribute
]

{ #category : #accessing }
BlTextNextBuilder >> attributes: aCollection [
	attributesBuilder attributes: aCollection
]

{ #category : #accessing }
BlTextNextBuilder >> attributesBuilder [
	^ attributesBuilder
]

{ #category : #accessing }
BlTextNextBuilder >> attributesBuilder: anAttributesBuilder [
	attributesBuilder := anAttributesBuilder
]

{ #category : #accessing }
BlTextNextBuilder >> cr [
	self put: Character cr
]

{ #category : #accessing }
BlTextNextBuilder >> initialize [
	attributesBuilder := BlTextAttributesBuilder new
]

{ #category : #accessing }
BlTextNextBuilder >> print: anObject [
	self putAll: anObject asString
]

{ #category : #accessing }
BlTextNextBuilder >> put: aCharacter [
	self putAll: aCharacter asString
]

{ #category : #accessing }
BlTextNextBuilder >> putAll: aString [
	"We should only modify the editor from within the UI thread"

	stream insertString: aString withAttributes: attributesBuilder attributes
]

{ #category : #accessing }
BlTextNextBuilder >> show: anObject [
	self print: anObject
]

{ #category : #accessing }
BlTextNextBuilder >> showException: anException [
	| stack |
	
	stack := anException signalerContext stack.

	self 
		expanding: [ 
			| button list card |
			button := anException asDebuggableElement vFitContent.
			list := (GtPhlowView empty list items: stack) asElementDo: #yourself.
			card := list asVerticallyResizableDo: [ :aContainer |
				aContainer addChild: button at: 1.
				aContainer layout: BlLinearLayout vertical.
				aContainer padding: (BlInsets all: 10).
				aContainer constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 200 ] ].
			card addAptitude: GtPreviewAptitude new.
			card ];
		print: anException
]

{ #category : #accessing }
BlTextNextBuilder >> space [
	self put: Character space
]

{ #category : #accessing }
BlTextNextBuilder >> stream [
	^ stream
]

{ #category : #accessing }
BlTextNextBuilder >> stream: aBlTextStream [
	stream := aBlTextStream
]

{ #category : #accessing }
BlTextNextBuilder >> tab [
	self put: Character tab
]

{ #category : #accessing }
BlTextNextBuilder >> with: aBlock [
	| previewAttribute |
	previewAttribute := BrGlamorousTriangleExpanderTextAttribute new
			attributesCreatingBlock: aBlock.
	attributesBuilder attribute: previewAttribute
]

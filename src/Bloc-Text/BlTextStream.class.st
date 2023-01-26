Class {
	#name : #BlTextStream,
	#superclass : #Object,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'text',
		'attributesBuilder'
	],
	#category : #'Bloc-Text-Builder'
}

{ #category : #accessing }
BlTextStream >> << anObject [
	self show: anObject
]

{ #category : #private }
BlTextStream >> attribute: anAttribute [
	attributesBuilder attribute: anAttribute
]

{ #category : #private }
BlTextStream >> attributes: aCollection [
	attributesBuilder attributes: aCollection
]

{ #category : #accessing }
BlTextStream >> attributesBuilder [
	^ attributesBuilder
]

{ #category : #accessing }
BlTextStream >> clear [
	text deleteAll
]

{ #category : #accessing }
BlTextStream >> contents [
	^ text
]

{ #category : #accessing }
BlTextStream >> cr [
	self next cr
]

{ #category : #accessing }
BlTextStream >> crShow: anObject [
	self 
		cr; 
		show: anObject
]

{ #category : #accessing }
BlTextStream >> gtLiveFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Text';
		text: [ self contents ]
]

{ #category : #accessing }
BlTextStream >> initialize [
	super initialize.
	text := '' asRopedText.
	attributesBuilder := BlTextAttributesBuilder new
]

{ #category : #accessing }
BlTextStream >> insertString: aString withAttributes: aCollection [
	text append: (aString asRopedText attributes: aCollection)
]

{ #category : #accessing }
BlTextStream >> next [
	"This is a utility method for enabling a fluent API"

	^ BlTextNextBuilder new
		stream: self;
		attributesBuilder: attributesBuilder copy
]

{ #category : #accessing }
BlTextStream >> nextPut: aCharacter [
	self next put: aCharacter
]

{ #category : #accessing }
BlTextStream >> nextPutAll: aString [
	self next putAll: aString
]

{ #category : #accessing }
BlTextStream >> print: anObject [
	self next print: anObject
]

{ #category : #accessing }
BlTextStream >> show: anObject [
	self print: anObject
]

{ #category : #accessing }
BlTextStream >> showException: anException [
	self next showException: anException.
	self cr
]

{ #category : #accessing }
BlTextStream >> space [
	self next space
]

{ #category : #accessing }
BlTextStream >> tab [
	self next tab
]

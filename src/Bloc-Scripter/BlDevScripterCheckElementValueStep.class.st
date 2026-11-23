Class {
	#name : #BlDevScripterCheckElementValueStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'valueBlock',
		'equalsBlock'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterCheckElementValueStep >> assert: actual equals: expected [
	self
		assert: actual = expected
		description: [ self assertionDescriptionWithActual: actual expected: expected ]
]

{ #category : #accessing }
BlDevScripterCheckElementValueStep >> assert: actual sameContentAs: expected [
	"Like #assert:equals:, but a String and a Symbol with the same characters match (see #sameContentAs:)"

	self
		assert: (actual sameContentAs: expected)
		description: [ self assertionDescriptionWithActual: actual expected: expected ]
]

{ #category : #actions }
BlDevScripterCheckElementValueStep >> assertActual: anActualValue expected: anExpectedValue [
	"Compare the computed value with the expected one"

	self assert: anActualValue equals: anExpectedValue
]

{ #category : #private }
BlDevScripterCheckElementValueStep >> assertionDescriptionWithActual: actual expected: expected [
	^ String
		streamContents: [ :stream |
			stream
				nextPutAll: 'Assertion failed. Got ';
				nextPutAll: actual fullPrintString;
				nextPutAll: ' instead of ';
				nextPutAll: expected fullPrintString;
				nextPutAll: ' while executing ';
				print: self label;
				nextPutAll: '.' ]
]

{ #category : #accessing }
BlDevScripterCheckElementValueStep >> defaultLabel [
	^ self valueBlock 
		ifNotNil: [ :aBlock | aBlock printStringLimitedTo: 42 ] 
		ifNil: [ self className ]
]

{ #category : #accessing }
BlDevScripterCheckElementValueStep >> equalsBlock [
	^ equalsBlock
]

{ #category : #accessing }
BlDevScripterCheckElementValueStep >> equalsBlock: anObject [
	equalsBlock := anObject
]

{ #category : #actions }
BlDevScripterCheckElementValueStep >> playOn: aScripter [
	| anElement anActualValue anExpectedValue |

	anElement := self target findTargetStartingInScripter: aScripter.
	self
		assert: [ self valueBlock isNotNil ]
		description: [ 'Value block must be defined' ].

	anActualValue := self valueBlock cull: anElement cull: aScripter userData.
	anExpectedValue := self equalsBlock isClosure
			ifTrue: [ self equalsBlock cull: anElement cull: aScripter userData ]
			ifFalse: [ self equalsBlock value ] .

	self
		assertActual: anActualValue
		expected: anExpectedValue
]

{ #category : #accessing }
BlDevScripterCheckElementValueStep >> valueBlock [
	^ valueBlock
]

{ #category : #accessing }
BlDevScripterCheckElementValueStep >> valueBlock: anObject [
	valueBlock := anObject
]

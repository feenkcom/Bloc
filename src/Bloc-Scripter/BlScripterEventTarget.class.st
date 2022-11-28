"
Uses an event of a specific class as a target. If there are multiple matching events picks the one according to the specified index.
"
Class {
	#name : #BlScripterEventTarget,
	#superclass : #BlDevScripterTarget,
	#instVars : [
		'eventClass',
		'eventIndex'
	],
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #accessing }
BlScripterEventTarget >> eventClass [

	^ eventClass
]

{ #category : #accessing }
BlScripterEventTarget >> eventClass: anObject [

	eventClass := anObject
]

{ #category : #accessing }
BlScripterEventTarget >> eventIndex [

	^ eventIndex
]

{ #category : #accessing }
BlScripterEventTarget >> eventIndex: anObject [

	eventIndex := anObject
]

{ #category : #searching }
BlScripterEventTarget >> findTargetIn: anElement [
	<return: #BlElement>
	AssertionFailure signal: 'Scripter events cannot be accessed from an element'
]

{ #category : #searching }
BlScripterEventTarget >> findTargetStartingInScripter: aScripter [
	| theEvents |

	theEvents := aScripter events reversed select: [ :eachEvent | eachEvent isKindOf: eventClass ].

	self
		assert: [ theEvents size >= eventIndex ]
		description: [ 'Found {1} matching events of class {2}, while there must be at least {3}' format: { theEvents size . eventClass . eventIndex } ].
		
	^ theEvents at: eventIndex
]

{ #category : #initialization }
BlScripterEventTarget >> initialize [
	super initialize.
	
	eventClass := BlEvent.
	eventIndex := 1
]

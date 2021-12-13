Class {
	#name : #BlDevScripterOneElementQueryEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#traits : 'TBlElementQuery',
	#classTraits : 'TBlElementQuery classTrait',
	#instVars : [
		'query'
	],
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #searching }
BlDevScripterOneElementQueryEventTarget >> findTargetIn: anElement [
	<return: #BlElement>
	| aResult |
	
	aResult := query findOne: anElement.
	aResult hasResult
		ifFalse: [ AssertionFailure signal: 'Could not find an element for ', query printString ].

	^ aResult lastResult anyOne
]

{ #category : #initialization }
BlDevScripterOneElementQueryEventTarget >> initialize [
	super initialize.
	
	query := BlElementLazyQuery new
]

{ #category : #accessing }
BlDevScripterOneElementQueryEventTarget >> queryStep: aBlElementStep [
	query queryStep: aBlElementStep
]

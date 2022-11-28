Class {
	#name : #BlScripterElementTarget,
	#superclass : #BlDevScripterTarget,
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #testing }
BlScripterElementTarget class >> isAbstract [
	^ self name = #BlScripterElementTarget 
]

{ #category : #testing }
BlScripterElementTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ false
]

{ #category : #enumerating }
BlScripterElementTarget class >> targetInstanceFor: anObject [
	"I am used by ${class:BlDevScripterNestedChildEventTarget}$.
	I return a subclass that handles given input."
	<return: #BlScripterElementTarget>
	self subclassesDo: [ :eachSubclass | 
		(eachSubclass matchesWithInput: anObject) ifTrue: [ ^ eachSubclass newFromInput: anObject ] ].
	self error: 'Cannot find a suitable class for ', anObject printString.
]

{ #category : #updating }
BlScripterElementTarget >> updateUsing: aScripterEventTarget on: aStep [
	| aNestedTarget |
	aNestedTarget := BlDevScripterNestedChildEventTarget new.
	aNestedTarget targets: { self. aScripterEventTarget }.
	aStep target: aNestedTarget.
]

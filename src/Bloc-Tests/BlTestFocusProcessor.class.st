Class {
	#name : #BlTestFocusProcessor,
	#superclass : #BlFocusProcessor,
	#instVars : [
		'firedEvents'
	],
	#category : 'Bloc-Tests-Universe'
}

{ #category : #'event firing' }
BlTestFocusProcessor >> dispatchEvent: anEvent target: aTarget [
	firedEvents add: anEvent
]

{ #category : #accessing }
BlTestFocusProcessor >> firedEvents [
	^ firedEvents
]

{ #category : #'event firing' }
BlTestFocusProcessor >> fireEvent: anEvent [
	firedEvents add: anEvent.

	^ super fireEvent: anEvent
]

{ #category : #initialization }
BlTestFocusProcessor >> initialize [
	super initialize.
	firedEvents := LinkedList new.
	
]

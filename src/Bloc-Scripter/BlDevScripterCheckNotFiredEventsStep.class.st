Class {
	#name : #BlDevScripterCheckNotFiredEventsStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'events'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #asserting }
BlDevScripterCheckNotFiredEventsStep >> assertEventClass: anEventClass withTarget: aBlElement on: aScripter [ 
	| theInterestingEvents |

	theInterestingEvents := aScripter events select: [ :eachEvent | 
		eachEvent class = anEventClass and: [ eachEvent target = aBlElement ] ].

	self
		assert: theInterestingEvents size isZero
		description: [ '{1} should have not been fired, but was fired {2} times.' format: { anEventClass . theInterestingEvents size } ]
]

{ #category : #accessing }
BlDevScripterCheckNotFiredEventsStep >> defaultLabel [
	^ 'Check {1} not fired' format: { events }
]

{ #category : #accessing }
BlDevScripterCheckNotFiredEventsStep >> event: aClass [ 
	self events: { aClass }
]

{ #category : #accessing }
BlDevScripterCheckNotFiredEventsStep >> events [
	<return: #Collection of: #BlEvent>

	^ events
]

{ #category : #accessing }
BlDevScripterCheckNotFiredEventsStep >> events: aCollection [
	<return: #Collection of: #BlEvent>
	self 
		assert: [ aCollection isCollection and: [ aCollection isNotEmpty ] ]
		description: [ 'Collection of events must be non-empty' ].
	events := aCollection
]

{ #category : #actions }
BlDevScripterCheckNotFiredEventsStep >> playOn: aScripter [
	| anElement |

	self
		assert: [ self events isCollection and: [ self events isNotEmpty ] ]
		description: [ 'Expected events must be defined' ]. 

	anElement := self target findTargetStartingInScripter: aScripter.
	self events do: [ :eachEventClass | 
		self assertEventClass: eachEventClass withTarget: anElement on: aScripter ].
]

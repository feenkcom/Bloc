"
I check whether particular {{gtClass:BlEvent}} events were fired on a {{gtClass:BlElement}} target.

## Example

Here you can see how to configure a fire and check a click event on a child element:
{{gtExample:BlScripterExamples>>#clickCheck|previewExpanded=true|previewHeight=400}}


"
Class {
	#name : #BlDevScripterCheckFiredEventsStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'events',
		'amountOfTimes'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterCheckFiredEventsStep >> amountOfTimes: anObject [

	amountOfTimes := anObject
]

{ #category : #asserting }
BlDevScripterCheckFiredEventsStep >> assertEventClass: anEventClass withTarget: aBlElement on: aScripter [ 
	| theInterestingEvents |

	theInterestingEvents := aScripter events select: [ :eachEvent | 
		eachEvent class = anEventClass and: [ eachEvent target = aBlElement ] ].

	amountOfTimes
		ifNotNil: [
			self
				assert: theInterestingEvents size
				equals: amountOfTimes ]
		ifNil: [ self assert: theInterestingEvents isNotEmpty ]
]

{ #category : #accessing }
BlDevScripterCheckFiredEventsStep >> defaultLabel [
	^ 'Click Check'
]

{ #category : #accessing }
BlDevScripterCheckFiredEventsStep >> event: aClass [ 
	self events: { aClass }
]

{ #category : #accessing }
BlDevScripterCheckFiredEventsStep >> events [
	<return: #Collection of: #BlEvent>

	^ events
]

{ #category : #accessing }
BlDevScripterCheckFiredEventsStep >> events: aCollection [
	<return: #Collection of: #BlEvent>
	self 
		assert: [ aCollection isCollection and: [ aCollection isNotEmpty ] ]
		description: [ 'Collection of events must be non-empty' ].
	events := aCollection
]

{ #category : #initialization }
BlDevScripterCheckFiredEventsStep >> initialize [
	super initialize.
	
	"any amount of times"
	amountOfTimes := nil
]

{ #category : #actions }
BlDevScripterCheckFiredEventsStep >> playOn: aScripter [
	| anElement |

	self
		assert: [ self events isCollection and: [ self events isNotEmpty ] ]
		description: [ 'Expected events must be defined' ]. 
	anElement := self target findTargetStartingInScripter: aScripter.
	self events do: [ :eachEventClass | 
		self assertEventClass: eachEventClass withTarget: anElement on: aScripter ].
]

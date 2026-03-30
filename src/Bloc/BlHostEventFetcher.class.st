"
I am the abstract class for event queue management

"
Class {
	#name : #BlHostEventFetcher,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'eventQueue',
		'hostSpace'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #accessing }
BlHostEventFetcher class >> hostSpace: aBlHostSpace [
	^ self basicNew initialize hostSpace: aBlHostSpace
]

{ #category : #accessing }
BlHostEventFetcher class >> new [
	self error: 'Do not create an instance of ', self name, ' using new. Please use #hostSpace: instead'
]

{ #category : #'event processing' }
BlHostEventFetcher >> enqueueEvent: aBlEvent [
	"Enqueue a given Bloc Event in the event queue.
	Do not use me directly, instead rely on #enqueueEvent: from HostSpace"

	eventQueue nextPut: aBlEvent.
	self hostSpace space ifNotNil: [ :aSpace | aSpace requestNextPulse ]
]

{ #category : #'event processing' }
BlHostEventFetcher >> fetchedEventsDo: aBlock [
	"I flush the event queue and evaluate a given block with every queued event as an argument.
	In case there are multiple events of the same kind that can be skipped (such as mouse movements),
	I will also collapse them into a single event, by only flushing the newest one."

	| theEvents |
	theEvents := LinkedList new.
	eventQueue
		flush: [ :anEvent | 
			| theLastEventLink |
			(anEvent canBeCollapsed
				and: [ theEvents isNotEmpty
						and: [ (theLastEventLink := theEvents lastLink) value class = anEvent class ] ])
				ifTrue: [ theLastEventLink value: anEvent ]
				ifFalse: [ theEvents add: anEvent ] ].
	theEvents do: aBlock
]

{ #category : #accessing }
BlHostEventFetcher >> hostSpace [
	^ hostSpace
]

{ #category : #accessing }
BlHostEventFetcher >> hostSpace: anObject [
	hostSpace := anObject
]

{ #category : #'initialize-release' }
BlHostEventFetcher >> initialize [
	super initialize.

	eventQueue := WaitfreeQueue new
]

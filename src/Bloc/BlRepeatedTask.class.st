"
Repeated task is executed over and over again with an optional {{gtMethod:BlRepeatedTask>>#delay}} between loops.

A repeated task re-enqueues itself with its element when that element is removed from the scene graph. See <https://github.com/feenkcom/gtoolkit/issues/1840>.
See the {{gtMethod:name=BlRepeatedTask>>#run:}} and {{gtMethod:BlRepeatedTask>>#elementRemovedFromSceneGraphEvent:}} methods.


"
Class {
	#name : #BlRepeatedTask,
	#superclass : #BlTask,
	#instVars : [
		'delay',
		'element',
		'time',
		'previousRunTime',
		'isRunning',
		'isStopped',
		'eventHandler'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #accessing }
BlRepeatedTask >> delay [
	<return: #Duration>

	^ delay
]

{ #category : #accessing }
BlRepeatedTask >> delay: aDuration [
	delay := aDuration
]

{ #category : #accessing }
BlRepeatedTask >> element [
	^ element
]

{ #category : #'private - event handling' }
BlRepeatedTask >> elementRemovedFromSceneGraphEvent: anEvent [
	isRunning := false.
	isStopped
		ifTrue: [
			self privateUnregisterEventHandler ]
		ifFalse: [
			self setNew.
			element enqueueTask: self ]
]

{ #category : #initialization }
BlRepeatedTask >> initialize [
	super initialize.
	
	delay := 500 milliSeconds.
	time := BlTime real.
	isRunning := true.
	isStopped := false.
	eventHandler := BlEventHandler on: BlElementRemovedFromSceneGraphEvent sendTo: self.
]

{ #category : #'api - testing' }
BlRepeatedTask >> isRunning [
	<return: #Boolean>

	^ isRunning
]

{ #category : #'api - testing' }
BlRepeatedTask >> isStopped [
	<return: #Boolean>

	^ isStopped
]

{ #category : #hooks }
BlRepeatedTask >> onEnqueued: aBlSpace [
	super onEnqueued: aBlSpace.

	self time: aBlSpace time.
]

{ #category : #hooks }
BlRepeatedTask >> onEnqueuedInElement: anElement [
	super onEnqueuedInElement: anElement.

	"when a task is enqueued in an element it means that a user wanted to run, so we mark the task and running and not stopped"
	isRunning := true.
	isStopped := false.
	previousRunTime := nil.
	
	element == anElement
		ifTrue: [ ^ self ].

	self privateUnregisterEventHandler.
	element := anElement.
	element addEventHandler: eventHandler
]

{ #category : #'api - running' }
BlRepeatedTask >> onRun [
	"Override me to implement a custom action"
]

{ #category : #private }
BlRepeatedTask >> privateUnregisterEventHandler [
	"Unregister my event handler from an element if it is attached and forget that element"

	element ifNotNil: [ :aPreviousElement | aPreviousElement removeEventHandler: eventHandler ].		
	element := nil
]

{ #category : #'api - running' }
BlRepeatedTask >> run: aWaker [
	"Enhancement: a repeated task should re-enqueue itself with 
	its element when that element is removed from the scene graph. 
	See *https://github.com/feenkcom/gtoolkit/issues/1840*."

	self shouldContinue
		ifFalse: [ ^ self ].

	"if the task was never ran"
	(previousRunTime isNil or: [
		"or the delay expired"
		previousRunTime + self delay <= self time now ])
			ifTrue: [
				self onRun.
				previousRunTime := self time now ].
	
	"as part of the task execution it is possible that the task was cancelled, so we should check one more time"
	self shouldContinue
		ifFalse: [ ^ self stop ].

	aWaker
		wakeUp: self
		at: previousRunTime + self delay
]

{ #category : #'private - testing' }
BlRepeatedTask >> shouldContinue [
	"Return true if the repeated task should continue, false otherwise.
	The task should stop if an element was removed from the scene graph or #stop was explicitly called"
	<return: #Boolean>
	
	^ self isRunning and: [ element notNil and: [ element isAttachedToSceneGraph ] ]
]

{ #category : #'api - running' }
BlRepeatedTask >> stop [
	"Request the task to stop repeating"

	isStopped := true.
	
	"stopped ask should not be running"
	isRunning := false.

	"stopping a repeated task removes an event handler"
	self privateUnregisterEventHandler.
	
	self setNew
]

{ #category : #accessing }
BlRepeatedTask >> time [
	<return: #BlTime>

	^ time
]

{ #category : #accessing }
BlRepeatedTask >> time: aBlTime [
	time := aBlTime
]

"
I am the Bloc main loop.
I indicate to the Universe that is time to synchronize the state of the elements. 

A pulse is fired every 16ms (if possible) to obtain 60 frames per second (fps) maximum.  This may be delayed if there are background processes wanting to run (to ensure that background calculation of UI elements can complete).  See {{gtMethod:name=BlHostPulseLoop>>#wait}} for details of how the loop time is regulated.

The opened spaces listen the pulse to be synchronized and to update their state when it is needed.

"
Class {
	#name : #BlHostPulseLoop,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'hostClass',
		'pulsePeriod',
		'pulseStartTime',
		'loopProcess'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'instance creation' }
BlHostPulseLoop class >> forHost: aHostClass [
	^ self basicNew initialize hostClass: aHostClass
]

{ #category : #'instance creation' }
BlHostPulseLoop class >> new [
	self error: 'Use #forUniverse: instead'
]

{ #category : #accessing }
BlHostPulseLoop class >> processId [
	^ 'Bloc Main Loop'
]

{ #category : #'loop process' }
BlHostPulseLoop >> createLoopProcess [
	^ self createLoopTask newProcess
		priority: 40;
		name: self processId;
		yourself
]

{ #category : #'loop process' }
BlHostPulseLoop >> createLoopTask [
	^ [
		[ self firePulse. loopProcess == Processor activeProcess. ] whileTrue
	]
]

{ #category : #period }
BlHostPulseLoop >> defaultPulsePeriod [
	"Allows up to 120fps"

	^ 8 milliSeconds
]

{ #category : #'loop process' }
BlHostPulseLoop >> firePulse [
	| aUniverse |	
	
	pulseStartTime := DateAndTime now.
	
	aUniverse := BlParallelUniverse forHost: hostClass.
	aUniverse waitNextPulse.
	
	aUniverse pulse.
	self wait
]

{ #category : #'loop process' }
BlHostPulseLoop >> forceStartNewUIProcess [
	"I should only be used by the logic for opening the debugger.
	
	I create and start a new UI thread without stopping the previous one.
	Normally this leads to incorrect behaviou in Bloc UI process. However 
	if I am called from the current Bloc UI process when an error happened in 
	the actual process, and after calling me my sender terminates or suspends 
	the process my usage should be safe."
	
	loopProcess := self createLoopProcess.
	loopProcess resume.
]

{ #category : #'loop process' }
BlHostPulseLoop >> forceStartOfUIProcess: aProces [
	"I should only be used by the logic for closing the debugger."
	
	loopProcess := aProces.
	loopProcess resume.
]

{ #category : #accessing }
BlHostPulseLoop >> hostClass [
	^ hostClass
]

{ #category : #accessing }
BlHostPulseLoop >> hostClass: aHostClass [
	hostClass := aHostClass
]

{ #category : #initialization }
BlHostPulseLoop >> initialize [
	super initialize.

	pulseStartTime := DateAndTime now.
	pulsePeriod := self defaultPulsePeriod
]

{ #category : #testing }
BlHostPulseLoop >> isRunning [
	^ loopProcess isNotNil and: [ loopProcess isTerminated not ]
]

{ #category : #testing }
BlHostPulseLoop >> isRunningInTheSameProcess [
	^ Processor activeProcess effectiveProcess == loopProcess
]

{ #category : #accessing }
BlHostPulseLoop >> loopProcess [
	^ loopProcess
]

{ #category : #'loop process' }
BlHostPulseLoop >> processId [
	^ self class processId
]

{ #category : #period }
BlHostPulseLoop >> pulsePeriod [
	^ pulsePeriod
]

{ #category : #period }
BlHostPulseLoop >> pulsePeriod: aTime [
	^ pulsePeriod := aTime
]

{ #category : #lifecycle }
BlHostPulseLoop >> start [
	self isRunning
		ifTrue: [ ^ self ].

	loopProcess := self createLoopProcess.
	loopProcess resume
]

{ #category : #lifecycle }
BlHostPulseLoop >> stop [
	| currentProcess |
	
	self isRunning
		ifFalse: [ ^ self ].
	
	self
		assert: [ loopProcess isNotNil ]
		description: [ 'Loop process must exist!' ].

	currentProcess := loopProcess.
	loopProcess := nil.
	currentProcess terminate
]

{ #category : #period }
BlHostPulseLoop >> wait [
	"Wait the appropriate amount of time for the next pulse"
	| milliSecs |

	"milliSecs is the amount of time to wait for the next pulse.
	Since a pulse can take longer than #pulsePeriod (16ms) milliSecs may be negative here
	(meaning that we shouldn't wait for the next pulse)"
	milliSecs := (self pulsePeriod - (DateAndTime now - pulseStartTime)).
	milliSecs := milliSecs max: 0 milliSeconds.
	
	BlPulseStatSignal duration: milliSecs delayForced: false.
	
	"unfortunately, pharo's #wait precision is quite low and usually results in
	the real delay being x2 of the requested, therefore we only wait for hald the duration"
	milliSecs > 2 milliSeconds
		ifTrue: [ (milliSecs // 2) wait ]
]
